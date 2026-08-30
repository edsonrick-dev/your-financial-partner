import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CashflowPlannerEmptyView extends GetView<CashflowController> {
  const CashflowPlannerEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          AppSection(
            child: AppSectionBody(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 48,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    Icon(
                      PhosphorIconsRegular.coins,
                      size: 56,
                      color: colorScheme.appAccent,
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Plan your cashflow',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.headlineL,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Start by adding your expected income then budget where it should go. Ascend will help you compare your plan with what actually happens as you use the app.',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodyL.copyWith(
                        // color: colorScheme.appTextMuted,
                      ),
                    ),

                    const SizedBox(height: 32),
                    AppButton(
                      text: 'Set up your income plan',
                      onTap: () {
                        controller.seletectedDetailsTabIndex(0);
                        Get.toNamed(Routes.CASHFLOWDETAILS);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          LearningSection(
            subtitle: 'Build a good understanding of your net worth',
            state: LearningSectionState.available,
            contents: [
              LearnThumbnail(title: 'What is Cashflow?'),
              LearnThumbnail(title: 'What is an Income Plan?'),
              LearnThumbnail(title: 'What is a Budget?'),
            ],
          ),
        ],
      ),
    );
  }
}
