import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';

import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_next_occurrence.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BillsReminderSection extends GetView<CashflowController> {
  const BillsReminderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    // final billController = Get.find<BillController>();

    return AppSectionBody(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<bool>(
          stream: database.billsDao.watchHasBills(),
          builder: (context, hasBillsSnapshot) {
            if (hasBillsSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final hasBills = hasBillsSnapshot.data ?? false;

            return Obx(() {
              final selectedMonth = controller.selectedMonth.value;

              return StreamBuilder<List<BillWithNextOccurrence>>(
                stream: database.billsDao.watchCurrentMonthOccurrences(
                  month: selectedMonth,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text(
                      'Unable to load bills.',
                      style: AppTextStyle.bodyM,
                    );
                  }

                  final bills = snapshot.data ?? [];

                  final billText = bills.length == 1 ? 'bill' : 'bills';

                  final paidBills = bills
                      .where((bill) => bill.occurrence.isPaid)
                      .toList();

                  final unpaidBills = bills
                      .where((bill) => !bill.occurrence.isPaid)
                      .toList();

                  final paidAmount = paidBills.fold<double>(
                    0,
                    (sum, bill) => sum + bill.occurrence.expectedAmount,
                  );

                  final unpaidAmount = unpaidBills.fold<double>(
                    0,
                    (sum, bill) => sum + bill.occurrence.expectedAmount,
                  );
                  final totalBills = bills.length;
                  final paidBillCount = paidBills.length;
                  final unpaidBillCount = unpaidBills.length;
                  final String title;

                  if (!hasBills) {
                    title = 'You have no bills yet';
                  } else if (bills.isEmpty) {
                    title = 'No bills this month';
                  } else {
                    title = '$totalBills $billText this month';
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (hasBills) ...[
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                textAlign: hasBills
                                    ? TextAlign.start
                                    : TextAlign.center,
                                title,
                                style: AppTextStyle.titleM.copyWith(
                                  // color: colorScheme.appTextMuted,
                                ),
                              ),
                            ),
                            if (bills.isNotEmpty)
                              RichText(
                                text: TextSpan(
                                  style: AppTextStyle.labelM.copyWith(
                                    color: colorScheme.appText,
                                  ),
                                  children: [
                                    if (paidBillCount < totalBills) ...[
                                      TextSpan(text: paidBillCount.toString()),
                                      const TextSpan(text: '/'),
                                      TextSpan(text: totalBills.toString()),
                                      const TextSpan(text: ' bills paid'),
                                    ],
                                    if (paidBillCount == totalBills)
                                      const TextSpan(text: 'All bills paid'),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        Row(
                          spacing: 16,
                          children: [
                            Expanded(
                              child: _BillSummaryColumn(
                                label: 'Remaining',
                                amount: unpaidAmount,
                                count: unpaidBillCount,
                                color: colorScheme.appOutflow,
                              ),
                            ),
                            // SizedBox(width: 16),
                            // const Divider(),
                            Container(
                              height: 32,

                              width: 1,
                              decoration: BoxDecoration(
                                color: colorScheme.appBorder,
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                            Expanded(
                              child: _BillSummaryColumn(
                                label: 'Paid',
                                amount: paidAmount,
                                count: paidBillCount,
                                color: colorScheme.appSuccess,
                              ),
                            ),
                          ],
                        ),
                        if (bills.isNotEmpty) ...[
                          Divider(color: colorScheme.appBorder),
                          const SizedBox(height: 8),

                          ...bills.map(
                            (bill) => _BillReminderItem(
                              onTap: () {},
                              bill: bill,
                              onPay: () => controller.makeBillPayment(bill),
                            ),
                          ),
                        ],
                      ],
                      if (!hasBills)
                        Column(
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              size: 60,
                              color: colorScheme.appAccent,
                            ),
                            SizedBox(height: 8),
                            Text(title, style: AppTextStyle.headlineM),
                            Text(
                              "Add your bills to spending categories",
                              style: AppTextStyle.headlineS,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Keep your bills organized by category—like Meralco or Manila Water under Utilities.",
                              style: AppTextStyle.bodyM.copyWith(
                                color: colorScheme.appTextMuted,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12),
                            AppButton(
                              type: ButtonType.outline,
                              trailingIcon: PhosphorIconsRegular.arrowRight,
                              text: 'Add bills in cashflow planner',
                              onTap: () {
                                Get.toNamed(Routes.BILLS);
                                // Get.bottomSheet(
                                //   BillForm(),
                                //   isScrollControlled: true,
                                // ).whenComplete(billController.resetForm);
                              },
                            ),
                          ],
                        ),

                      const SizedBox(height: 2),
                    ],
                  );
                },
              );
            });
          },
        ),
      ),
    );
  }
}

class _BillReminderItem extends StatelessWidget {
  const _BillReminderItem({
    required this.bill,
    required this.onPay,
    this.onTap,
  });

  final BillWithNextOccurrence bill;
  final VoidCallback onPay;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    // final color = colorScheme.appOutflow;
    final occurrence = bill.occurrence;

    return AdaptivePressable(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            // SizedBox(
            //   width: 36,
            //   height: 36,
            //   child: Stack(
            //     alignment: Alignment.center,
            //     children: [
            //       Opacity(
            //         opacity: AppOpacity.transactionIcon,
            //         child: Container(
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(999),
            //             color: color,
            //           ),
            //         ),
            //       ),
            //       Icon(
            //         bill.isLoanPayment
            //             ? AppIcons.categories.resolve(bill.loanAccount!.icon)
            //             : AppIcons.categories.resolve(bill.category!.icon),
            //         size: 20,
            //         color: color,
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        AppIcons.categories.resolve(
                          bill.isLoanPayment
                              ? bill.loanAccount!.icon
                              : bill.category!.icon,
                        ),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(bill.bill.name, style: AppTextStyle.titleL),
                      ),
                      Text(
                        occurrence.expectedAmount.toCurrency(),
                        style: AppTextStyle.amountM,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Due ${DateFormat('MMM d').format(occurrence.dueDate)}',
                          style: AppTextStyle.labelM.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),
                      ),
                      if (occurrence.isPaid)
                        Text(
                          'Paid',
                          style: AppTextStyle.labelM.copyWith(
                            color: colorScheme.appSuccess,
                          ),
                        )
                      else
                        AdaptivePressable(
                          onTap: onPay,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.appOutflow,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              'Pay',
                              style: AppTextStyle.labelM.copyWith(
                                color: colorScheme.appInversedtext,
                              ),
                            ),
                          ),
                        ),
                    ],
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

class _BillSummaryColumn extends StatelessWidget {
  const _BillSummaryColumn({
    required this.label,
    required this.amount,
    required this.count,
    required this.color,
  });

  final String label;
  final double amount;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final billText = count == 1 ? 'bill' : 'bills';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(label, style: AppTextStyle.labelM)),
              Text(
                '$count $billText',
                style: AppTextStyle.labelS.copyWith(
                  color: context.colors.appTextMuted,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),
          Text(
            amount.toCurrency(),
            style: AppTextStyle.amountL.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
