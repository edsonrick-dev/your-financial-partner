import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/app_border_radius.dart';
import 'package:getx_drift_app/core/constants/app_scale.dart';
import 'package:getx_drift_app/features/home/controllers/home_controller.dart';
import 'package:getx_drift_app/features/home_initial/widget/transaction_button.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/features/widgets/cards/bills_card.dart';
import 'package:getx_drift_app/features/widgets/cards/budget_card.dart';
import 'package:getx_drift_app/features/widgets/cards/fund_summary_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Scaffold(
      // backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   title: const Text(''),
      //   centerTitle: false,
      //   // actions: [
      //   //   IconButton(
      //   //     onPressed: () {
      //   //       AppSheets.endDrawer.openHomeMenu();
      //   //     },
      //   //     icon: Icon(Icons.menu, size: 24),
      //   //   ),
      //   // ],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 12,
            children: [
              // Container(
              //   padding: EdgeInsets.all(12),
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: colorScheme.appOnSurface,
              //     border: Border.all(color: colorScheme.appBorder),
              //   ),
              //   child: Column(
              //     children: [
              //       Text(
              //         'Primary Text',
              //         style: TextStyle(color: colorScheme.appText, fontSize: 24),
              //       ),
              //       Text(
              //         'Secondary Text',
              //         style: TextStyle(
              //           color: colorScheme.appTextMuted,
              //           fontSize: 24,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              AppSection(
                child: Column(
                  children: [
                    ///Save
                    FundSummaryCard(controller: controller),
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
              AppAdsSection(),

              AppSection(
                sectionTitle: 'Budgets',
                trailingType: SectionTrailingType.textButton,
                trailingText: 'View all',
                onTrailingPressed: () {
                  Get.toNamed(Routes.TRANSACTION);
                },
                // showTrailing: true,
                child: Column(
                  spacing: 12,
                  children: [
                    BudgetCard(
                      title: 'Food',
                      iconKey: 'bowlFood',
                      consumption: 250,
                      budget: 400,
                    ),
                  ],
                ),
              ),
              AppSection(
                sectionTitle: 'Bills',
                trailingType: SectionTrailingType.textButton,
                trailingText: 'View all',
                onTrailingPressed: () {
                  Get.toNamed(Routes.TRANSACTION);
                },
                // showTrailing: true,
                child: Column(
                  spacing: 12,
                  children: [
                    BillsCard(
                      iconKey: 'internet',
                      billName: 'Internet Home Fiber',
                      billType: 'Internet Bill',
                      dueDate: DateTime(2026, 6, 4),
                      amountDue: 6000,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppAdsSection extends StatelessWidget {
  const AppAdsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        spacing: 8,
        children: [
          Container(
            width: double.infinity,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),

              gradient: LinearGradient(
                colors: [const Color(0xFF141C29), const Color(0xFF1E293B)],
              ),
            ),

            padding: const EdgeInsets.all(20),

            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        'Reduce Monthly Expenses',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),
                      Text(
                        'Track subscriptions and discover recurring charges.',
                        style: TextStyle(
                          color: Colors.white.withAlpha(180),
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(999),
                        ),

                        child: const Text(
                          'Analyze Now',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),

                Icon(
                  Icons.insights,
                  color: Colors.white.withAlpha(220),
                  size: 64,
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 2,
            children: [
              Container(
                height: 4,
                width: 12,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Container(
                height: 4,
                width: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Container(
                height: 4,
                width: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
