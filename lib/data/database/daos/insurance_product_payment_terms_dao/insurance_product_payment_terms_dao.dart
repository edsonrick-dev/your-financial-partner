import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';

import 'package:getx_drift_app/data/tables/payment_terms_table.dart';
import 'package:getx_drift_app/data/tables/insurance_product_payment_terms_table.dart';
import 'package:getx_drift_app/data/tables/insurance_products_table.dart';

part 'insurance_product_payment_terms_dao.g.dart';

@DriftAccessor(
  tables: [
    InsuranceProductsTable,
    PaymentTermsTable,
    InsuranceProductPaymentTermsTable,
  ],
)
class InsuranceProductPaymentTermsDao extends DatabaseAccessor<AppDatabase>
    with _$InsuranceProductPaymentTermsDaoMixin {
  InsuranceProductPaymentTermsDao(super.db);

  /// Get payment terms linked to a local insurance product.
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

  /// Watch payment terms linked to a local insurance product.
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

  /// Link an existing local payment term to an existing local product.
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

  /// Remove a product-payment-term relationship.
  Future<int> unlinkPaymentTermFromProduct({
    required int localProductId,
    required int localPaymentTermId,
  }) {
    return (delete(insuranceProductPaymentTermsTable)..where(
          (t) =>
              t.productId.equals(localProductId) &
              t.paymentTermId.equals(localPaymentTermId),
        ))
        .go();
  }

  /// Find a local product by its remote Supabase ID.
  Future<InsuranceProductsTableData?> getProductBySupabaseId(int supabaseId) {
    return (select(
      insuranceProductsTable,
    )..where((t) => t.supabaseId.equals(supabaseId))).getSingleOrNull();
  }

  /// Find a local payment term by its remote Supabase ID.
  Future<PaymentTermRow?> getPaymentTermBySupabaseId(int supabaseId) {
    return (select(
      paymentTermsTable,
    )..where((t) => t.supabaseId.equals(supabaseId))).getSingleOrNull();
  }
}
