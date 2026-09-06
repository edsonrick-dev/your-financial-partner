import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_controller.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_stability_guage.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class OnboardingFinancialStabilityPreview
    extends GetView<OnboardingController> {
  const OnboardingFinancialStabilityPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Financial Stability Profile',
          style: AppTextStyle.headlineL,
        ),
        surfaceTintColor: Colors.transparent,
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Know your stability profile. Know what to improve.',
                    style: AppTextStyle.displayM,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    '''Here's a sample profile to see how Ascend looks at your finances. This profile gives you a clearer picture of your strengths and areas to work on.''',
                    style: AppTextStyle.bodyL,
                  ),

                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          AppSection(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                16,
                                20,
                                16,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.bgLight,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: AppShadows.card(colorScheme.appText),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FinancialStabilityGauge(
                                    score: 57,
                                    colorScheme: colorScheme,
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Good Stability',
                                          style: AppTextStyle.headlineM
                                              .copyWith(
                                                color: colorScheme.appText,
                                              ),
                                        ),

                                        Text(
                                          'Your finances are stable with room for optimization.',
                                          style: AppTextStyle.bodyM.copyWith(
                                            color: colorScheme.appText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          AppSection(
                            sectionTitle: 'Financial Ratios',
                            child: Column(
                              spacing: 12,
                              children: [
                                IntrinsicHeight(
                                  child: Row(
                                    spacing: 12,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: colorScheme.bgLight,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: colorScheme.text
                                                    .withValues(alpha: 0.06),
                                                blurRadius: 8,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 48,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'Debt Load',
                                                        style:
                                                            AppTextStyle.titleL,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              const SizedBox(height: 8),
                                              Text(
                                                '8%',
                                                style: AppTextStyle.headlineM,
                                              ),

                                              const Spacer(),
                                              Text(
                                                'Very Light',
                                                style: AppTextStyle.bodyM
                                                    .copyWith(
                                                      color: Color(0xFF22C55E),
                                                    ),
                                              ),
                                              const SizedBox(height: 4),

                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF22C55E),
                                                  borderRadius:
                                                      BorderRadius.circular(99),
                                                ),
                                                child: Text(
                                                  '25 pts',
                                                  style: AppTextStyle.labelM
                                                      .copyWith(
                                                        color:
                                                            colorScheme.bgLight,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: colorScheme.bgLight,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: colorScheme.text
                                                    .withValues(alpha: 0.06),
                                                blurRadius: 8,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 48,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'Wealth Building',
                                                        style:
                                                            AppTextStyle.titleL,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              const SizedBox(height: 8),
                                              Text(
                                                '25%',
                                                style: AppTextStyle.headlineM,
                                              ),

                                              const Spacer(),
                                              Text(
                                                'Very High Pace',
                                                style: AppTextStyle.bodyM
                                                    .copyWith(
                                                      color: Color(0xFF059669),
                                                    ),
                                              ),
                                              const SizedBox(height: 4),

                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF059669),
                                                  borderRadius:
                                                      BorderRadius.circular(99),
                                                ),
                                                child: Text(
                                                  '25 pts',
                                                  style: AppTextStyle.labelM
                                                      .copyWith(
                                                        color:
                                                            colorScheme.bgLight,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    spacing: 12,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: colorScheme.bgLight,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: colorScheme.text
                                                    .withValues(alpha: 0.06),
                                                blurRadius: 8,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 48,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'Emergency Fund',
                                                        style:
                                                            AppTextStyle.titleL,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              const SizedBox(height: 8),
                                              Text(
                                                '6 months',
                                                style: AppTextStyle.headlineM,
                                              ),

                                              const Spacer(),
                                              Text(
                                                'Adequeate Fund',
                                                style: AppTextStyle.bodyM
                                                    .copyWith(
                                                      color: Color(0xFF16A34A),
                                                    ),
                                              ),
                                              const SizedBox(height: 4),

                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF16A34A),
                                                  borderRadius:
                                                      BorderRadius.circular(99),
                                                ),
                                                child: Text(
                                                  '11 pts',
                                                  style: AppTextStyle.labelM
                                                      .copyWith(
                                                        color:
                                                            colorScheme.bgLight,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: colorScheme.bgLight,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: colorScheme.text
                                                    .withValues(alpha: 0.06),
                                                blurRadius: 8,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 48,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'Lifestyle Coverage',
                                                        style:
                                                            AppTextStyle.titleL,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              const SizedBox(height: 8),
                                              Text(
                                                '0.5x',
                                                style: AppTextStyle.headlineM,
                                              ),

                                              const Spacer(),
                                              Text(
                                                'Partially Covered',
                                                style: AppTextStyle.bodyM
                                                    .copyWith(
                                                      color: Color(0xFFCA8A04),
                                                    ),
                                              ),
                                              const SizedBox(height: 4),

                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFCA8A04),
                                                  borderRadius:
                                                      BorderRadius.circular(99),
                                                ),
                                                child: Text(
                                                  '10 pts',
                                                  style: AppTextStyle.labelM
                                                      .copyWith(
                                                        color:
                                                            colorScheme.bgLight,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Container(
            //   padding: EdgeInsets.all(12),
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: colorScheme.bgLight,
            //     border: Border.all(color: colorScheme.appBorder),
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Row(
            //     children: [
            //       Stack(
            //         alignment: Alignment.center,
            //         children: [
            //           Icon(PhosphorIconsRegular.lightbulb),
            //           Container(
            //             width: 44,
            //             height: 44,
            //             decoration: BoxDecoration(
            //               color: colorScheme.appInfoSoft,
            //               shape: BoxShape.circle,
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(width: 12),
            //       Expanded(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               'Your finances are inter-connected',
            //               style: AppTextStyle.titleL,
            //             ),
            //             Text(
            //               'When one are changes, it affects the others.',
            //               style: AppTextStyle.bodyM,
            //             ),
            //           ],
            //         ),
            //       ),
            //       const SizedBox(height: 24),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 8),
            AppButton(
              text: 'Continue',
              onTap: () {
                Get.toNamed(Routes.ONBOARDING_SIXTH_QUESTION);
              },
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

// class _RatioCard extends StatelessWidget {
//   const _RatioCard({
//     required this.ratioName,
//     required this.state,
//     required this.score,
//     required this.color,
//     required this.scoreColor,
//     required this.icon,
//   });
//   final String ratioName;
//   final String state;
//   final int score;
//   final Color color;
//   final Color scoreColor;
//   final IconData icon;
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = context.colors;
//     return Container(
//       padding: EdgeInsets.fromLTRB(8, 4, 12, 4),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: colorScheme.appBorderMuted),
//         color: colorScheme.bgLight,
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 height: 36,
//                 width: 36,
//                 decoration: BoxDecoration(
//                   color: color.withValues(alpha: 0.1),
//                   shape: BoxShape.circle,
//                 ),
//               ),
//               Icon(icon, size: 18, color: color),
//             ],
//           ),
//           SizedBox(width: 4),
//           Expanded(
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Text(ratioName, style: AppTextStyle.labelS),
//                     Spacer(),
//                     Text(
//                       score.toString(),
//                       style: AppTextStyle.amountS.copyWith(color: scoreColor),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 2),
//                 Row(
//                   children: [
//                     // Spacer(),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(999),
//                         color: scoreColor.withValues(alpha: 0.2),
//                       ),
//                       child: Text(
//                         state,
//                         style: AppTextStyle.labelXS.copyWith(color: scoreColor),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
