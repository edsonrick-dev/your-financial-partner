import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_draft.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/insurance_policy_list_item.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/widgets/cards/insurance_policy_card.dart';

import 'package:getx_drift_app/data/tables/user_insurance_policy_table.dart';
import 'package:getx_drift_app/data/tables/premium_detail_table.dart';
import 'package:getx_drift_app/data/tables/user_insurance_benefits_table.dart';
import 'package:getx_drift_app/data/tables/insurance_benefits_table.dart';
import 'package:getx_drift_app/data/tables/bills_table.dart';
import 'package:getx_drift_app/data/tables/bill_occurrences_table.dart';
import 'package:getx_drift_app/data/tables/insurance_premium_bills_table.dart';

part 'user_insurance_policy_dao.g.dart';

@DriftAccessor(
  tables: [
    UserInsurancePolicyTable,
    PremiumDetailsTable,
    UserInsuranceBenefitsTable,
    InsuranceBenefitsTable,
    BillsTable,
    BillOccurrencesTable,
    InsurancePremiumBillsTable,
  ],
)
class UserInsurancePolicyDao extends DatabaseAccessor<AppDatabase>
    with _$UserInsurancePolicyDaoMixin {
  UserInsurancePolicyDao(super.db);
  Future<int> savePolicyWithPremium({
    required UserInsurancePolicyTableCompanion policy,
    required BillsFrequency frequency,
    required double amount,
    required DateTime firstPaymentDate,
    required String billName,
  }) {
    return transaction(() async {
      // 1. Save the insurance policy.
      final policyId = await into(userInsurancePolicyTable).insert(policy);

      // 2. Save premium details.
      final premium = PremiumDetailsTableCompanion.insert(
        userPolicyId: Value(policyId),
        monthly: Value(frequency == BillsFrequency.monthly ? amount : null),
        quarterly: Value(frequency == BillsFrequency.quarterly ? amount : null),
        semiAnnual: Value(
          frequency == BillsFrequency.semiAnnual ? amount : null,
        ),
        annual: Value(frequency == BillsFrequency.annual ? amount : null),
      );

      await into(premiumDetailsTable).insert(premium);

      // 3. Create the recurring insurance premium bill.
      final billId = await into(billsTable).insert(
        BillsTableCompanion.insert(
          name: billName,
          categoryId: const Value(null),
          accountId: const Value(null),
          expectedAmount: Value(amount),
          frequency: frequency.name,
          dayOfMonth: Value(firstPaymentDate.day),
          reminderEnabled: const Value(false),
          reminderDaysBefore: const Value(null),
        ),
      );

      // 4. Create the first scheduled payment occurrence.
      await into(billOccurrencesTable).insert(
        BillOccurrencesTableCompanion.insert(
          billId: billId,
          dueDate: firstPaymentDate,
          expectedAmount: Value(amount),
        ),
      );

      return policyId;
    });
  }

  Future<int> savePolicyWithPremium1({
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

  // Delete a policy and the premium bill/occurrences created with it.
  Future<int> deleteById(int id) {
    return transaction(() async {
      final premiumLink = await (select(insurancePremiumBillsTable)
            ..where((tbl) => tbl.userPolicyId.equals(id)))
          .getSingleOrNull();

      if (premiumLink != null) {
        await (delete(billOccurrencesTable)
          ..where((tbl) => tbl.billId.equals(premiumLink.billId))).go();
        await (delete(billsTable)
          ..where((tbl) => tbl.id.equals(premiumLink.billId))).go();
        await (delete(insurancePremiumBillsTable)
          ..where((tbl) => tbl.id.equals(premiumLink.id))).go();
      }

      await (delete(premiumDetailsTable)
        ..where((tbl) => tbl.userPolicyId.equals(id))).go();
      await (delete(userInsuranceBenefitsTable)
        ..where((tbl) => tbl.userPolicyId.equals(id))).go();

      return (delete(
        userInsurancePolicyTable,
      )..where((tbl) => tbl.id.equals(id))).go();
    });
  }

  Future<int> savePolicyWithDetails({
    required int productId,
    required String? policyNumber,
    required DateTime dateIssued,
    required DateTime firstPaymentDate,
    required String billName,
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

      final scheduledFirstPaymentDate = _nextPaymentDateOnOrAfterToday(
        firstPaymentDate,
        frequency,
      );

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
      // 1. Create the premium bill.
      final billId = await into(billsTable).insert(
        BillsTableCompanion.insert(
          name: billName,
          categoryId: const Value(null),
          accountId: const Value(null),
          expectedAmount: Value(amount),
          frequency: frequency.name,
          dayOfMonth: Value(firstPaymentDate.day),
          reminderEnabled: const Value(false),
          reminderDaysBefore: const Value(null),
        ),
      );

      // 2. Create the first premium occurrence.
      await into(billOccurrencesTable).insert(
        BillOccurrencesTableCompanion.insert(
          billId: billId,
          dueDate: scheduledFirstPaymentDate,
          expectedAmount: Value(amount),
        ),
      );

      // 3. Link the bill to the insurance policy.
      await into(insurancePremiumBillsTable).insert(
        InsurancePremiumBillsTableCompanion.insert(
          userPolicyId: policyId,
          billId: billId,
        ),
      );

      return policyId;
    });
  }

  DateTime _nextPaymentDateOnOrAfterToday(
    DateTime anchorDate,
    BillsFrequency frequency,
  ) {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final anchorDay = anchorDate.day;
    var dueDate = DateTime(anchorDate.year, anchorDate.month, anchorDay);

    while (dueDate.isBefore(todayStart)) {
      switch (frequency) {
        case BillsFrequency.monthly:
          dueDate = _addMonthsClamped(dueDate, 1, anchorDay);
        case BillsFrequency.quarterly:
          dueDate = _addMonthsClamped(dueDate, 3, anchorDay);
        case BillsFrequency.semiAnnual:
          dueDate = _addMonthsClamped(dueDate, 6, anchorDay);
        case BillsFrequency.annual:
          dueDate = _addMonthsClamped(dueDate, 12, anchorDay);
        case BillsFrequency.weekly:
          dueDate = dueDate.add(const Duration(days: 7));
        case BillsFrequency.biWeekly:
        case BillsFrequency.fortnightly:
          dueDate = dueDate.add(const Duration(days: 14));
      }
    }

    return dueDate;
  }

  DateTime _addMonthsClamped(DateTime date, int months, int anchorDay) {
    final target = DateTime(date.year, date.month + months, 1);
    final lastDay = DateTime(target.year, target.month + 1, 0).day;
    return DateTime(target.year, target.month, anchorDay.clamp(1, lastDay));
  }

  Future<double> getActiveInsurancePremiumAnnualTotal() async {
    final rows = await select(billsTable).join([
      innerJoin(
        insurancePremiumBillsTable,
        insurancePremiumBillsTable.billId.equalsExp(billsTable.id),
      ),
    ]).get();

    return rows.fold<double>(0, (total, row) {
      final bill = row.readTable(billsTable);
      if (!bill.isActive || bill.expectedAmount == null) return total;

      final frequencyIndex = BillsFrequency.values.indexWhere(
        (value) => value.name == bill.frequency,
      );
      if (frequencyIndex < 0) return total;

      return total +
          BillsFrequency.values[frequencyIndex].toAnnual(
            bill.expectedAmount!,
          );
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

  Future<bool> updatePolicyBenefitAmount({
    required int userBenefitId,
    required double amount,
  }) async {
    final updated = await (update(
      userInsuranceBenefitsTable,
    )..where((tbl) => tbl.id.equals(userBenefitId))).write(
      UserInsuranceBenefitsTableCompanion(
        amount: Value(amount),
        isSynced: const Value(false),
      ),
    );

    return updated > 0;
  }

  Future<PremiumDetail?> getPremiumDetails(int policyId) {
    return (select(premiumDetailsTable)
          ..where((tbl) => tbl.userPolicyId.equals(policyId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  Stream<List<InsurancePolicyListItem>> watchPolicyList() {
    final today = DateTime.now();
    final startOfToday = DateTime(today.year, today.month, today.day);

    final query =
        select(userInsurancePolicyTable).join([
          innerJoin(
            insuranceProductsTable,
            insuranceProductsTable.id.equalsExp(
              userInsurancePolicyTable.productId,
            ),
          ),
          innerJoin(
            entitiesTable,
            entitiesTable.id.equalsExp(insuranceProductsTable.insurerId),
          ),
          leftOuterJoin(
            insurancePremiumBillsTable,
            insurancePremiumBillsTable.userPolicyId.equalsExp(
              userInsurancePolicyTable.id,
            ),
          ),
          leftOuterJoin(
            billOccurrencesTable,
            billOccurrencesTable.billId.equalsExp(
                  insurancePremiumBillsTable.billId,
                ) &
                billOccurrencesTable.isPaid.equals(false) &
                billOccurrencesTable.dueDate.isBiggerOrEqualValue(startOfToday),
          ),
        ])..orderBy([
          OrderingTerm.asc(billOccurrencesTable.dueDate),
          OrderingTerm.desc(userInsurancePolicyTable.dateIssued),
          OrderingTerm.desc(userInsurancePolicyTable.createdAt),
        ]);

    return query.watch().map((rows) {
      final policiesById = <int, InsurancePolicyListItem>{};

      for (final row in rows) {
        final policy = row.readTable(userInsurancePolicyTable);
        final product = row.readTable(insuranceProductsTable);
        final insurer = row.readTable(entitiesTable);
        final occurrence = row.readTableOrNull(billOccurrencesTable);

        // The query is ordered by due date, so the first occurrence
        // encountered for a policy is its earliest qualifying occurrence.
        if (policiesById.containsKey(policy.id)) continue;

        policiesById[policy.id] = InsurancePolicyListItem(
          id: policy.id,
          productName: product.name,
          insurerName: insurer.displayName ?? insurer.name,
          policyNumber: policy.policyNumber ?? '',
          paymentFrequency: policy.paymentSchedule,
          nextDue: occurrence?.dueDate,
          amountDue: occurrence?.expectedAmount ?? 0,
        );
      }

      return policiesById.values.toList();
    });
  }
}
