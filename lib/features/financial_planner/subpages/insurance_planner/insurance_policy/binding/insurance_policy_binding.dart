import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/insurance_policy_controller.dart';

class InsurancePolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InsurancePolicyController());
  }
}
