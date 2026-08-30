import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NetWorthEmptyView extends StatelessWidget {
  const NetWorthEmptyView({super.key});

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
                      PhosphorIconsRegular.wallet,
                      size: 56,
                      color: colorScheme.appAccent,
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Build your net worth',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.headlineL,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Start by adding accounts that represent '
                      'what you own and what you owe. AscendYFP will '
                      'calculate your net worth and help you track '
                      'how your financial position changes over time.',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodyL.copyWith(
                        // color: colorScheme.appTextMuted,
                      ),
                    ),

                    const SizedBox(height: 32),
                    AppButton(
                      text: 'Add your first account',
                      onTap: () {
                        Get.toNamed(Routes.NETWORTHDETAILS);
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
              LearnThumbnail(title: 'What is Net Worth?'),
              LearnThumbnail(title: 'What Are Assets?'),
              LearnThumbnail(title: 'What Are Liabilities?'),
            ],
          ),
        ],
      ),
    );
  }
}
