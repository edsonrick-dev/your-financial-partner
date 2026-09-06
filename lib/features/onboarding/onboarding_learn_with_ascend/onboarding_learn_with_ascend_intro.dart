import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_controller.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_stability_guage.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class OnboardingLearnWithAscendIntro extends GetView<OnboardingController> {
  const OnboardingLearnWithAscendIntro({super.key});

  @override
  Widget build(BuildContext context) {
    // final colorScheme = context.colors;
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   'Financial Stability Profile',
        //   style: AppTextStyle.headlineL,
        // ),
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Spacer(),
                  SizedBox(
                    width: 360,
                    // padding: const EdgeInsets.symmetric(horizontal: 72.0),
                    child: Image.asset(
                      'assets/images/learn_with_ascend_illustration.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Ascend adds to your learning arsenal',
                      style: AppTextStyle.displayM,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      'You alread learn about money from differents sources. Ascend builds on that by recommending topics that match your financial profile.',
                      style: AppTextStyle.bodyL,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),

            AppSection(
              child: AppButton(
                text: 'See what it looks like',
                onTap: () {
                  Get.toNamed(Routes.ONBOARDING_LEARN_WITH_ASCEND_PREVIEW);
                },
              ),
            ),
            SizedBox(height: context.bottomPadding),
          ],
        ),
      ),
    );
  }
}

class PersonaCard extends StatelessWidget {
  const PersonaCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.bgLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Image.asset(
                  'assets/images/onboarding_savings_investment_preview.png',
                  fit: BoxFit.fitWidth,
                  width: 80,
                ),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Person A', style: AppTextStyle.titleM),
                  Text(120000.toCurrency(), style: AppTextStyle.amountS),
                  Text(
                    'Monthly income',
                    style: AppTextStyle.labelXS.copyWith(
                      color: colorScheme.appTextMuted,
                    ),
                  ),
                  SizedBox(width: 12),
                  Row(
                    children: [
                      FinancialStabilityGauge(
                        guageSize: 60,
                        scoreSize: 16,
                        score: 58,
                        colorScheme: colorScheme,
                      ),
                      SizedBox(width: 12),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: colorScheme.appAccent.withValues(alpha: 0.2),
                        ),
                        child: Text(
                          'Fair',
                          style: AppTextStyle.labelXS.copyWith(
                            color: colorScheme.appAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          Divider(),
          Column(children: []),
        ],
      ),
    );
  }
}
