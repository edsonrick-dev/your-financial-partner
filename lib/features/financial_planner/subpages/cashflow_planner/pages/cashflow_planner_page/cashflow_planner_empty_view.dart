import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CashflowPlannerEmptyView extends GetView<CashflowController> {
  const CashflowPlannerEmptyView({super.key});

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
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      PhosphorIconsRegular.coins,
                      size: 60,
                      color: colorScheme.appAccent,
                    ),
                    Text(
                      "Ascend's Cashflow Planner",
                      style: AppTextStyle.headlineL,
                    ),

                    Text(
                      "See where your money comes from and where it's planned to go.",
                      style: AppTextStyle.headlineS,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Add your income and budget plans. Ascend will show how "
                      "much money you have available, how it's allocated, and "
                      "whether your plan leaves you with a surplus.",
                      style: AppTextStyle.bodyM.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    AppButton(
                      text: 'Build your cashflow plan',
                      onTap: () {
                        Get.toNamed(Routes.CASHFLOWDETAILS);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            // Spacer(),
            AppSection(
              sectionTitle: 'What is Cashflow?',
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
                              FittedBox(
                                child: Text(
                                  'Cashflow = Money In – Money Out',
                                  style: AppTextStyle.labelM,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Cash flow shows how money moves into and "
                                "out of your finances. Your budget plans "
                                "where your money should go, while "
                                "transactions record where it actually goes.",
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
    // AppSection(
    //   child: FinancialPlannerEmptySection(
    //     icon: PhosphorIconsRegular.wallet,
    //     title: 'Plan your cashflow',
    //     description:
    //         'Start by adding your expected income then budget where it should go. Ascend will help you compare your plan with what actually happens as you use the app.',
    //     actionText: 'Set up your income plan',
    //     onTap: () {
    //       controller.seletectedDetailsTabIndex(0);
    //       Get.toNamed(Routes.CASHFLOWDETAILS);
    //     },
    //   ),
    // );
  }
}
