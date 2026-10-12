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
          // ProtectionNeedType.funeralAndFinalExpense,
          ProtectionNeedType.expenseContinuity,
          // ProtectionNeedType.educationFunding,
          // ProtectionNeedType.debtsAndObligations,
          // ProtectionNeedType.estateSettlement,
        ];

      case ProtectionType.criticalIllness:
        return [
          // ProtectionNeedType.medicalAndRecoveryFund,
          ProtectionNeedType.expenseContinuity,
          // ProtectionNeedType.educationFunding,
          // ProtectionNeedType.debtsAndObligations,
        ];

      case ProtectionType.disability:
        return [
          // ProtectionNeedType.medicalAndRecoveryFund,
          ProtectionNeedType.expenseContinuity,
          // ProtectionNeedType.educationFunding,
          // ProtectionNeedType.debtsAndObligations,
        ];
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
