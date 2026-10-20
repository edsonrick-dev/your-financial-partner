import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/premium_payment_type.dart';

@DataClassName('PaymentTermRow')
class PaymentTermsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get supabaseId => integer().nullable().unique()();

  TextColumn get paymentType => textEnum<PremiumPaymentType>()();

  IntColumn get yearsToPay => integer().nullable()();

  IntColumn get ageEndOfPayment => integer().nullable()();

  TextColumn get description => text().nullable()();

  DateTimeColumn get createdAt => dateTime().nullable()();

  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

extension PaymentTermRowX on PaymentTermRow {
  String get label {
    switch (paymentType) {
      case PremiumPaymentType.singlePay:
        return 'Single Pay';

      case PremiumPaymentType.limitedPay:
        return '${yearsToPay ?? 0} Years to Pay';

      case PremiumPaymentType.regularPay:
        return 'Pay up to age ${ageEndOfPayment ?? ''}';
    }
  }
}
