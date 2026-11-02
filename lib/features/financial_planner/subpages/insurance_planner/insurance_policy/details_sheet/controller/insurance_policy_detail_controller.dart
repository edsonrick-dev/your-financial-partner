import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:drift/drift.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';

class InsurancePolicyDetailController extends GetxController {
  InsurancePolicyDetailController({required this.policyId});

  final int policyId;

  final isLoading = true.obs;
  final errorMessage = RxnString();

  final productName = ''.obs;
  final insurerName = ''.obs;
  final policyNumber = RxnString();
  final dateIssued = Rxn<DateTime>();

  final faceValue = 0.0.obs;
  final paymentTerm = ''.obs;
  final paymentFrequency = BillsFrequency.annual.obs;
  final premiumAmount = RxnDouble();
  final nextDueDate = Rxn<DateTime>();

  final policyBenefits = <TypedResult>[].obs;
  final selectedIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loadPolicyDetails();
  }

  Future<void> loadPolicyDetails() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final result = await database.userInsurancePolicyDao.getPolicyDetails(
        policyId,
      );

      if (result == null) {
        errorMessage.value = 'Policy not found.';
        return;
      }
      final policy = result.readTable(database.userInsurancePolicyTable);
      final product = result.readTable(database.insuranceProductsTable);
      final insurer = result.readTable(database.entitiesTable);

      productName.value = product.name;
      insurerName.value = insurer.displayName ?? insurer.name;
      policyNumber.value = policy.policyNumber;
      dateIssued.value = policy.dateIssued;

      paymentFrequency.value = policy.paymentSchedule;
      paymentTerm.value = _frequencyLabel(policy.paymentSchedule);

      final premium = await database.userInsurancePolicyDao.getPremiumDetails(
        policyId,
      );
      premiumAmount.value = getPremiumAmount(premium, policy.paymentSchedule);

      policyBenefits.assignAll(
        await database.userInsurancePolicyDao.getPolicyBenefits(policyId),
      );

      // This is a payment frequency, not the policy's next payment date.
      // Keep nextDueDate null until actual payment-date data is available.
      nextDueDate.value = null;

      // faceValue should be assigned based on the benefit that represents
      // the face amount in your application, not the sum of every rider.
    } catch (e, stackTrace) {
      errorMessage.value = 'Unable to load policy details.';
      // Replace with your app's logging utility if available.
      debugPrint('Error loading policy details: $e\n$stackTrace');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePolicyBenefitAmount({
    required int userBenefitId,
    required double amount,
  }) async {
    try {
      final updated = await database.userInsurancePolicyDao
          .updatePolicyBenefitAmount(
            userBenefitId: userBenefitId,
            amount: amount,
          );
      if (!updated) {
        debugPrint('No policy benefit found for local ID $userBenefitId.');
        return;
      }

      policyBenefits.assignAll(
        await database.userInsurancePolicyDao.getPolicyBenefits(policyId),
      );
      debugPrint(
        'Updated policy benefit $userBenefitId to $amount for policy $policyId.',
      );
    } catch (e, stackTrace) {
      debugPrint('Error updating policy benefit $userBenefitId: $e\n$stackTrace');
    }
  }

  String _frequencyLabel(BillsFrequency frequency) {
    switch (frequency) {
      case BillsFrequency.monthly:
        return 'Monthly';
      case BillsFrequency.quarterly:
        return 'Quarterly';
      case BillsFrequency.semiAnnual:
        return 'Semi-annual';
      case BillsFrequency.annual:
        return 'Annual';
      default:
        throw ArgumentError(
          'Unsupported insurance payment frequency: $frequency',
        );
    }
  }

  double? getPremiumAmount(PremiumDetail? premium, BillsFrequency frequency) {
    if (premium == null) return null;

    switch (frequency) {
      case BillsFrequency.monthly:
        return premium.monthly;
      case BillsFrequency.quarterly:
        return premium.quarterly;
      case BillsFrequency.semiAnnual:
        return premium.semiAnnual;
      case BillsFrequency.annual:
        return premium.annual;
      default:
        return null;
    }
  }
}
