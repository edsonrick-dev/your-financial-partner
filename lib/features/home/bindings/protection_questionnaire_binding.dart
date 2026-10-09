import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/controller/protection_questionnaire_controller.dart';

class ProtectionQuestionnaireBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProtectionQuestionnaireController());
  }
}
