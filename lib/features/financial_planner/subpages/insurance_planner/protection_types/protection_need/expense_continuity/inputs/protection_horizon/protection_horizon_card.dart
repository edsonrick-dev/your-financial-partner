import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/controller/protection_questionnaire_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/1_protection_horizon_questionnaire/protection_horizon_questionnaire_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/home/bindings/protection_questionnaire_binding.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class ProtectionHorizonCard extends GetView<ProtectionQuestionnaireController> {
  const ProtectionHorizonCard({
    super.key,
    required this.type,
    required this.planEndDate,
  });

  final ProtectionType type;
  final DateTime planEndDate;

  String _formatCoveredPeriod(ProtectionHorizon horizon) {
    final startYear = planEndDate.year;
    final years = horizon.years;

    if (years == null) {
      return '$startYear - Until retirement';
    }

    final endYear = startYear + years - 1;

    return '$startYear - $endYear';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Obx(() {
      final horizon = controller.getHorizonObservable(type).value;

      return AppCard(
        onTap: () {
          Get.to(
            () => ProtectionHorizonQuestionnaire(type: type),
            binding: ProtectionQuestionnaireBinding(),
          );
        },
        padding: 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Protection horizon', style: AppTextStyle.titleL),
                ),
                Text(horizon.horizonLabel, style: AppTextStyle.titleL),
              ],
            ),
            SizedBox(height: 8),
            Text(
              type.horizonExplainerText,
              style: AppTextStyle.labelM.copyWith(
                color: colorScheme.appTextMuted,
              ),
            ),
            if (horizon != ProtectionHorizon.zero) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text('Covered period:', style: AppTextStyle.bodyM),
                  ),
                  Text(
                    _formatCoveredPeriod(horizon),
                    style: AppTextStyle.amountM,
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    });
  }
}
