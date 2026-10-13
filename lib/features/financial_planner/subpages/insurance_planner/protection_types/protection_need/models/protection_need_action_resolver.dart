import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/expense_continuity/expense_continuity_page.dart';

import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/home/bindings/protection_questionnaire_binding.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

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
        return () => _openExpenseContinuitySheet(type: type);
      default:
        return null;
    }
  }

  static Future<void> _openExpenseContinuitySheet({
    required ProtectionType type,
  }) async {
    final binding = ProtectionQuestionnaireBinding();
    binding.dependencies();
    Get.bottomSheet(
      AppSheet(
        title: '${type.label} Expense Continuity Fund',
        height: AppSheetHeight.full,
        child: ExpenseContinuityPage(type: type),
      ),
      isScrollControlled: true,
    );
  }
}
