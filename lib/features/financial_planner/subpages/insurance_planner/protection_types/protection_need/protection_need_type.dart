import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum ProtectionNeedType {
  funeralAndFinalExpense,
  expenseContinuity,
  educationFunding,
  medicalAndRecoveryFund,
  debtsAndObligations,
  estateSettlement,
}

extension ProtectionNeedTypeX on ProtectionNeedType {
  String get title {
    switch (this) {
      case ProtectionNeedType.funeralAndFinalExpense:
        return 'Funeral & Final Expense';
      case ProtectionNeedType.expenseContinuity:
        return 'Expense Continuity Fund';
      case ProtectionNeedType.educationFunding:
        return 'Education Funding';
      case ProtectionNeedType.medicalAndRecoveryFund:
        return 'Medical & Recovery Fund';
      case ProtectionNeedType.debtsAndObligations:
        return 'Debts & Obligations';
      case ProtectionNeedType.estateSettlement:
        return 'Estate Settlement Fund';
    }
  }

  String get description {
    switch (this) {
      case ProtectionNeedType.funeralAndFinalExpense:
        return 'Covers estimated funeral costs and other end-of-life expenses';
      case ProtectionNeedType.expenseContinuity:
        return 'Provides funds to maintain living expenses throughout the selected protection horizon';
      case ProtectionNeedType.educationFunding:
        return 'Provides for future education expenses included in your plans';
      case ProtectionNeedType.medicalAndRecoveryFund:
        return 'Covers potential medical, treatment, and recovery expenses';
      case ProtectionNeedType.debtsAndObligations:
        return 'Accounts for outstanding liabilities that may need to be settled';
      case ProtectionNeedType.estateSettlement:
        return 'Provides for estimated costs associated with settling your estate';
    }
  }

  IconData get icon {
    switch (this) {
      case ProtectionNeedType.funeralAndFinalExpense:
        return PhosphorIconsRegular.heartBreak;
      case ProtectionNeedType.expenseContinuity:
        return PhosphorIconsRegular.users;
      case ProtectionNeedType.educationFunding:
        return PhosphorIconsRegular.graduationCap;
      case ProtectionNeedType.medicalAndRecoveryFund:
        return PhosphorIconsRegular.firstAidKit;
      case ProtectionNeedType.debtsAndObligations:
        return PhosphorIconsRegular.bank;
      case ProtectionNeedType.estateSettlement:
        return PhosphorIconsRegular.houseLine;
    }
  }
}

extension ProtectionTypeNeedsX on ProtectionType {
  List<ProtectionNeedType> get requiredNeeds {
    switch (this) {
      case ProtectionType.death:
        return [
          ProtectionNeedType.expenseContinuity,
          // ProtectionNeedType.funeralAndFinalExpense,
          // ProtectionNeedType.educationFunding,
          // ProtectionNeedType.debtsAndObligations,
          // ProtectionNeedType.estateSettlement,
        ];

      case ProtectionType.criticalIllness:
        return [
          ProtectionNeedType.expenseContinuity,
          // ProtectionNeedType.medicalAndRecoveryFund,
          // ProtectionNeedType.educationFunding,
          // ProtectionNeedType.debtsAndObligations,
        ];

      case ProtectionType.disability:
        return [
          ProtectionNeedType.expenseContinuity,
          // ProtectionNeedType.medicalAndRecoveryFund,
          // ProtectionNeedType.educationFunding,
          // ProtectionNeedType.debtsAndObligations,
        ];
    }
  }

  String get horizonExplainerText {
    switch (this) {
      case ProtectionType.death:
        return 'How long your dependents will need financial support after your death.';
      case ProtectionType.criticalIllness:
        return 'How long you may need financial support to cover living expenses while recovering from a critical illness.';
      case ProtectionType.disability:
        return 'How long you may need financial support to cover living expenses if a disability prevents you from earning an income.';
    }
  }

  String get continuityFundTitle {
    switch (this) {
      case ProtectionType.death:
        return "Dependents' annual living expenses";

      case ProtectionType.criticalIllness:
      case ProtectionType.disability:
        return 'Your annual living expenses';
    }
  }

  String get continuityFundDescription {
    switch (this) {
      case ProtectionType.death:
        return "The annual cost of maintaining your dependents' lifestyle if you pass away, expressed in today's value before inflation.";

      case ProtectionType.criticalIllness:
        return "The annual cost of maintaining your lifestyle if you are diagnosed with a critical illness and can no longer work as usual, expressed in today's value before inflation.";

      case ProtectionType.disability:
        return "The annual cost of maintaining your lifestyle if a disability prevents you from earning an income, expressed in today's value before inflation.";
    }
  }

  String get continuityFundExplainerText {
    switch (this) {
      case ProtectionType.death:
        return "Not all expenses would continue after your death. Choose how much of each expense your family would still need.";

      case ProtectionType.criticalIllness:
        return "Your expenses may change if you experience a critical illness. Choose how much of each expense you would still need during your recovery.";

      case ProtectionType.disability:
        return "Your expenses may change if you become disabled. Choose how much of each expense you would still need to maintain your lifestyle.";
    }
  }

  String get continuityFundQuestion {
    switch (this) {
      case ProtectionType.death:
        return "Which of your current expenses would your dependents still need if you passed away?";

      case ProtectionType.criticalIllness:
        return "Which of your current expenses would you still need to cover during your recovery?";

      case ProtectionType.disability:
        return "Which of your current expenses would you still need to cover if you became disabled?";
    }
  }

  String get continuityFundQuestionHelper {
    switch (this) {
      case ProtectionType.death:
        return "Tap each card to adjust the share your dependents would need.";

      case ProtectionType.criticalIllness:
        return "Tap each card to adjust the share of each expense you expect to retain.";

      case ProtectionType.disability:
        return "Tap each card to adjust the share of each expense you expect to retain.";
    }
  }
}

class ProtectionNeedKey {
  const ProtectionNeedKey({
    required this.protectionType,
    required this.needType,
  });

  final ProtectionType protectionType;
  final ProtectionNeedType needType;

  @override
  bool operator ==(Object other) =>
      other is ProtectionNeedKey &&
      other.protectionType == protectionType &&
      other.needType == needType;

  @override
  int get hashCode => Object.hash(protectionType, needType);
}

bool isProtectionTypeCompleted(
  ProtectionType protectionType,
  Set<ProtectionNeedKey> configuredNeeds,
) {
  return protectionType.requiredNeeds.every(
    (needType) => configuredNeeds.contains(
      ProtectionNeedKey(protectionType: protectionType, needType: needType),
    ),
  );
}
