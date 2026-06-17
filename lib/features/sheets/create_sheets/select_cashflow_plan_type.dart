import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/domain/enums/cashflow_plan_enum.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/widgets/cards/cashflow_plan_type_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SelectCashflowPlanType extends GetView<TransactionController> {
  const SelectCashflowPlanType({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    // final transactionType = TransactionType.transfer;
    // var isBill = true;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(38)),
        color: colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///Header
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(38),
                bottom: Radius.circular(20),
              ),
              // color: colorScheme.primary,
            ),
            child: Column(
              children: [
                ///Grabber
                AppGrabber(),

                ///Toolbar
                AppToolbar(
                  title: 'Select Plan Type',
                  // trailingOnPressed: () {
                  //   controller.saveReceiveMoneyTransaction();
                  // },
                  // leadingOnPressed: () {
                  //   Get.back();
                  // },
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16,
              ),
              child: Column(
                spacing: 12,
                children: [
                  CashflowPlanTypeCard(
                    planType: CashflowPlanType.income,
                    title: 'Income Sources',
                    description:
                        'Plan money you expect to receive regularly or occasionally.',
                    icon: PhosphorIconsRegular.coins,
                    color: colorScheme.appInflow,
                    onTap: () {
                      Get.back(result: CashflowPlanType.income);
                    },
                  ),

                  CashflowPlanTypeCard(
                    planType: CashflowPlanType.expense,
                    title: 'Expenses',
                    description:
                        'Plan money for everyday needs, bills, and lifestyle spending.',
                    icon: PhosphorIconsRegular.shoppingCart,
                    color: colorScheme.appAccent,
                    onTap: () {
                      Get.back(result: CashflowPlanType.expense);
                    },
                  ),

                  CashflowPlanTypeCard(
                    planType: CashflowPlanType.debtRepayment,
                    title: 'Debt Repayment',
                    description:
                        'Plan money for paying off loans and other obligations.',
                    icon: PhosphorIconsRegular.creditCard,
                    color: colorScheme.appOutflow,
                    onTap: () {
                      Get.back(result: CashflowPlanType.debtRepayment);
                    },
                  ),

                  CashflowPlanTypeCard(
                    planType: CashflowPlanType.savingsInvestment,
                    title: 'Savings & Investments',
                    description:
                        'Plan money for emergencies, financial goals, savings, and investments.',
                    icon: PhosphorIconsRegular.piggyBank,
                    color: colorScheme.appInfo,
                    onTap: () {
                      Get.back(result: CashflowPlanType.savingsInvestment);
                    },
                  ),

                  //   ///INCOME SOURCE
                  //   AppFieldContainer(
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         ///ICON
                  //         Stack(
                  //           alignment: Alignment.center,
                  //           children: [
                  //             Opacity(
                  //               opacity: 0.16,
                  //               child: Container(
                  //                 height: 36,
                  //                 width: 36,
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(999),
                  //                   color: colorScheme.success,
                  //                 ),
                  //               ),
                  //             ),
                  //             Icon(
                  //               PhosphorIconsRegular.coins,
                  //               size: 20,
                  //               color: colorScheme.success,
                  //             ),
                  //           ],
                  //         ),
                  //         SizedBox(width: 12),

                  //         Expanded(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: [
                  //               ///TITLE
                  //               Text(
                  //                 'Income Source',
                  //                 style: TextStyle(
                  //                   fontSize: 17,
                  //                   height: 20 / 17,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //               ),
                  //               SizedBox(height: 4),

                  //               ///DESCRIPTION
                  //               Text(
                  //                 'Plan money you expect to receive regularly or occasionally.',
                  //                 style: TextStyle(
                  //                   fontSize: 12,
                  //                   height: 12 / 12,
                  //                   color: colorScheme.text,
                  //                   fontWeight: FontWeight.w300,
                  //                 ),
                  //                 softWrap: true,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     onTap: () {
                  //       // AppSheets.planIncomeSheet();
                  //     },
                  //   ),

                  //   ///EXPENSE
                  //   AppFieldContainer(
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         ///ICON
                  //         Stack(
                  //           alignment: Alignment.center,
                  //           children: [
                  //             Opacity(
                  //               opacity: 0.16,
                  //               child: Container(
                  //                 height: 36,
                  //                 width: 36,
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(999),
                  //                   color: colorScheme.warning,
                  //                 ),
                  //               ),
                  //             ),
                  //             Icon(
                  //               PhosphorIconsRegular.shoppingCart,
                  //               color: colorScheme.warning,
                  //               size: 20,
                  //             ),
                  //           ],
                  //         ),
                  //         SizedBox(width: 12),

                  //         Expanded(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: [
                  //               ///TITLE
                  //               Text(
                  //                 'Expense',
                  //                 style: TextStyle(
                  //                   fontSize: 17,
                  //                   height: 20 / 17,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //               ),
                  //               SizedBox(height: 4),

                  //               ///DESCRIPTION
                  //               Text(
                  //                 'Plan money for everyday needs, bills, and lifestyle spending.',
                  //                 style: TextStyle(
                  //                   fontSize: 12,
                  //                   height: 12 / 12,
                  //                   color: colorScheme.text,
                  //                   fontWeight: FontWeight.w300,
                  //                 ),
                  //                 softWrap: true,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     onTap: () {},
                  //   ),

                  //   ///DEBT REPAYMENT
                  //   AppFieldContainer(
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         ///ICON
                  //         Stack(
                  //           alignment: Alignment.center,
                  //           children: [
                  //             Opacity(
                  //               opacity: 0.16,
                  //               child: Container(
                  //                 height: 36,
                  //                 width: 36,
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(999),
                  //                   color: colorScheme.error,
                  //                 ),
                  //               ),
                  //             ),
                  //             Icon(
                  //               PhosphorIconsRegular.creditCard,
                  //               color: colorScheme.error,
                  //               size: 20,
                  //             ),
                  //           ],
                  //         ),
                  //         SizedBox(width: 12),

                  //         Expanded(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: [
                  //               ///TITLE
                  //               Text(
                  //                 'Debt Repayment',
                  //                 style: TextStyle(
                  //                   fontSize: 17,
                  //                   height: 20 / 17,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //               ),
                  //               SizedBox(height: 4),

                  //               ///DESCRIPTION
                  //               Text(
                  //                 'Plan how much you want to allocate toward paying off debt.',
                  //                 style: TextStyle(
                  //                   fontSize: 12,
                  //                   height: 12 / 12,
                  //                   color: colorScheme.text,
                  //                   fontWeight: FontWeight.w300,
                  //                 ),
                  //                 softWrap: true,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     onTap: () {},
                  //   ),

                  //   ///SAVINGS AND INVESTMENTS
                  //   AppFieldContainer(
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         ///ICON
                  //         Stack(
                  //           alignment: Alignment.center,
                  //           children: [
                  //             Opacity(
                  //               opacity: 0.16,
                  //               child: Container(
                  //                 height: 36,
                  //                 width: 36,
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(999),
                  //                   color: colorScheme.info,
                  //                 ),
                  //               ),
                  //             ),
                  //             Icon(
                  //               PhosphorIconsRegular.piggyBank,
                  //               color: colorScheme.info,
                  //               size: 20,
                  //             ),
                  //           ],
                  //         ),
                  //         SizedBox(width: 12),

                  //         Expanded(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: [
                  //               ///TITLE
                  //               Text(
                  //                 'Savings & Investments',
                  //                 style: TextStyle(
                  //                   fontSize: 17,
                  //                   height: 20 / 17,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //               ),
                  //               SizedBox(height: 4),

                  //               ///DESCRIPTION
                  //               Text(
                  //                 'Plan money for emergencies, financial goals, savings, and investments.',
                  //                 style: TextStyle(
                  //                   fontSize: 12,
                  //                   height: 12 / 12,
                  //                   color: colorScheme.text,
                  //                   fontWeight: FontWeight.w300,
                  //                 ),
                  //                 softWrap: true,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     onTap: () {},
                  //   ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
