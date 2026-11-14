import 'dart:async';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class BillNotificationService with WidgetsBindingObserver {
  BillNotificationService._();

  static final BillNotificationService instance = BillNotificationService._();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  static const _billRemindersPreferenceKey = 'bill_reminders_enabled';
  static const _legacyBillReminderMigrationKey =
      'legacy_bill_reminder_migration_completed';
  bool _initialized = false;

  bool get billRemindersEnabled =>
      GetStorage().read<bool>(_billRemindersPreferenceKey) ?? false;

  Future<void> setBillRemindersEnabled(bool enabled) async {
    await GetStorage().write(_billRemindersPreferenceKey, enabled);
    if (enabled) {
      if (await requestPermission()) {
        await rescheduleOutstandingBills();
      }
    } else {
      await cancelAllBillReminders();
    }
  }

  bool get _isSupportedPlatform =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  Future<void> initialize() async {
    if (_initialized || !_isSupportedPlatform) return;

    tz_data.initializeTimeZones();
    try {
      final timezoneName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezoneName));
    } catch (error) {
      debugPrint('Could not read local timezone for bill reminders: $error');
    }

    const settings = InitializationSettings(
      android: AndroidInitializationSettings('ic_notification'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );
    await _notifications.initialize(settings);
    _initialized = true;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(rescheduleOutstandingBills());
    }
  }

  Future<void> enableRemindersForExistingExpenseBills() async {
    final storage = GetStorage();
    if (storage.read<bool>(_legacyBillReminderMigrationKey) ?? false) return;

    final bills = await database.billsDao.getAllBills();
    for (final bill in bills.where(
      (bill) => bill.isActive && bill.categoryId != null,
    )) {
      if (bill.reminderEnabled) continue;
      await database.billsDao.updateBill(
        bill.id,
        BillsTableCompanion(
          reminderEnabled: const drift.Value(true),
          reminderDaysBefore: drift.Value(bill.reminderDaysBefore ?? 1),
        ),
      );
    }

    await storage.write(_legacyBillReminderMigrationKey, true);
  }

  Future<bool> requestPermission() async {
    await initialize();
    if (!_isSupportedPlatform || !_initialized) return false;

    if (defaultTargetPlatform == TargetPlatform.android) {
      final android = _notifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      return await android?.requestNotificationsPermission() ?? true;
    }

    final ios = _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    return await ios?.requestPermissions(
          alert: true,
          badge: false,
          sound: true,
        ) ??
        false;
  }

  Future<bool> hasPermission() async {
    await initialize();
    if (!_isSupportedPlatform || !_initialized) return false;

    if (defaultTargetPlatform == TargetPlatform.android) {
      final android = _notifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final isEnabled = await android?.areNotificationsEnabled();
      return isEnabled ?? false;
    }

    final ios = _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    final permissions = await ios?.checkPermissions();
    return permissions?.isEnabled ?? false;
  }

  Future<void> scheduleOccurrenceReminders({
    required BillsTableData bill,
    required BillOccurrencesTableData occurrence,
  }) async {
    await initialize();
    if (!_initialized) return;

    await cancelOccurrenceReminders(occurrence.id);
    if (!billRemindersEnabled ||
        !bill.isActive ||
        !bill.reminderEnabled ||
        occurrence.isPaid) {
      return;
    }

    final dueDate = occurrence.dueDate;
    final daysBefore = bill.reminderDaysBefore ?? 1;
    final reminderDate = tz.TZDateTime(
      tz.local,
      dueDate.year,
      dueDate.month,
      dueDate.day - daysBefore,
      9,
    );
    final dueDateReminder = tz.TZDateTime(
      tz.local,
      dueDate.year,
      dueDate.month,
      dueDate.day,
      9,
    );
    final now = tz.TZDateTime.now(tz.local);
    final reminderId = _notificationId(occurrence.id, 0);
    final dueId = _notificationId(occurrence.id, 1);

    if (reminderDate.isAfter(now)) {
      final dueIn = daysBefore == 1 ? 'tomorrow' : 'in $daysBefore days';
      await _schedule(
        id: reminderId,
        title: 'Bill due $dueIn',
        body: '${bill.name} is coming up. Remember to plan its payment.',
        date: reminderDate,
        payload: 'bill:${bill.id}:occurrence:${occurrence.id}',
      );
    }

    final dueNotificationTime = _movePastDueTimeToNow(dueDateReminder, now);
    if (dueNotificationTime.isAfter(now)) {
      await _schedule(
        id: dueId,
        title: 'Bill due today',
        body: '${bill.name} is due today.',
        date: dueNotificationTime,
        payload: 'bill:${bill.id}:occurrence:${occurrence.id}',
      );
    }
  }

  Future<void> rescheduleOutstandingBills() async {
    await initialize();
    if (!billRemindersEnabled || !await hasPermission()) return;

    final today = DateTime.now();
    final startOfToday = DateTime(today.year, today.month, today.day);
    final bills = await database.billsDao.getAllBills();

    for (final bill in bills.where(
      (bill) => bill.isActive && bill.reminderEnabled,
    )) {
      final occurrences = await database.billsDao.getOccurrencesForBill(
        bill.id,
      );
      BillOccurrencesTableData? nextOccurrence;
      for (final occurrence in occurrences) {
        final dueDay = DateTime(
          occurrence.dueDate.year,
          occurrence.dueDate.month,
          occurrence.dueDate.day,
        );
        if (!occurrence.isPaid && !dueDay.isBefore(startOfToday)) {
          nextOccurrence = occurrence;
          break;
        }
      }

      if (nextOccurrence != null) {
        await scheduleOccurrenceReminders(
          bill: bill,
          occurrence: nextOccurrence,
        );
      }
    }
  }

  Future<void> cancelOccurrenceReminders(int occurrenceId) async {
    await initialize();
    if (!_initialized) return;
    await _notifications.cancel(_notificationId(occurrenceId, 0));
    await _notifications.cancel(_notificationId(occurrenceId, 1));
  }

  Future<void> cancelBillReminders(int billId) async {
    await initialize();
    if (!_initialized) return;
    final occurrences = await database.billsDao.getOccurrencesForBill(billId);
    for (final occurrence in occurrences) {
      await cancelOccurrenceReminders(occurrence.id);
    }
  }

  Future<void> cancelAllBillReminders() async {
    await initialize();
    if (!_initialized) return;
    final bills = await database.billsDao.getAllBills();
    for (final bill in bills) {
      await cancelBillReminders(bill.id);
    }
  }

  Future<void> _schedule({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime date,
    required String payload,
  }) async {
    await _notifications.zonedSchedule(
      id,
      title,
      body,
      date,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'bill_reminders',
          'Bill reminders',
          channelDescription: 'Alerts before and on bill due dates',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: payload,
    );
  }

  tz.TZDateTime _movePastDueTimeToNow(
    tz.TZDateTime scheduled,
    tz.TZDateTime now,
  ) {
    final isDueToday =
        scheduled.year == now.year &&
        scheduled.month == now.month &&
        scheduled.day == now.day;
    if (isDueToday && !scheduled.isAfter(now)) {
      return now.add(const Duration(minutes: 1));
    }
    return scheduled;
  }

  int _notificationId(int occurrenceId, int reminderIndex) {
    return ((occurrenceId & 0x3fffffff) * 2) + reminderIndex;
  }
}
