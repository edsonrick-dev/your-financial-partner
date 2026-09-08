import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/metric_bar_row.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/sections/networth_summary_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/widgets/account_overview.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/balance_sheet_type_enum.dart';
import 'package:getx_drift_app/features/widgets/app_tab_switcher.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class NetWorthPlannerContent extends GetView<NetWorthController> {
  const NetWorthPlannerContent({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Column(
      spacing: 20,
      children: [
        Obx(
          () => NetWorthSummaryContainerSection(
            netWorth: controller.netWorth,
            baselineNetWorth: controller.baselineNetWorth.value,
            comparisonType: controller.netWorthComparison.value,
            onComparisonChanged: controller.setNetWorthComparison,
          ),
        ),

        AppSection(
          sectionTitle: 'Wealth Overview',
          trailingType: SectionTrailingType.textButton,
          trailingText: 'View Accounts',
          onTrailingPressed: () {
            Get.toNamed(Routes.NETWORTHDETAILS);
          },
          child: Column(
            spacing: 20,
            children: [
              AppSectionBody(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => Column(
                      spacing: 8,
                      children: [
                        MetricBarRow(
                          label: 'Assets',
                          amount: controller.totalAssets,
                          ratio: controller.assetRatio,
                          color: colorScheme.appInflow,
                        ),

                        MetricBarRow(
                          label: 'Liabilities',
                          amount: controller.totalLiabilities,
                          ratio: controller.liabilityRatio,
                          color: colorScheme.appOutflow,
                        ),

                        MetricBarRow(
                          label: 'Net Worth',
                          amount: controller.netWorth,
                          ratio: controller.netWorthRatio,
                          color: colorScheme.appInfo,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AppSectionBody(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                  child: Column(
                    children: [
                      // Obx(
                      //   () => AdaptivePressable(
                      //     onTap: () {
                      //       Get.toNamed(Routes.NETWORTHDETAILS);
                      //     },
                      //     child: SizedBox(
                      //       height: 32,
                      //       child: Text(
                      //         'Open ${controller.selectedView.value.plural} Details Page',
                      //         style: AppTextStyle.bodyM,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Obx(
                        () => Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: colorScheme.bg,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: colorScheme.appBorder),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TabSwitcher(
                                    label: 'Assets',
                                    isActive:
                                        controller.selectedView.value ==
                                        BalanceSheetType.asset,
                                    onTap: () {
                                      controller.seletectedDetailsTabIndex(0);
                                      controller.selectBalanceSheetType(
                                        BalanceSheetType.asset,
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TabSwitcher(
                                    label: 'Liabilities',
                                    isActive:
                                        controller.selectedView.value ==
                                        BalanceSheetType.liability,
                                    onTap: () {
                                      controller.seletectedDetailsTabIndex(1);
                                      controller.selectBalanceSheetType(
                                        BalanceSheetType.liability,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(() {
                        final isEmpty = controller.displayedGroupTotals.isEmpty;

                        if (isEmpty) {
                          return EmptyBalanceSheetView(
                            type: controller.selectedView.value,
                          );
                        }

                        return Column(
                          spacing: 12,
                          children: controller.displayedGroupTotals.entries.map(
                            (entry) {
                              final group = entry.key;
                              final amount = entry.value;

                              return AccountOverview(
                                icon: group.icon,
                                type: group.label,
                                amount: amount,
                                percentage: controller.groupPercentage(group),
                                color: group.color,
                                percentageLabel:
                                    controller.selectedView.value ==
                                        BalanceSheetType.asset
                                    ? 'Assets'
                                    : 'Liabilities',
                              );
                            },
                          ).toList(),
                        );
                      }),
                      SizedBox(height: 20),

                      // Divider(color: colorScheme.appTextMuted),

                      // Obx(
                      //   () => AppButton(
                      //     onTap: () {
                      //       Get.toNamed(Routes.NETWORTHDETAILS);
                      //     },
                      //     type: ButtonType.ghost,
                      //     text: 'View ${controller.selectedView.value.plural}',
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EmptyBalanceSheetView extends StatelessWidget {
  final BalanceSheetType type;

  const EmptyBalanceSheetView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Icon(Icons.account_balance_wallet_outlined, size: 24),
          // const SizedBox(height: 12),
          Text(
            'You have no ${type.plural.toLowerCase()}',
            style: AppTextStyle.bodyM.copyWith(color: context.colors.textMuted),
          ),
          // Text('Add your first ${type.name} to get started.'),
        ],
      ),
    );
  }
}
