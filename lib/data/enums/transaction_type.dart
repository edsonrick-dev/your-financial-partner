enum TransactionType {
  earn,
  spend,
  transfer,
  give,
  receive;

  static TransactionType fromName(String value) {
    return TransactionType.values.firstWhere((e) => e.name == value);
  }
}
