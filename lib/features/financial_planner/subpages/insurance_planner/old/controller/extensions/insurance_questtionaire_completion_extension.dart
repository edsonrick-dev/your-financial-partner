import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';

extension InsuranceEmptyScreenValidator on InsurancePlannerController {
  Future<void> checkInsuranceQuestionnaireCompletion() async {
    final scenarios = await database.protectionDao.getProtectionScenarios();

    final configuredTypes = scenarios
        .where((scenario) => scenario.horizon != null)
        .map((scenario) => scenario.protectionType)
        .toSet();

    isInsuranceQuestionnairesFinished.value = ProtectionType.values.every(
      (type) => configuredTypes.contains(type.name),
    );
  }
}
