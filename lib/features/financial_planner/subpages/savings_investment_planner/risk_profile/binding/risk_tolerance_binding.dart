import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/risk_tolerance_controller.dart';

class RiskToleranceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiskToleranceController>(() => RiskToleranceController());
  }
}
