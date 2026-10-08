enum ProtectionContinuityType { dependentExpenses, lifestyleExpenses }

extension ProtectionContinuityTypeX on ProtectionContinuityType {
  String get label {
    switch (this) {
      case ProtectionContinuityType.dependentExpenses:
        return 'Dependent Expense Continuity';

      case ProtectionContinuityType.lifestyleExpenses:
        return 'Lifestyle Expense Continuity';
    }
  }

  String get shortLabel {
    switch (this) {
      case ProtectionContinuityType.dependentExpenses:
        return 'Dependent Expenses';

      case ProtectionContinuityType.lifestyleExpenses:
        return 'Lifestyle Expenses';
    }
  }
}
