import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_controller.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_option_tile.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class OnboardingFifthQuestion extends GetView<OnboardingController> {
  const OnboardingFifthQuestion({super.key});

  static const focus = [
    "Spending",
    'Bills',
    'Savings',
    'Debt',
    'Investments',
    'Net Worth',
    'Insurance',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          AppSection(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Which parts of your finances do you currently keep an eye on?',
                  style: AppTextStyle.displayM,
                ),

                const SizedBox(height: 12),

                Text('Select all that apply.', style: AppTextStyle.bodyL),

                const SizedBox(height: 24),

                // Expanded(
                //   child: SingleChildScrollView(
                //     child: Obx(
                //       () => Column(
                //         children: [
                //           _FinancialFocusOption(
                //             label: 'Spending',
                //             isSelected: controller.financialFocus.contains(
                //               'spending',
                //             ),
                //             onTap: () {
                //               controller.toggleFinancialFocus('spending');
                //             },
                //           ),

                //           const SizedBox(height: 12),

                //           _FinancialFocusOption(
                //             label: 'Bills',
                //             isSelected: controller.financialFocus.contains(
                //               'bills',
                //             ),
                //             onTap: () {
                //               controller.toggleFinancialFocus('bills');
                //             },
                //           ),

                //           const SizedBox(height: 12),

                //           _FinancialFocusOption(
                //             label: 'Savings',
                //             isSelected: controller.financialFocus.contains(
                //               'savings',
                //             ),
                //             onTap: () {
                //               controller.toggleFinancialFocus('savings');
                //             },
                //           ),

                //           const SizedBox(height: 12),

                //           _FinancialFocusOption(
                //             label: 'Debt',
                //             isSelected: controller.financialFocus.contains(
                //               'debt',
                //             ),
                //             onTap: () {
                //               controller.toggleFinancialFocus('debt');
                //             },
                //           ),

                //           const SizedBox(height: 12),

                //           _FinancialFocusOption(
                //             label: 'Investments',
                //             isSelected: controller.financialFocus.contains(
                //               'investments',
                //             ),
                //             onTap: () {
                //               controller.toggleFinancialFocus('investments');
                //             },
                //           ),

                //           const SizedBox(height: 12),

                //           _FinancialFocusOption(
                //             label: 'Net worth',
                //             isSelected: controller.financialFocus.contains(
                //               'net_worth',
                //             ),
                //             onTap: () {
                //               controller.toggleFinancialFocus('net_worth');
                //             },
                //           ),

                //           const SizedBox(height: 12),

                //           _FinancialFocusOption(
                //             label: 'Insurance',
                //             isSelected: controller.financialFocus.contains(
                //               'insurance',
                //             ),
                //             onTap: () {
                //               controller.toggleFinancialFocus('insurance');
                //             },
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              itemCount: focus.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final option = focus[index];
                return Obx(
                  () => OnboardingOptionTile(
                    title: option,
                    isSelected: controller.isFocusSelected(option),
                    onTap: () => controller.toggleFinancialFocus(option),
                  ),
                );
              },
            ),
          ),
          AppSection(
            child: AppButton(
              text: 'Continue',
              onTap: () {
                Get.toNamed(Routes.ONBOARDING_ASCEND_STABILITY_SCORE_VIEW);
              },
            ),
          ),
          SizedBox(height: context.bottomPadding),
        ],
      ),
    );
  }
}
