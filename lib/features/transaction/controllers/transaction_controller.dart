import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/enums/frequency_type_enum.dart';
import 'package:getx_drift_app/data/enums/split_mode_enum.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/models/participant_model.dart';
import 'package:getx_drift_app/data/models/person_balance_summary_model.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';
import 'package:intl/intl.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/split_transaction_ext.dart';

class TransactionController extends GetxController {
  /// VARIABLES ✅
  /// GENERAL VARIABLES -------------
  final selectedCategory = Rxn<CashflowCategoriesTableData>();
  final selectedAccount = Rxn<AccountsTableData>();
  final selectedPerson = Rxn<EntitiesTableData>();
  final selectedLinkedAccount = Rxn<AccountsTableData>();
  final amount = 0.0.obs;
  final currencySymbol = '₱'.obs; //UNUSED
  final selectedFrequency = Rxn<FrequencyType>();

  ///TRANSACTION SPECIFIC VARIABLES -------------
  ///SPLIT EXPENSE -------------
  final RxnInt currentUserEntityId = RxnInt();
  final RxBool isSharedExpense = false.obs;
  final RxBool isDebt = false.obs;
  final Rx<SplitMode> splitMode = SplitMode.equal.obs;
  final RxList<ParticipantModel> participants = <ParticipantModel>[].obs;

  final editingTransaction = Rxn<TransactionWithDetails>();

  /// TEXT CONTROLLERS ✅
  final amountController = TextEditingController();

  /// FUNCTIONS ✅
  Rx<DateTime> selectedDate = DateTime.now().obs;
  void setDate(DateTime value) {
    selectedDate.value = value;
  }

  final selectedPersonBalance = Rxn<PersonBalanceSummary>();
  Future<void> selectPerson(EntitiesTableData person) async {
    selectedPerson.value = person;

    selectedPersonBalance.value = await database.peopleBalanceDao
        .getPersonBalance(person.id);
    debugPrint(
      'Selected Person Balance: '
      '${selectedPersonBalance.value?.netBalance}',
    );
  }

  double projectedBalance(TransactionType transactionType) {
    final current = selectedPersonBalance.value?.netBalance ?? 0;

    if (!isDebt.value) {
      return current;
    }

    switch (transactionType) {
      case TransactionType.give:
        return current + amount.value;

      case TransactionType.receive:
        return current - amount.value;

      default:
        return current;
    }
  }

  final noteController = TextEditingController();
  final noteFocusNode = FocusNode();
  @override
  void onClose() {
    noteController.dispose();
    noteFocusNode.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();

    loadCurrentUserEntity();
  }

  List<ParticipantModel> get sortedParticipants {
    final sorted = [...participants];

    sorted.sort((a, b) {
      final aIsMe = a.entityId == currentUserEntityId.value;

      final bIsMe = b.entityId == currentUserEntityId.value;

      if (aIsMe && !bIsMe) return -1;

      if (!aIsMe && bIsMe) return 1;

      return 0;
    });

    return sorted;
  }

  bool get isSpendFormValid {
    return selectedCategory.value != null &&
        selectedAccount.value != null &&
        amount.value > 0;
  } //Still unused

  Future<List<int>> get excludedPersonIds async {
    final me = await database.entitiesDao.getCurrentUserEntity();

    if (me == null) return [];

    return [me.id];
  }

  String? get formattedDate {
    final value = selectedDate.value;

    return DateFormat('MMMM d, yyyy').format(value);
  }

  String get currentBalanceLabel {
    final balance = selectedPersonBalance.value?.netBalance ?? 0;

    if (balance > 0) {
      return 'This person owes you';
    }

    if (balance < 0) {
      return 'You owe this person';
    }

    return 'No outstanding balance';
  }

  String projectedBalanceLabel(TransactionType type) {
    final projected = projectedBalance(type);

    if (projected > 0) {
      return 'This person will owe you';
    }

    if (projected < 0) {
      return 'You will owe this person';
    }

    return 'Balance will be settled';
  }

  ///SPLIT EXPENSE
}

extension SpendControllerExtension on TransactionController {
  bool get canEnableSharedExpense {
    return amount.value > 0;
  }

  bool get canEnableDebt {
    return amount.value > 0 && selectedPerson.value != null;
  }

  double get totalAllocated {
    return participants.fold(
      0,
      (sum, participant) => sum + participant.amount.value,
    );
  }

  double get remainingAllocation {
    return amount.value - totalAllocated;
  }

  bool get isFullyAllocated {
    return remainingAllocation.abs() < 0.01;
  }

  void recalculateEqualSplit() {
    if (participants.isEmpty) return;

    final split = amount.value / participants.length;

    for (final participant in participants) {
      participant.amount.value = split;

      participant.percentage.value = amount.value == 0
          ? 0
          : split / amount.value;
    }

    participants.refresh();
  }

  void recalculateParticipants() {
    switch (splitMode.value) {
      case SplitMode.equal:
        recalculateEqualSplit();
        break;

      case SplitMode.percentage:
        for (final participant in participants) {
          syncAmountFromPercentage(participant);
        }
        break;

      case SplitMode.custom:
        for (final participant in participants) {
          syncPercentageFromAmount(participant);
        }
        break;
    }

    participants.refresh();
  }

  void syncPercentageFromAmount(ParticipantModel participant) {
    participant.percentage.value = amount.value == 0
        ? 0
        : participant.amount.value / amount.value;
  }

  void syncAmountFromPercentage(ParticipantModel participant) {
    participant.amount.value = amount.value * participant.percentage.value;
  }

  void addParticipant({required int entityId, required String name}) {
    final exists = participants.any(
      (participant) => participant.entityId == entityId,
    );

    if (exists) return;

    participants.add(ParticipantModel(entityId: entityId, name: name));

    if (splitMode.value == SplitMode.equal) {
      recalculateEqualSplit();
    }
  }
}

class ParticipantBalance {
  final int entityId;

  final String name;

  final double amount;

  final BalanceDirection direction;

  const ParticipantBalance({
    required this.entityId,
    required this.name,
    required this.amount,
    required this.direction,
  });
}

enum BalanceDirection { receivable, payable }
