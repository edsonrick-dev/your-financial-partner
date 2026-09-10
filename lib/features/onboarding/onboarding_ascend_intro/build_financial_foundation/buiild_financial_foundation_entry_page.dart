import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class BuiildFinancialFoundationEntryPage extends GetView<OnboardingController> {
  const BuiildFinancialFoundationEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    //  contentSource= controller.contentSource;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: AppSection(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Let’s build your financial foundation.',
                    style: AppTextStyle.displayM,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    '''We'll start with the essentials: where your money lives, how money comes in, and how you plan to use it each month.''',
                    style: AppTextStyle.bodyL,
                  ),

                  const SizedBox(height: 24),

                  Text('PUT SOMETHING HERE'),
                ],
              ),
            ),
          ),

          AppSection(
            child: AppButton(
              text: 'Continue',
              onTap: () {
                Get.toNamed(Routes.ONBOARDING_LEARN_WITH_ASCEND_INTRO);
              },
            ),
          ),
          SizedBox(height: context.bottomPaddingSub),
        ],
      ),
    );
  }
}
