import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_controller.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OnboardingFinancialPlannersPreview extends GetView<OnboardingController> {
  const OnboardingFinancialPlannersPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ascend brings your financial picture together.',
            style: AppTextStyle.displayM,
          ),

          const SizedBox(height: 16),

          Text(
            'Our all-in-one financial planners help you understand, plan, and grow with confidence.',
            style: AppTextStyle.bodyL,
          ),

          const SizedBox(height: 8),

          Expanded(
            child: SingleChildScrollView(
              controller: controller.plannerScrollController,
              physics: const ClampingScrollPhysics(),
              child: Obx(
                () => Column(
                  children: [
                    const SizedBox(height: 24),
                    _IntroPlannerCard(
                      key: controller.cashFlowKey,
                      icon: PhosphorIconsRegular.wallet,
                      color: Colors.green,
                      title: 'Cash Flow Planner',
                      description:
                          'Track income, manage expenses, and plan your budget.',
                      image: 'assets/images/onboarding_cash_flow_preview.png',
                      isExpanded:
                          controller.expandedPlanner.value == 'cash_flow',
                      onTap: () {
                        controller.togglePlanner('cash_flow');
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          controller.scrollToPlanner(controller.cashFlowKey);
                        });
                      },
                    ),

                    const SizedBox(height: 12),

                    _IntroPlannerCard(
                      icon: PhosphorIconsRegular.houseLine,
                      color: Colors.orange,
                      title: 'Net Worth Planner',
                      description:
                          'See your total assets, liabilities, and overall financial progress.',
                      image: 'assets/images/onboarding_net_worth_preview.png',
                      isExpanded:
                          controller.expandedPlanner.value == 'net_worth',
                      onTap: () {
                        controller.togglePlanner('net_worth');
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          controller.scrollToPlanner(controller.netWorthKey);
                        });
                      },
                      key: controller.netWorthKey,
                    ),

                    const SizedBox(height: 12),

                    _IntroPlannerCard(
                      icon: PhosphorIconsRegular.shieldCheck,
                      color: Colors.purple,
                      title: 'Insurance Planner',
                      description:
                          'Make sure you and your loved ones are financially protected.',
                      image: 'assets/images/onboarding_insurance_preview.png',
                      isExpanded:
                          controller.expandedPlanner.value == 'insurance',
                      onTap: () {
                        controller.togglePlanner('insurance');
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          controller.scrollToPlanner(controller.insuranceKey);
                        });
                      },
                      key: controller.insuranceKey,
                    ),

                    const SizedBox(height: 12),

                    _IntroPlannerCard(
                      icon: PhosphorIconsRegular.chartBar,
                      color: Colors.blue,
                      title: 'Savings & Investment Planner',
                      description:
                          'Plan your savings, explore investments, and build wealth.',
                      image:
                          'assets/images/onboarding_savings_investment_preview.png',
                      isExpanded:
                          controller.expandedPlanner.value ==
                          'savings_investment',
                      onTap: () {
                        controller.togglePlanner('savings_investment');
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          controller.scrollToPlanner(
                            controller.savingsInvestmentKey,
                          );
                        });
                      },
                      key: controller.savingsInvestmentKey,
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// class _IntroPlannerCard extends StatelessWidget {
//   const _IntroPlannerCard({
//     required this.title,
//     required this.description,
//     required this.color,
//     required this.icon,
//   });

//   final String title;
//   final String description;
//   final Color color;
//   final IconData icon;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: color.withValues(alpha: 0.1),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: color),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Icon(icon, size: 48, color: color),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         style: AppTextStyle.titleL.copyWith(color: color),
//                       ),

//                       const SizedBox(height: 4),

//                       Text(description, style: AppTextStyle.bodyM),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: 16),
//           Icon(PhosphorIconsRegular.caretDown, size: 20, color: color),
//         ],
//       ),
//     );
//   }
// }
class _IntroPlannerCard extends StatelessWidget {
  const _IntroPlannerCard({
    super.key,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
    required this.isExpanded,
    required this.onTap,
    required this.image,
  });

  final String title;
  final String description;
  final Color color;
  final IconData icon;
  final bool isExpanded;
  final VoidCallback onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, size: 48, color: color),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyle.titleL.copyWith(color: color),
                      ),

                      const SizedBox(height: 4),

                      Text(description, style: AppTextStyle.bodyM),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                AnimatedRotation(
                  duration: const Duration(milliseconds: 250),
                  turns: isExpanded ? 0.5 : 0,
                  child: Icon(
                    PhosphorIconsRegular.caretDown,
                    size: 20,
                    color: color,
                  ),
                ),
              ],
            ),

            if (isExpanded) ...[
              const SizedBox(height: 16),

              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
