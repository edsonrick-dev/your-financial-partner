import 'package:flutter/foundation.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_products/models/insurance_product.dart';

extension AddPolicySheetControllerX on InsurancePolicyController {
  void setIssueDate(DateTime date) {
    issueDate.value = date;
  }

  void setNextPaymentDate(DateTime date) {
    nextPaymentDate.value = date;
  }

  Future<void> setInsuranceProduct(InsuranceProduct product) async {
    debugPrint(
      'Setting product: ${product.name}, '
      'local ID: ${product.id}, '
      'Supabase ID: ${product.supabaseId}',
    );

    // Product creation keeps policy-specific coverage amounts in drafts. Keep
    // them while reloading the saved benefit rows (whose IDs are now local).
    final coverageByBenefitId = <int, double>{
      for (final draft in benefitDrafts)
        if (draft.insuranceBenefitId != null)
          draft.insuranceBenefitId!: draft.coverageAmount,
    };

    selectedProduct.value = product;

    benefitDrafts.clear();
    isAddingBenefit.value = false;
    productBenefits.clear();
    benefitLoadError.value = null;

    availablePaymentTerms.clear();
    selectedPaymentTerm.value = null;

    var localProductId = product.id;

    if (localProductId == null && product.supabaseId != null) {
      final cachedProduct = await database.insurancePoliciesDao
          .getProductBySupabaseId(product.supabaseId!);

      localProductId = cachedProduct?.id;
    }

    if (localProductId == null) {
      benefitLoadError.value =
          'Save the product locally before loading its benefits.';

      debugPrint('Cannot load benefits: local product ID is null.');
      return;
    }

    await loadPaymentTermsForProduct(localProductId);
    await loadBenefitsForProduct(product, localProductId: localProductId);

    if (product.isUserGenerated && coverageByBenefitId.isNotEmpty) {
      for (var index = 0; index < benefitDrafts.length; index++) {
        final draft = benefitDrafts[index];
        final amount = coverageByBenefitId[draft.insuranceBenefitId];
        if (amount != null) {
          benefitDrafts[index] = draft.copyWith(coverageAmount: amount);
        }
      }
    }

    debugPrint(
      'Product ready: ${product.name} (local ID: ${product.id}, '
      '${productBenefits.length} benefits, '
      '${availablePaymentTerms.length} payment terms)',
    );
  }

  void goToPolicyDetails() {
    if (selectedProduct.value == null) {
      debugPrint('Cannot navigate: no selected product.');
      return;
    }

    currentPolicyStep.value = AddPolicyStep.fillPolicyDetails;

    debugPrint('Current policy step: ${currentPolicyStep.value}');
  }

  void setFrequency(BillsFrequency frequency) {
    selectedFrequency.value = frequency;
  }
}
