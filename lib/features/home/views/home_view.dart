import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/app_border_radius.dart';
import 'package:getx_drift_app/core/constants/app_scale.dart';
import 'package:getx_drift_app/features/home/controllers/home_controller.dart';
import 'package:getx_drift_app/features/home_initial/widget/transaction_button.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/features/widgets/cards/fund_summary_card.dart';
import 'package:getx_drift_app/features/widgets/fields/shared/field_container.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:intl/intl.dart';

import 'package:month_picker_dialog/month_picker_dialog.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 12,
            children: [
              AppSection(
                child: Column(
                  children: [
                    ///Save
                    FundSummaryCard(),
                    SizedBox(height: AppScale.x3),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: colorScheme.appBorder),
                        borderRadius: BorderRadius.circular(AppBorderRadius.m),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppBorderRadius.m),
                        child: Row(
                          // spacing: 12,
                          children: [
                            TransactionButton(
                              label: 'Earn',
                              color: colorScheme.appInflow,
                              icon: Icons.add,
                              onTap: () {
                                AppSheets.transaction.earn();
                              },
                            ),
                            TransactionButton(
                              color: colorScheme.appOutflow,
                              icon: Icons.remove,
                              label: 'Spend',
                              onTap: () {
                                AppSheets.transaction.spend();
                              },
                            ),
                            TransactionButton(
                              color: colorScheme.appAccent,
                              icon: Icons.sync_alt_sharp,
                              label: 'Transfer',
                              onTap: () {
                                AppSheets.transaction.transfer();
                              },
                            ),
                            TransactionButton(
                              color: colorScheme.appNeutral,
                              icon: Icons.more_horiz,
                              label: 'Others',
                              onTap: () {
                                AppSheets.selection.selectOtherTransaction();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              AppSection(
                sectionTitle: 'My Cashflow',
                child: AppFieldContainer(
                  trailingPadding: 12,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('This Month'),
                          Spacer(),
                          Obx(() {
                            return Row(
                              children: [
                                if (!controller.isCurrentMonth)
                                  TextButton(
                                    onPressed: controller.goToCurrentMonth,
                                    child: const Text('Today'),
                                  ),
                                IconButton(
                                  icon: const Icon(Icons.chevron_left),
                                  onPressed: controller.previousMonth,
                                ),

                                GestureDetector(
                                  onTap: () async {
                                    final month = await showMonthPicker(
                                      context: context,
                                      initialDate:
                                          controller.selectedMonth.value,
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2035),
                                    );

                                    if (month != null) {
                                      controller.setMonth(month);
                                    }
                                  },
                                  child: Text(
                                    DateFormat(
                                      "MMM ''yy",
                                    ).format(controller.selectedMonth.value),
                                  ),
                                ),
                                Obx(
                                  () => IconButton(
                                    icon: const Icon(Icons.chevron_right),
                                    onPressed: controller.canGoNext
                                        ? controller.nextMonth
                                        : null,
                                  ),
                                ),
                              ],
                            );
                          }),
                          // Row(
                          //   children: [
                          //     IconButton(
                          //       icon: const Icon(Icons.chevron_left),
                          //       onPressed: controller.previousMonth,
                          //     ),
                          //     GestureDetector(
                          //       onTap: () async {
                          //         final month = await showMonthPicker(
                          //           context: context,
                          //           initialDate: controller.selectedMonth.value,
                          //           firstDate: DateTime(2020),
                          //           lastDate: DateTime(2035),
                          //         );

                          //         if (month != null) {
                          //           controller.setMonth(month);
                          //         }
                          //       },
                          //       child: Row(
                          //         // crossAxisAlignment: CrossAxisAlignment.center,
                          //         // mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           // Icon(
                          //           //   PhosphorIconsRegular.calendarBlank,
                          //           //   size: 12,
                          //           // ),
                          //           // SizedBox(width: 2),
                          //           Obx(
                          //             () => Text(
                          //               DateFormat('MMMM yyyy').format(
                          //                 controller.selectedMonth.value,
                          //               ),
                          //             ),
                          //           ),
                          //           // SizedBox(width: 4),
                          //           // Icon(
                          //           //   PhosphorIconsRegular.caretDown,
                          //           //   size: 12,
                          //           // ),
                          //         ],
                          //       ),
                          //     ),
                          //     IconButton(
                          //       icon: const Icon(Icons.chevron_right),
                          //       onPressed: controller.nextMonth,
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),

                      SizedBox(height: 16),

                      IntrinsicHeight(
                        child: Obx(() {
                          return StreamBuilder<MonthlyCashFlowSummary>(
                            stream: controller.monthlySummaryStream,
                            builder: (context, snapshot) {
                              final summary =
                                  snapshot.data ??
                                  const MonthlyCashFlowSummary(
                                    totalIn: 0,
                                    totalOut: 0,
                                    // net: 0,
                                  );

                              return Row(
                                children: [
                                  Expanded(
                                    child: CashFlowSummaryCard(
                                      amount: summary.totalIn,
                                      title: 'Inflow',
                                      color: colorScheme.appInflow,
                                    ),
                                  ),

                                  VerticalDivider(color: colorScheme.appBorder),
                                  Expanded(
                                    child: CashFlowSummaryCard(
                                      amount: summary.totalOut,
                                      title: 'Outflow',
                                      color: colorScheme.appOutflow,
                                    ),
                                  ),
                                  VerticalDivider(color: colorScheme.appBorder),
                                  Expanded(
                                    child: CashFlowSummaryCard(
                                      amount: summary.netCashFlow,
                                      title: 'Net Cashflow',
                                      color: colorScheme.appAccent,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CashFlowSummaryCard extends StatelessWidget {
  const CashFlowSummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
  });

  final String title;
  final double amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Stack(
            //   alignment: Alignment.center,
            //   children: [
            //     // Icon(
            //     //   PhosphorIconsRegular.arrowUp,
            //     //   color: colorScheme.appInflow,
            //     //   size: 16,
            //     // ),
            //     Opacity(
            //       opacity: 1,
            //       // opacity: AppOpacity.snackBarIcon,
            //       child: Container(
            //         width: 8,
            //         height: 8,
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           color: color,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                height: 12 / 12,
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            amount.toCompactCurrency(kThreshold: 10000),
            maxLines: 1,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorScheme.appText,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ],
    );
  }
}


// AppSection(
//   sectionTitle: 'Budgets',
//   trailingType: SectionTrailingType.textButton,
//   trailingText: 'View all',
//   onTrailingPressed: () {
//     Get.toNamed(Routes.TRANSACTION);
//   },
//   // showTrailing: true,
//   child: Column(
//     spacing: 12,
//     children: [
//       BudgetCard(
//         title: 'Food',
//         iconKey: 'bowlFood',
//         consumption: 250,
//         budget: 400,
//       ),
//     ],
//   ),
// ),


// AppSection(
//   sectionTitle: 'Bills',
//   trailingType: SectionTrailingType.textButton,
//   trailingText: 'View all',
//   onTrailingPressed: () {
//     Get.toNamed(Routes.TRANSACTION);
//   },
//   child: Column(
//     spacing: 12,
//     children: [
//       BillsCard(
//         iconKey: 'internet',
//         billName: 'Internet Home Fiber',
//         billType: 'Internet Bill',
//         dueDate: DateTime(2026, 6, 4),
//         amountDue: 6000,
//       ),
//     ],
//   ),
// ),