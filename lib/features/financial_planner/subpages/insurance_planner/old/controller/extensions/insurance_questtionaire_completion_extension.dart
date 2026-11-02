import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/protection_types.dart';

final _insuranceQuestionnaireStorage = GetStorage();

extension InsuranceEmptyScreenValidator on InsurancePlannerController {
  Future<void> checkInsuranceQuestionnaireCompletion() async {
    final scenarios = await database.protectionDao.getProtectionScenarios();

    final configuredTypes = scenarios
        .where((scenario) => scenario.horizon != null)
        .map((scenario) => scenario.protectionType)
        .toSet();

    final allHorizonsConfigured = ProtectionType.values.every(
      (type) => configuredTypes.contains(type.name),
    );
    final lifestyleContinuityAnswered = await database.protectionDao
        .hasContinuityShares();
    final activePlan = await database.protectionDao.getActiveProtectionPlan();
    var allLifestyleNeedsComputed = activePlan != null;
    var onboardingExplicitlyFinished = false;

    if (activePlan != null) {
      final completionKey = _completionKey(activePlan.id, activePlan.createdAt);
      onboardingExplicitlyFinished =
          _insuranceQuestionnaireStorage.read<bool>(completionKey) ?? false;

      for (final type in ProtectionType.values) {
        final result = await database.protectionDao.getExpenseContinuity(
          protectionPlanId: activePlan.id,
          protectionType: type,
        );
        if (result == null) {
          allLifestyleNeedsComputed = false;
          break;
        }
      }
    }

    isInsuranceQuestionnairesFinished.value =
        allHorizonsConfigured &&
        lifestyleContinuityAnswered &&
        allLifestyleNeedsComputed &&
        onboardingExplicitlyFinished;
  }

  Future<void> finishInsuranceQuestionnaireOnboarding() async {
    final activePlan = await database.protectionDao.getActiveProtectionPlan();
    if (activePlan == null) return;

    await _insuranceQuestionnaireStorage.write(
      _completionKey(activePlan.id, activePlan.createdAt),
      true,
    );
    await checkInsuranceQuestionnaireCompletion();
  }

  String _completionKey(int planId, DateTime createdAt) =>
      'insurance_questionnaire_finished_${planId}_${createdAt.microsecondsSinceEpoch}';
}
