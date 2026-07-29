import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/app_border_radius.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';
import 'package:getx_drift_app/features/home/controllers/home_controller.dart';
import 'package:getx_drift_app/features/home/views/section_views/cashflow_section.dart';
import 'package:getx_drift_app/features/home/widgets/budget_progress_indicator.dart';
import 'package:getx_drift_app/features/home/widgets/budget_tile.dart';
import 'package:getx_drift_app/features/home_initial/widget/transaction_button.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/features/main_shell/controller/main_shell_controller.dart';
import 'package:getx_drift_app/features/widgets/cards/fund_summary_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    TextStyle sectionTitle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      height: 20 / 15,
    );
    final colorScheme = context.colors;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 24,
            children: [
              AppSection(
                child: Column(
                  children: [
                    ///Save
                    FundSummaryCard(),
                  ],
                ),
              ),
              AppSection(
                child: Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: colorScheme.appBorder),
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
              ),
              AppSection(
                sectionTitle: 'Budget Progress',
                trailingText: 'View All',
                trailingType: SectionTrailingType.textButton,
                onTrailingPressed: () {},
                child: BudgetProgressSection(sectionTitle: sectionTitle),
              ),
              MyCashflowSection(),
              AppSection(
                child: Container(
                  padding: EdgeInsets.only(bottom: 12),
                  constraints: BoxConstraints(minHeight: 44),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorScheme.bgLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      //Header
                      Row(
                        children: [
                          SizedBox(width: 12),
                          Text('Accounts Overview', style: sectionTitle),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              Get.find<MainShellController>().changeTab(2);
                              Get.find<FinancialPlannerController>().selectTab(
                                0,
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'View All',
                                  style: TextStyle(color: colorScheme.appInfo),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  PhosphorIconsRegular.caretRight,
                                  size: 16,
                                  color: colorScheme.appInfo,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: 4,
                        children: [
                          // SizedBox(height: 4),
                          Column(
                            spacing: 12,
                            children: [
                              AccountsOverviewTile(
                                accountName: 'Cash & Bank',
                                iconKey: 'wallet',
                                value: 8120,
                                count: 3,
                              ),
                              AccountsOverviewTile(
                                accountName: 'Credit Card',
                                iconKey: 'creditCard',
                                value: 42500,
                                count: 2,
                              ),
                              AccountsOverviewTile(
                                accountName: 'Investments',
                                iconKey: '',
                                value: 42500,
                                count: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountsOverviewTile extends StatelessWidget {
  final String accountName;
  final double value;
  final int count;
  final String iconKey;
  final bool? flowPositive;
  const AccountsOverviewTile({
    super.key,
    required this.accountName,
    required this.value,
    required this.count,
    required this.iconKey,
    this.flowPositive = true,
  });
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    String accountCount;
    if (count == 1) {
      accountCount = '$count account';
    } else {
      accountCount = '$count accounts';
    }

    Color valueColor;
    value >= 0
        ? valueColor = colorScheme.appText
        : valueColor = colorScheme.appOutflow;

    return Container(
      constraints: BoxConstraints(minHeight: 44),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                AppIcons.categories.resolve(iconKey),
                color: colorScheme.appSuccess,
              ),
              Opacity(
                opacity: 0.2,
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: colorScheme.appSuccess,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 8),
          Expanded(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      accountName,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      accountCount,
                      style: TextStyle(color: colorScheme.appTextMuted),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      value.toCompactCurrency(kThreshold: 1000000),
                      style: TextStyle(
                        fontSize: 16,
                        color: valueColor,
                        fontWeight: FontWeight.w500,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(
                      PhosphorIconsRegular.caretRight,
                      size: 16,
                      color: colorScheme.appTextMuted,
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

class BudgetProgressSection extends StatelessWidget {
  const BudgetProgressSection({super.key, required this.sectionTitle});

  final TextStyle sectionTitle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Container(
      // padding: EdgeInsets.all(16),
      constraints: BoxConstraints(minHeight: 44),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.bgLight,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          //Header
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
                child: Row(
                  spacing: 16,
                  children: [
                    BudgetProgressIndicator(
                      progress: 0.42,
                      progressColor: Colors.green,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '42%',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('of budget', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'July Progress',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 24 / 20,
                            ),
                          ),
                          Row(
                            children: [
                              Text(4200.toCompactCurrency(kThreshold: 1000000)),
                              Text(' spent of '),
                              Text(
                                10000.toCompactCurrency(kThreshold: 1000000),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                spacing: 4,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colorScheme.appSuccess,
                                    ),
                                  ),
                                  Text('On Track'),
                                ],
                              ),
                              Spacer(),
                              Text('18 days left'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Divider(
                indent: 16,
                endIndent: 16,
                color: colorScheme.appBorderMuted,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                child: Column(
                  // spacing: 12,
                  children: [
                    BudgetTile(
                      budgetName: 'Groceries',
                      iconKey: 'basket',
                      consumption: 70000,
                      budget: 7500,
                    ),
                    BudgetTile(
                      budgetName: 'Food',
                      iconKey: 'basket',
                      budget: 2000,
                      consumption: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
