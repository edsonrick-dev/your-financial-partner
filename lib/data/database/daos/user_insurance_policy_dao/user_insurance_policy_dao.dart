import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/data/tables/user_insurance_policy_table.dart';
import 'package:getx_drift_app/data/tables/premium_detail_table.dart';
import 'package:getx_drift_app/data/tables/user_insurance_benefits_table.dart';
import 'package:getx_drift_app/data/tables/insurance_benefits_table.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_draft.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/widgets/cards/insurance_policy_card.dart';

part 'user_insurance_policy_dao.g.dart';

@DriftAccessor(
  tables: [
    UserInsurancePolicyTable,
    PremiumDetailsTable,
    UserInsuranceBenefitsTable,
    InsuranceBenefitsTable,
  ],
)
class UserInsurancePolicyDao extends DatabaseAccessor<AppDatabase>
    with _$UserInsurancePolicyDaoMixin {
  UserInsurancePolicyDao(super.db);
  Future<int> savePolicyWithPremium({
    required UserInsurancePolicyTableCompanion policy,
    required BillsFrequency frequency,
    required double amount,
  }) {
    return transaction(() async {
      // 1. Insert the policy and retrieve its local ID.
      final policyId = await into(userInsurancePolicyTable).insert(policy);

      // 2. Map the selected frequency to the correct column.
      final premium = PremiumDetailsTableCompanion.insert(
        userPolicyId: Value(policyId),
        monthly: Value(frequency == BillsFrequency.monthly ? amount : null),
        quarterly: Value(frequency == BillsFrequency.quarterly ? amount : null),
        semiAnnual: Value(
          frequency == BillsFrequency.semiAnnual ? amount : null,
        ),
        annual: Value(frequency == BillsFrequency.annual ? amount : null),
      );

      // 3. Save the premium details.
      await into(premiumDetailsTable).insert(premium);

      return policyId;
    });
  }

  // Create a policy.
  Future<int> insertPolicy(UserInsurancePolicyTableCompanion policy) {
    return into(userInsurancePolicyTable).insert(policy);
  }

  // Get a policy by ID.
  Future<UserInsurancePolicy?> getById(int id) {
    return (select(
      userInsurancePolicyTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  // Watch a policy by ID.
  Stream<UserInsurancePolicy?> watchById(int id) {
    return (select(
      userInsurancePolicyTable,
    )..where((tbl) => tbl.id.equals(id))).watchSingleOrNull();
  }

  // Get all policies for a user.
  Future<List<UserInsurancePolicy>> getByUserId(int userId) {
    return (select(
      userInsurancePolicyTable,
    )..where((tbl) => tbl.userId.equals(userId))).get();
  }

  // Watch all policies for a user.
  Stream<List<UserInsurancePolicy>> watchByUserId(int userId) {
    return (select(
      userInsurancePolicyTable,
    )..where((tbl) => tbl.userId.equals(userId))).watch();
  }

  // Update an existing policy.
  Future<bool> updatePolicy(UserInsurancePolicyTableCompanion policy) {
    return update(userInsurancePolicyTable).replace(policy);
  }

  // Delete a policy.
  Future<int> deleteById(int id) {
    return (delete(
      userInsurancePolicyTable,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> savePolicyWithDetails({
    required int productId,
    required String? policyNumber,
    required DateTime dateIssued,
    required BillsFrequency frequency,
    required double amount,
    required List<PolicyBenefitDraft> benefits,
  }) {
    return transaction(() async {
      // Check for an existing policy with the same product and policy number.
      if (policyNumber != null && policyNumber.trim().isNotEmpty) {
        final existingPolicy =
            await (select(userInsurancePolicyTable)
                  ..where((tbl) => tbl.productId.equals(productId))
                  ..where(
                    (tbl) => tbl.policyNumber.equals(policyNumber.trim()),
                  ))
                .getSingleOrNull();

        if (existingPolicy != null) {
          throw StateError(
            'A policy with this product and policy number already exists.',
          );
        }
      }

      // 1. Insert the policy.
      final policy = UserInsurancePolicyTableCompanion.insert(
        productId: productId,
        policyNumber: Value(
          policyNumber?.trim().isEmpty == true ? null : policyNumber?.trim(),
        ),
        dateIssued: Value(dateIssued),
        paymentSchedule: frequency,
      );

      final policyId = await into(userInsurancePolicyTable).insert(policy);

      // 2. Save premium details.
      await into(premiumDetailsTable).insert(
        PremiumDetailsTableCompanion.insert(
          userPolicyId: Value(policyId),
          monthly: Value(frequency == BillsFrequency.monthly ? amount : null),
          quarterly: Value(
            frequency == BillsFrequency.quarterly ? amount : null,
          ),
          semiAnnual: Value(
            frequency == BillsFrequency.semiAnnual ? amount : null,
          ),
          annual: Value(frequency == BillsFrequency.annual ? amount : null),
        ),
      );

      // 3. Save policy benefits.
      for (final benefit in benefits) {
        final benefitId = benefit.insuranceBenefitId;

        if (benefitId == null) {
          throw StateError(
            'Cannot save "${benefit.name ?? benefit.benefitType.label}": '
            'the benefit definition has not been saved.',
          );
        }

        await into(userInsuranceBenefitsTable).insert(
          UserInsuranceBenefitsTableCompanion.insert(
            userPolicyId: policyId,
            benefitId: benefitId,
            amount: benefit.coverageAmount,
          ),
        );
      }

      return policyId;
    });
  }

  Stream<List<InsuranceSource>> watchInsuranceSourcesByType(
    BenefitType benefitType,
  ) {
    final query = select(userInsurancePolicyTable).join([
      innerJoin(
        userInsuranceBenefitsTable,
        userInsuranceBenefitsTable.userPolicyId.equalsExp(
          userInsurancePolicyTable.id,
        ),
      ),
      innerJoin(
        insuranceBenefitsTable,
        insuranceBenefitsTable.id.equalsExp(
          userInsuranceBenefitsTable.benefitId,
        ),
      ),
      innerJoin(
        insuranceProductsTable,
        insuranceProductsTable.id.equalsExp(userInsurancePolicyTable.productId),
      ),
      innerJoin(
        entitiesTable,
        entitiesTable.id.equalsExp(insuranceProductsTable.insurerId),
      ),
    ])..where(insuranceBenefitsTable.benefitType.equals(benefitType.name));

    return query.watch().map((rows) {
      return rows.map((row) {
        final policy = row.readTable(userInsurancePolicyTable);
        final userBenefit = row.readTable(userInsuranceBenefitsTable);
        final product = row.readTable(insuranceProductsTable);
        final company = row.readTable(entitiesTable);

        return InsuranceSource(
          policyId: policy.id,
          amount: userBenefit.amount,
          issuer: company.displayName ?? company.name,
          name: product.name,
          policyNumber: policy.policyNumber ?? '',
        );
      }).toList();
    });
  }

  Future<bool> hasInsurancePolicies() async {
    final query = select(userInsurancePolicyTable)..limit(1);
    return (await query.get()).isNotEmpty;
  }

  Future<TypedResult?> getPolicyDetails(int policyId) async {
    final query = select(userInsurancePolicyTable).join([
      innerJoin(
        insuranceProductsTable,
        insuranceProductsTable.id.equalsExp(userInsurancePolicyTable.productId),
      ),
      innerJoin(
        entitiesTable,
        entitiesTable.id.equalsExp(insuranceProductsTable.insurerId),
      ),
    ])..where(userInsurancePolicyTable.id.equals(policyId));

    final rows = await query.get();

    return rows.isEmpty ? null : rows.first;
  }

  Future<List<TypedResult>> getPolicyBenefits(int policyId) {
    final query = select(userInsuranceBenefitsTable).join([
      innerJoin(
        insuranceBenefitsTable,
        insuranceBenefitsTable.id.equalsExp(
          userInsuranceBenefitsTable.benefitId,
        ),
      ),
    ])..where(userInsuranceBenefitsTable.userPolicyId.equals(policyId));

    return query.get();
  }

  Future<PremiumDetail?> getPremiumDetails(int policyId) {
    return (select(premiumDetailsTable)
          ..where((tbl) => tbl.userPolicyId.equals(policyId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])
          ..limit(1))
        .getSingleOrNull();
  }
}
