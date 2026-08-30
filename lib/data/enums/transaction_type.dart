enum TransactionType {
  earn,
  spend,
  transfer,
  give,
  receive,
  balanceUpdate;

  static TransactionType fromName(String value) {
    return TransactionType.values.firstWhere((e) => e.name == value);
  }

  String get headerTitle {
    return switch (this) {
      TransactionType.earn => 'Earn',
      TransactionType.spend => 'Spend',
      TransactionType.transfer => 'Transfer',
      TransactionType.give => 'Give',
      TransactionType.receive => 'Receive',
      _ => '',
    };
  }

  String get actionText {
    return switch (this) {
      TransactionType.earn => 'earning',
      TransactionType.spend => 'expense',
      TransactionType.transfer => 'money transfer',
      TransactionType.give => 'amount given',
      TransactionType.receive => 'amount received',
      _ => '',
    };
  }
}
