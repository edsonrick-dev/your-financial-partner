import 'dart:async';

import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/protection_horizon_questionnaire/models/protection_horizon_answers.dart';

class ProtectionQuestionnaireController extends GetxController {
  final deathBenefitHorizon = ProtectionHorizon.zero.obs;

  final criticalIllnessBenefitHorizon = ProtectionHorizon.one.obs;

  final disabilityBenefitHorizon = ProtectionHorizon.two.obs;

  void setDeathBenefitHorizon(ProtectionHorizon horizon) {
    deathBenefitHorizon.value = horizon;
  }

  void setCriticalIllnessBenefitHorizon(ProtectionHorizon horizon) {
    criticalIllnessBenefitHorizon.value = horizon;
  }

  void setDisabilityBenefitHorizon(ProtectionHorizon horizon) {
    disabilityBenefitHorizon.value = horizon;
  }

  ProtectionHorizonAnswers get protectionHorizonAnswers {
    return ProtectionHorizonAnswers(
      death: deathBenefitHorizon.value,
      criticalIllness: criticalIllnessBenefitHorizon.value,
      disability: disabilityBenefitHorizon.value,
    );
  }

  Future<void> saveProtectionHorizon() async {
    final profile = await database.userProfileDao.getProfile();

    print('USER PROFILE: $profile');

    await database.protectionDao.saveProtectionHorizons(
      protectionHorizonAnswers,
    );

    Get.back();
  }

  // Future<void> saveProtectionHorizon() async {
  //   await database.protectionDao.saveProtectionHorizons(
  //     protectionHorizonAnswers,
  //   );

  //   Get.back();
  // }

  Future<void> loadProtectionHorizons() async {
    final scenarios = await database.protectionDao.getProtectionScenarios();

    for (final scenario in scenarios) {
      final horizon = ProtectionHorizon.values.firstWhere(
        (value) => value.name == scenario.horizon,
        orElse: () => ProtectionHorizon.zero,
      );

      switch (scenario.protectionType) {
        case 'death':
          deathBenefitHorizon.value = horizon;
          break;

        case 'criticalIllness':
          criticalIllnessBenefitHorizon.value = horizon;
          break;

        case 'disability':
          disabilityBenefitHorizon.value = horizon;
          break;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadProtectionHorizons();
  }
}
