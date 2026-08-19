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
}
