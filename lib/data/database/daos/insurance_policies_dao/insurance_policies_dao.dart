import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/insurance_products_table.dart';
import 'package:getx_drift_app/data/tables/insurance_benefits_table.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_benefit/models/insurance_benefit.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_products/models/insurance_product.dart';

part 'insurance_policies_dao.g.dart';

@DriftAccessor(tables: [InsuranceProductsTable, InsuranceBenefitsTable])
class InsurancePoliciesDao extends DatabaseAccessor<AppDatabase>
    with _$InsurancePoliciesDaoMixin {
  InsurancePoliciesDao(super.db);

  /// Watches products for a selected local insurer.
  Stream<List<InsuranceProductsTableData>> watchByInsurer(int localInsurerId) {
    return (select(insuranceProductsTable)
          ..where((tbl) => tbl.insurerId.equals(localInsurerId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.name)]))
        .watch();
  }

  /// Gets cached products for a selected local insurer.
  Future<List<InsuranceProductsTableData>> getByInsurer(int localInsurerId) {
    return (select(insuranceProductsTable)
          ..where((tbl) => tbl.insurerId.equals(localInsurerId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.name)]))
        .get();
  }

  /// Inserts a custom product locally before sign-in.
  Future<int> insertCustomProduct({
    required int localInsurerId,
    required String name,
    String? shortName,
    String? description,
    int? minAge,
    int? maxAge,
    String? note,
  }) {
    return into(insuranceProductsTable).insert(
      InsuranceProductsTableCompanion.insert(
        insurerId: localInsurerId,
        name: name,
        shortName: Value(shortName),
        description: Value(description),
        isUserGenerated: const Value(true),
        minAge: Value(minAge),
        maxAge: Value(maxAge),
        note: Value(note),
        isSynced: const Value(false),
      ),
    );
  }

  // Future<void> upsertOfficialPolicy({
  //   required int localInsurerId,
  //   required Map<String, dynamic> supabasePolicy,
  // }) async {
  //   final remoteId = (supabasePolicy['id'] as num).toInt();

  //   await into(insuranceProductsTable).insertOnConflictUpdate(
  //     InsuranceProductsTableCompanion.insert(
  //       supabaseId: Value(remoteId),
  //       insurerId: localInsurerId,
  //       name: supabasePolicy['name'] as String,
  //       shortName: Value(supabasePolicy['short_name'] as String?),
  //       description: Value(supabasePolicy['description'] as String?),
  //       isUserGenerated: const Value(false),
  //       minAge: Value((supabasePolicy['min_age'] as num?)?.toInt()),
  //       maxAge: Value((supabasePolicy['max_age'] as num?)?.toInt()),
  //       note: Value(supabasePolicy['note'] as String?),
  //       createdByUserId: const Value(null),
  //       isSynced: const Value(true),
  //     ),
  //   );
  // }

  Future<void> upsertOfficialPolicy({
    required int localInsurerId,
    required Map<String, dynamic> supabasePolicy,
  }) async {
    final remoteId = (supabasePolicy['id'] as num).toInt();

    final existing = await getProductBySupabaseId(remoteId);

    final companion = InsuranceProductsTableCompanion(
      supabaseId: Value(remoteId),
      insurerId: Value(localInsurerId),
      name: Value(supabasePolicy['name'] as String),
      shortName: Value(supabasePolicy['short_name'] as String?),
      description: Value(supabasePolicy['description'] as String?),
      isUserGenerated: const Value(false),
      minAge: Value((supabasePolicy['min_age'] as num?)?.toInt()),
      maxAge: Value((supabasePolicy['max_age'] as num?)?.toInt()),
      note: Value(supabasePolicy['note'] as String?),
      createdByUserId: Value(supabasePolicy['created_by_user_id'] as String?),
      isSynced: const Value(true),
    );

    if (existing != null) {
      await (update(
        insuranceProductsTable,
      )..where((tbl) => tbl.id.equals(existing.id))).write(companion);
    } else {
      await into(insuranceProductsTable).insert(
        InsuranceProductsTableCompanion.insert(
          supabaseId: Value(remoteId),
          insurerId: localInsurerId,
          name: supabasePolicy['name'] as String,
          shortName: Value(supabasePolicy['short_name'] as String?),
          description: Value(supabasePolicy['description'] as String?),
          isUserGenerated: const Value(false),
          minAge: Value((supabasePolicy['min_age'] as num?)?.toInt()),
          maxAge: Value((supabasePolicy['max_age'] as num?)?.toInt()),
          note: Value(supabasePolicy['note'] as String?),
          createdByUserId: Value(
            supabasePolicy['created_by_user_id'] as String?,
          ),
          isSynced: const Value(true),
        ),
      );
    }
  }

  Future<int> createInsuranceProduct({
    required int insurerId,
    required String name,
  }) {
    return into(insuranceProductsTable).insert(
      InsuranceProductsTableCompanion.insert(
        insurerId: insurerId,
        name: name,
        isUserGenerated: const Value(true),
        isSynced: const Value(false),
      ),
    );
  }

  Stream<List<InsuranceProductsTableData>> watchProductsByInsurer({
    required int insurerId,
  }) {
    return (select(insuranceProductsTable)
          ..where((table) => table.insurerId.equals(insurerId))
          ..orderBy([(table) => OrderingTerm.asc(table.name)]))
        .watch();
  }

  Future<void> debugPrintAllInsuranceProducts() async {
    final rows = await select(insuranceProductsTable).get();

    debugPrint('========== INSURANCE POLICIES TABLE ==========');
    debugPrint('Total rows: ${rows.length}');

    for (final row in rows) {
      debugPrint(
        'id: ${row.id} | '
        'supabaseId: ${row.supabaseId} | '
        'insurerId: ${row.insurerId} | '
        'name: ${row.name} | '
        'shortName: ${row.shortName} | '
        'isUserGenerated: ${row.isUserGenerated} | '
        'isSynced: ${row.isSynced} | '
        'createdByUserId: ${row.createdByUserId}',
      );
    }

    debugPrint('==============================================');
  }

  Future<List<InsuranceBenefit>> getBenefitsByProductId(int productId) async {
    final rows = await (select(
      insuranceBenefitsTable,
    )..where((b) => b.productId.equals(productId))).get();

    return rows.map((row) {
      return InsuranceBenefit(
        id: row.id,
        supabaseId: row.supabaseId,
        productId: row.productId,
        benefitType: BenefitType.values.byName(row.benefitType),
        name: row.name,
        description: row.description,
        isRequired: row.isRequired,
        createdAt: row.createdAt,
      );
    }).toList();
  }

  /// Finds a locally cached product using its Supabase ID.
  Future<InsuranceProductsTableData?> getProductBySupabaseId(int supabaseId) {
    return (select(
      insuranceProductsTable,
    )..where((t) => t.supabaseId.equals(supabaseId))).getSingleOrNull();
  }

  /// Finds a locally cached product using its Drift ID.
  Future<InsuranceProductsTableData?> getProductByLocalId(int localProductId) {
    return (select(
      insuranceProductsTable,
    )..where((t) => t.id.equals(localProductId))).getSingleOrNull();
  }

  /// Saves or updates an official benefit definition locally.
  // Future<void> upsertOfficialBenefit({
  //   required int localProductId,
  //   required Map<String, dynamic> json,
  // }) async {
  //   final remoteId = (json['id'] as num).toInt();

  //   final companion = InsuranceBenefitsTableCompanion.insert(
  //     supabaseId: Value(remoteId),
  //     productId: localProductId,
  //     benefitType: json['benefit_type'] as String,
  //     name: Value(json['name'] as String?),
  //     description: Value(json['description'] as String?),
  //     isRequired: Value(json['is_required'] as bool? ?? false),
  //     isSynced: const Value(true),
  //   );

  //   await into(insuranceBenefitsTable).insertOnConflictUpdate(companion);
  // }
  Future<void> upsertOfficialBenefit({
    required int localProductId,
    required Map<String, dynamic> json,
  }) async {
    final supabaseId = json['id'] as int;

    await into(insuranceBenefitsTable).insert(
      InsuranceBenefitsTableCompanion.insert(
        supabaseId: Value(supabaseId),
        productId: localProductId,
        benefitType: json['benefit_type'] as String,
        name: Value(json['name'] as String?),
        description: Value(json['description'] as String?),
        isRequired: Value(json['is_required'] as bool? ?? false),
        isSynced: const Value(true),
      ),
      onConflict: DoUpdate(
        (old) => InsuranceBenefitsTableCompanion(
          productId: Value(localProductId),
          benefitType: Value(json['benefit_type'] as String),
          name: Value(json['name'] as String?),
          description: Value(json['description'] as String?),
          isRequired: Value(json['is_required'] as bool? ?? false),
          isSynced: const Value(true),
        ),
        target: [insuranceBenefitsTable.supabaseId],
      ),
    );
  }
}
