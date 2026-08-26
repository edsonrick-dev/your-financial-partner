import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/app_scale.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/home/controllers/home_controller.dart';
import 'package:getx_drift_app/features/home/views/section_views/budget_progress_section.dart';
import 'package:getx_drift_app/features/home/views/section_views/quick_actions_section.dart';
import 'package:getx_drift_app/features/widgets/cards/bills_card.dart';
import 'package:getx_drift_app/features/widgets/cards/fund_summary_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final spacingM = AppScale.x5;
    final spacingL = AppScale.x6;
    final colorScheme = context.colors;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  AppBar(
                    centerTitle: false,
                    title: Text(
                      'Good morning, Edson Rick!',
                      style: AppTextStyle.headlineL,
                    ),
                    surfaceTintColor: Colors.transparent,
                  ),
                  SizedBox(height: spacingM),
                  AppSection(
                    child: Column(
                      spacing: spacingM,
                      children: [FundSummaryCard(), QuickActionSection()],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacingL),
              BudgetProgressSection(),
              SizedBox(height: spacingM),
              AppSection(
                sectionTitle: 'Payment Reminders',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    constraints: BoxConstraints(minHeight: 44),
                    width: double.infinity,
                    decoration: BoxDecoration(color: colorScheme.bgLight),
                    child: Column(
                      spacing: 8,
                      children: [
                        BillsCard(
                          billName: 'Internet Bill',
                          billType: 'Internet',
                          dueDate: DateTime(2026, 8, 3),
                          amountDue: 1499,
                          iconKey: 'wifi',
                        ),
                        BillsCard(
                          billName: 'Electric Bill',
                          billType: 'Electricity',
                          dueDate: DateTime(2026, 8, 14),
                          amountDue: 1499,
                          iconKey: 'lightning',
                        ),
                        BillsCard(
                          billName: 'Credit Card Bill',
                          billType: 'Credit Card',
                          dueDate: DateTime(2026, 8, 28),
                          amountDue: 24000,
                          iconKey: 'creditCard',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: spacingL),
              // AppSection(
              //   child: Container(
              //     padding: EdgeInsets.only(bottom: 12),
              //     constraints: BoxConstraints(minHeight: 44),
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       color: colorScheme.bgLight,
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: Column(
              //       children: [
              //         //Header
              //         Row(
              //           children: [
              //             SizedBox(width: 12),
              //             Text('Accounts Overview'),
              //             Spacer(),
              //             TextButton(
              //               onPressed: () {
              //                 Get.find<MainShellController>().changeTab(2);
              //                 Get.find<FinancialPlannerController>().selectTab(
              //                   0,
              //                 );
              //               },
              //               child: Row(
              //                 children: [
              //                   Text(
              //                     'View All',
              //                     style: TextStyle(color: colorScheme.appInfo),
              //                   ),
              //                   SizedBox(width: 4),
              //                   Icon(
              //                     PhosphorIconsRegular.caretRight,
              //                     size: 16,
              //                     color: colorScheme.appInfo,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //         Column(
              //           spacing: 4,
              //           children: [
              //             // SizedBox(height: 4),
              //             Column(
              //               spacing: 12,
              //               children: [
              //                 AccountsOverviewTile(
              //                   accountName: 'Cash & Bank',
              //                   iconKey: 'wallet',
              //                   value: 8120,
              //                   count: 3,
              //                 ),
              //                 AccountsOverviewTile(
              //                   accountName: 'Credit Card',
              //                   iconKey: 'creditCard',
              //                   value: 42500,
              //                   count: 2,
              //                 ),
              //                 AccountsOverviewTile(
              //                   accountName: 'Investments',
              //                   iconKey: '',
              //                   value: 42500,
              //                   count: 2,
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
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
