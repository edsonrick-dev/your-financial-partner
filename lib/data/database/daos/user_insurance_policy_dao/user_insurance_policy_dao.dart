import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/data/tables/user_insurance_policy_table.dart';
import 'package:getx_drift_app/data/tables/premium_detail_table.dart';
import 'package:getx_drift_app/data/tables/user_insurance_benefits_table.dart';
import 'package:getx_drift_app/data/tables/insurance_benefits_table.dart';

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
}
