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

class OnboardingFinancialStabilityScoreIntro
    extends GetView<OnboardingController> {
  const OnboardingFinancialStabilityScoreIntro({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
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
                    width: 200,
                    // padding: const EdgeInsets.symmetric(horizontal: 72.0),
                    child: Image.asset(
                      'assets/icons/ascendyfp_logo_light.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Ascend helps you see what those numbers are saying',
                      style: AppTextStyle.displayM,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      'You already pay attention to certain parts of your finances. Ascend brings them together and shows how they connect with the rest of your financial picture.',
                      style: AppTextStyle.bodyL,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),

            // const SizedBox(height: 8),
            // // Temporary illustration area.
            // // Replace this with your actual illustration.
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Column(
            //       children: [
            //         // const _FinancialRelationshipDiagram(),
            //         const SizedBox(height: 24),
            //         Row(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           spacing: 16,
            //           children: [
            //             Flexible(
            //               flex: 2,
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text('Financial Stability'),
            //                   SizedBox(height: 32),
            //                   Center(
            //                     child: Column(
            //                       children: [
            //                         FinancialStabilityGauge(
            //                           guageSize: 100,
            //                           score: 72,
            //                           colorScheme: colorScheme,
            //                         ),
            //                         Text(
            //                           textAlign: TextAlign.center,
            //                           '''You're on a healthy path, with room to grow.''',
            //                           style: AppTextStyle.labelS.copyWith(
            //                             color: colorScheme.appTextMuted,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),

            //             Flexible(
            //               flex: 3,
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text('Key Financial Ratios'),
            //                   SizedBox(height: 8),
            //                   Column(
            //                     spacing: 6,
            //                     children: [
            //                       _RatioCard(
            //                         ratioName: 'Wealth Building',
            //                         state: 'Good',
            //                         score: 78,
            //                         color: colorScheme.appInflow,
            //                         scoreColor: colorScheme.appInflow,
            //                         icon: PhosphorIconsRegular.piggyBank,
            //                       ),
            //                       _RatioCard(
            //                         ratioName: 'Emergency Fund',
            //                         state: 'Good',
            //                         score: 74,
            //                         color: colorScheme.appInfo,
            //                         scoreColor: colorScheme.appInflow,
            //                         icon: PhosphorIconsRegular.shieldPlus,
            //                       ),
            //                       _RatioCard(
            //                         ratioName: 'Debt Load',
            //                         state: 'Fair',
            //                         score: 61,
            //                         color: colorScheme.appAccent,
            //                         scoreColor: colorScheme.appAccent,
            //                         icon: PhosphorIconsRegular.scales,
            //                       ),
            //                       _RatioCard(
            //                         ratioName: 'Lifestyle Coverage',
            //                         state: 'Good',
            //                         score: 61,
            //                         color: Colors.purple,
            //                         scoreColor: colorScheme.appInflow,
            //                         icon: PhosphorIconsRegular.houseLine,
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               'Different paths, different scores',
            //               style: AppTextStyle.headlineS,
            //             ),
            //             Text(
            //               'One metric alone, say income, cannot determine your financial stability.'
            //               'Here are to examples--both may earn well, but their financial health looks very different.',
            //               style: AppTextStyle.bodyS,
            //             ),
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             Expanded(child: PersonaCard()),
            //             SizedBox(width: 8),
            //             Expanded(child: PersonaCard()),
            //           ],
            //         ),
            //         const SizedBox(height: 24),
            //       ],
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 8),
            AppSection(
              child: AppButton(
                text: 'Preview Financial Stability Profile',
                onTap: () {
                  Get.toNamed(Routes.ONBOARDING_ASCEND_STABILITY_PREVIEW_VIEW);
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

class _RatioCard extends StatelessWidget {
  const _RatioCard({
    required this.ratioName,
    required this.state,
    required this.score,
    required this.color,
    required this.scoreColor,
    required this.icon,
  });
  final String ratioName;
  final String state;
  final int score;
  final Color color;
  final Color scoreColor;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Container(
      padding: EdgeInsets.fromLTRB(8, 4, 12, 4),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.appBorderMuted),
        color: colorScheme.bgLight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
              ),
              Icon(icon, size: 18, color: color),
            ],
          ),
          SizedBox(width: 4),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(ratioName, style: AppTextStyle.labelS),
                    Spacer(),
                    Text(
                      score.toString(),
                      style: AppTextStyle.amountS.copyWith(color: scoreColor),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    // Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: scoreColor.withValues(alpha: 0.2),
                      ),
                      child: Text(
                        state,
                        style: AppTextStyle.labelXS.copyWith(color: scoreColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
