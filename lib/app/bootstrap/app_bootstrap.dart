import 'package:get_storage/get_storage.dart';
import 'package:getx_drift_app/core/notifications/bill_notification_service.dart';
import 'package:getx_drift_app/app/bootstrap/database_initializer.dart';
import 'package:getx_drift_app/app/bootstrap/posthog_initializer.dart';
import 'package:getx_drift_app/app/bootstrap/seed_initializer.dart';
import 'package:getx_drift_app/app/bootstrap/supabase_initializer.dart';

abstract final class AppBootstrap {
  static Future<void> initialize() async {
    await GetStorage.init();

    await DatabaseInitializer.initialize();

    await SeedInitializer.initialize();

    await BillNotificationService.instance.initialize();
    await BillNotificationService.instance
        .enableRemindersForExistingExpenseBills();
    await BillNotificationService.instance.rescheduleOutstandingBills();

    await PostHogInitializer.initialize();

    await SupabaseInitializer.initialize();
  }
}
