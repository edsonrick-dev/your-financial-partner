import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/binding/insurance_policy_binding.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy_form.dart';

Future<T?> showAddPolicyForm<T>() {
  InsurancePolicyBinding().dependencies();

  return Get.bottomSheet<T>(const AddPolicyForm(), isScrollControlled: true);
}
