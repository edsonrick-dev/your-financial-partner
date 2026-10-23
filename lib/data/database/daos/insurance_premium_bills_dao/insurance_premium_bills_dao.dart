import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/insurance_premium_bills_table.dart';

part 'insurance_premium_bills_dao.g.dart';

@DriftAccessor(tables: [InsurancePremiumBillsTable])
class InsurancePremiumBillsDao extends DatabaseAccessor<AppDatabase>
    with _$InsurancePremiumBillsDaoMixin {
  InsurancePremiumBillsDao(super.db);

  Future<int> insertMapping({required int userPolicyId, required int billId}) {
    return into(insurancePremiumBillsTable).insert(
      InsurancePremiumBillsTableCompanion.insert(
        userPolicyId: userPolicyId,
        billId: billId,
      ),
    );
  }

  Future<int?> getBillIdForPolicy(int userPolicyId) async {
    final mapping = await (select(
      insurancePremiumBillsTable,
    )..where((tbl) => tbl.userPolicyId.equals(userPolicyId))).getSingleOrNull();

    return mapping?.billId;
  }

  Future<int?> getPolicyIdForBill(int billId) async {
    final mapping = await (select(
      insurancePremiumBillsTable,
    )..where((tbl) => tbl.billId.equals(billId))).getSingleOrNull();

    return mapping?.userPolicyId;
  }

  Future<void> deleteMappingForPolicy(int userPolicyId) async {
    await (delete(
      insurancePremiumBillsTable,
    )..where((tbl) => tbl.userPolicyId.equals(userPolicyId))).go();
  }
}
