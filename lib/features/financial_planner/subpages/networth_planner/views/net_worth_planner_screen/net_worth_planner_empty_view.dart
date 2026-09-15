import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NetWorthEmptyView extends StatelessWidget {
  const NetWorthEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          top: context.topPadding,

          bottom: context.bottomPadding,
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      PhosphorIconsRegular.wallet,
                      size: 60,
                      color: colorScheme.appAccent,
                    ),
                    Text(
                      "Ascend's Networth Planner",
                      style: AppTextStyle.headlineL,
                    ),
                    SizedBox(height: 0),
                    Text(
                      "See what you own and what you owe.",
                      style: AppTextStyle.headlineS,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Add your assets and liabilities. Ascend will calculate your net worth and help you understand your financial position.",
                      style: AppTextStyle.bodyM.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    // SizedBox(height: context.bottomPadding),
                    // AppButton(
                    //   text: 'Add your first account',
                    //   onTap: () {
                    //     Get.toNamed(Routes.NETWORTHDETAILS);
                    //   },
                    // ),
                    // FinancialPlannerEmptySection(
                    //   icon: PhosphorIconsRegular.wallet,
                    //   title: 'Build your net worth',
                    //   description:
                    //       'Start by adding accounts that represent what you own and what you owe. AscendYFP will calculate your net worth and help you track how your financial position changes over time.',
                    //   actionText: 'Add your first account',
                    //   onTap: () {
                    //     Get.toNamed(Routes.NETWORTHDETAILS);
                    //   },
                    // ),
                    SizedBox(height: 20),
                    AppButton(
                      text: 'Build your net worth plan',
                      onTap: () {
                        Get.toNamed(Routes.NETWORTHDETAILS);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            // Spacer(),
            AppSection(
              sectionTitle: 'What is Net Worth?',
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(minHeight: 52),
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: colorScheme.bgLight,
                      border: Border.all(color: colorScheme.appBorder),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.text.withValues(alpha: 0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Net Worth = Assets – Liabilities',
                                style: AppTextStyle.labelM,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Your net worth is the difference between what you own (assets) and what you owe (liabilities)',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
