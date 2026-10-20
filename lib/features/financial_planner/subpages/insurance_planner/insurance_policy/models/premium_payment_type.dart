enum PremiumPaymentType { singlePay, limitedPay, regularPay }

extension PremiumPaymentTypeX on PremiumPaymentType {
  String get label {
    switch (this) {
      case PremiumPaymentType.singlePay:
        return 'Single-Pay';
      case PremiumPaymentType.limitedPay:
        return 'Limited-Pay';
      case PremiumPaymentType.regularPay:
        return 'Regular-Pay';
    }
  }
}
