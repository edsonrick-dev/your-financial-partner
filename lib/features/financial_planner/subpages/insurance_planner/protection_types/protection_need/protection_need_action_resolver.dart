import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/benefits/expense_continuity/expense_continuity_fund_details.dart';

import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';

class ProtectionNeedActionResolver {
  ProtectionNeedActionResolver._();

  static VoidCallback? resolve({
    required ProtectionType type,
    required ProtectionNeedType needType,
    required InsurancePlannerController controller,
  }) {
    switch ((type, needType)) {
      case (
        ProtectionType.death ||
            ProtectionType.criticalIllness ||
            ProtectionType.disability,
        ProtectionNeedType.expenseContinuity,
      ):
        return () =>
            _openExpenseContinuitySheet(type: type, controller: controller);
      default:
        return null;
    }
  }

  static Future<void> _openExpenseContinuitySheet({
    required ProtectionType type,
    required InsurancePlannerController controller,
  }) async {
    final scenarios = await database.protectionDao.getProtectionScenarios();

    final scenario = scenarios.firstWhereOrNull(
      (scenario) => scenario.protectionType == type.name,
    );

    final details = switch (type) {
      ProtectionType.death =>
        controller.deathBenefitResult.value?.expenseContinuityDetails,
      ProtectionType.criticalIllness =>
        controller.criticalIllnessBenefitResult.value?.expenseContinuityDetails,
      ProtectionType.disability =>
        controller.disabilityBenefitResult.value?.expenseContinuityDetails,
    };

    Get.bottomSheet(
      ExpenseContinuityFundDetailsSheet(
        type: type,
        data: details,
        savedHorizon: scenario?.horizon,
      ),
      isScrollControlled: true,
    );
  }
}
