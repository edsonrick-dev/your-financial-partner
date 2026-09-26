enum TransactionType {
  earn,
  spend,
  transfer,
  give,
  receive,
  debtRepayment,
  balanceUpdate,
  cardPayment;

  static TransactionType fromName(String value) {
    return TransactionType.values.firstWhere((e) => e.name == value);
  }

  String get headerTitle {
    return switch (this) {
      TransactionType.earn => 'Earn',
      TransactionType.spend => 'Spend',
      TransactionType.debtRepayment => 'Spend',
      TransactionType.cardPayment => 'Card Payment',
      TransactionType.transfer => 'Transfer',
      TransactionType.give => 'Give',
      TransactionType.receive => 'Receive',

      TransactionType.balanceUpdate => '',
    };
  }

  String get actionTitle {
    return switch (this) {
      TransactionType.earn => 'earning',
      TransactionType.spend => 'expense',
      TransactionType.transfer => 'money transfer',
      TransactionType.give => 'amount given',
      TransactionType.receive => 'amount received',
      TransactionType.debtRepayment => 'debt payment',
      TransactionType.cardPayment => 'card payment',

      TransactionType.balanceUpdate => '',
    };
  }

  String get actionText {
    return switch (this) {
      TransactionType.earn => 'earning',
      TransactionType.spend => 'expense',
      TransactionType.transfer => 'money transfer',
      TransactionType.give => 'amount given',
      TransactionType.receive => 'amount received',
      TransactionType.debtRepayment => 'debt payment',
      TransactionType.cardPayment => 'card payment',

      TransactionType.balanceUpdate => '',
    };
  }
}
