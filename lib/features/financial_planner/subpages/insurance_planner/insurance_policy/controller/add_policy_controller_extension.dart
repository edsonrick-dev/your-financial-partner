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
      return;
    }

    await loadPaymentTermsForProduct(localProductId);

    await loadBenefitsForProduct(product, localProductId: localProductId);
  }

  void setFrequency(BillsFrequency frequency) {
    selectedFrequency.value = frequency;
  }
}
