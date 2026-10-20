import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';

import 'package:getx_drift_app/data/tables/payment_terms_table.dart';
import 'package:getx_drift_app/data/tables/insurance_product_payment_terms_table.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/premium_payment_type.dart';

part 'payment_terms_dao.g.dart';

@DriftAccessor(tables: [PaymentTermsTable, InsuranceProductPaymentTermsTable])
class PaymentTermsDao extends DatabaseAccessor<AppDatabase>
    with _$PaymentTermsDaoMixin {
  PaymentTermsDao(super.db);

  /// Get every payment term available in the local catalog.
  Future<List<PaymentTermRow>> getAllPaymentTerms() {
    return select(paymentTermsTable).get();
  }

  /// Watch payment terms linked to a specific local product ID.
  Stream<List<PaymentTermRow>> watchPaymentTermsForProduct(int localProductId) {
    final query =
        select(paymentTermsTable).join([
          innerJoin(
            insuranceProductPaymentTermsTable,
            insuranceProductPaymentTermsTable.paymentTermId.equalsExp(
              paymentTermsTable.id,
            ),
          ),
        ])..where(
          insuranceProductPaymentTermsTable.productId.equals(localProductId),
        );

    return query.watch().map(
      (rows) => rows.map((row) => row.readTable(paymentTermsTable)).toList(),
    );
  }

  /// Get payment terms linked to a specific local product ID.
  Future<List<PaymentTermRow>> getPaymentTermsForProduct(
    int localProductId,
  ) async {
    final query =
        select(paymentTermsTable).join([
          innerJoin(
            insuranceProductPaymentTermsTable,
            insuranceProductPaymentTermsTable.paymentTermId.equalsExp(
              paymentTermsTable.id,
            ),
          ),
        ])..where(
          insuranceProductPaymentTermsTable.productId.equals(localProductId),
        );

    final rows = await query.get();

    return rows.map((row) => row.readTable(paymentTermsTable)).toList();
  }

  /// Link a payment term to a product.
  ///
  /// The unique constraint on (productId, paymentTermId)
  /// prevents duplicate links.
  Future<void> linkPaymentTermToProduct({
    required int localProductId,
    required int localPaymentTermId,
  }) async {
    await into(insuranceProductPaymentTermsTable).insert(
      InsuranceProductPaymentTermsTableCompanion.insert(
        productId: localProductId,
        paymentTermId: localPaymentTermId,
      ),
      mode: InsertMode.insertOrIgnore,
    );
  }

  /// Remove a payment term from a product.
  Future<int> unlinkPaymentTermFromProduct({
    required int localProductId,
    required int localPaymentTermId,
  }) {
    return (delete(insuranceProductPaymentTermsTable)..where(
          (row) =>
              row.productId.equals(localProductId) &
              row.paymentTermId.equals(localPaymentTermId),
        ))
        .go();
  }

  Future<void> upsertPaymentTerm({
    required int supabaseId,
    required PremiumPaymentType paymentType,
    required int? yearsToPay,
    required int? ageEndOfPayment,
    required String? description,
  }) async {
    await into(paymentTermsTable).insert(
      PaymentTermsTableCompanion.insert(
        // Include this only if your Drift schema permits explicit local IDs.
        supabaseId: Value(supabaseId),
        paymentType: paymentType,
        yearsToPay: Value(yearsToPay),
        ageEndOfPayment: Value(ageEndOfPayment),
        description: Value(description),
      ),
      mode: InsertMode.insertOrIgnore,
    );
  }

  Future<void> upsertFromSupabase(Map<String, dynamic> json) async {
    final remoteId = (json['id'] as num).toInt();

    final existing = await (select(
      paymentTermsTable,
    )..where((t) => t.supabaseId.equals(remoteId))).getSingleOrNull();

    final companion = PaymentTermsTableCompanion(
      supabaseId: Value(remoteId),
      paymentType: Value(
        PremiumPaymentType.values.byName(json['payment_type'] as String),
      ),
      yearsToPay: Value((json['years_to_pay'] as num?)?.toInt()),
      ageEndOfPayment: Value((json['age_end_of_payment'] as num?)?.toInt()),
      description: Value(json['description'] as String?),
      createdAt: Value(DateTime.parse(json['created_at'] as String)),
    );

    if (existing == null) {
      await into(paymentTermsTable).insert(companion);
    } else {
      await (update(
        paymentTermsTable,
      )..where((t) => t.id.equals(existing.id))).write(companion);
    }
  }
}
