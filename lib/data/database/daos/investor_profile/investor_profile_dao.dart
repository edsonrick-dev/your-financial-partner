import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/investor_profile_table.dart';

part 'investor_profile_dao.g.dart';

@DriftAccessor(tables: [InvestorProfilesTable])
class InvestorProfileDao extends DatabaseAccessor<AppDatabase>
    with _$InvestorProfileDaoMixin {
  InvestorProfileDao(super.db);

  Future<InvestorProfilesTableData?> getProfile() {
    return (select(investorProfilesTable)..limit(1)).getSingleOrNull();
  }

  Future<void> saveProfile({
    String? investmentHorizon,
    String? withdrawalHorizon,
    String? investmentKnowledge,
    String? riskWillingness,
    String? investmentExperience,
    String? marketLossReaction,
    String? riskReturnPreference,
    int? totalScore,
    String? investorProfile,
    DateTime? assessedAt,
  }) async {
    final existing = await getProfile();

    final companion = InvestorProfilesTableCompanion(
      investmentHorizon: Value(investmentHorizon),
      withdrawalHorizon: Value(withdrawalHorizon),
      investmentKnowledge: Value(investmentKnowledge),
      riskWillingness: Value(riskWillingness),
      investmentExperience: Value(investmentExperience),
      marketLossReaction: Value(marketLossReaction),
      riskReturnPreference: Value(riskReturnPreference),
      totalScore: Value(totalScore),
      investorProfile: Value(investorProfile),
      assessedAt: Value(assessedAt),
    );

    if (existing == null) {
      await into(investorProfilesTable).insert(companion);
      return;
    }

    await (update(
      investorProfilesTable,
    )..where((table) => table.id.equals(existing.id))).write(companion);
  }

  Future<void> deleteProfile() {
    return delete(investorProfilesTable).go();
  }
}
