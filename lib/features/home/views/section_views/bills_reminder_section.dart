import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/constants/app_opacity.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_next_occurrence.dart';
import 'package:getx_drift_app/features/home/controllers/home_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:intl/intl.dart';

class BillsReminderSection extends GetView<CashflowController> {
  const BillsReminderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppSection(
      sectionTitle: 'Bills Reminder',
      child: AppSectionBody(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<List<BillWithNextOccurrence>>(
            stream: database.billsDao.watchCurrentMonthOccurrences(
              month: Get.find<HomeController>().selectedMonth.value,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Text('Unable to load bills.', style: AppTextStyle.bodyM);
              }

              final bills = snapshot.data ?? [];

              final paidBills = bills
                  .where((bill) => bill.occurrence.isPaid)
                  .toList();

              final unpaidBills = bills
                  .where((bill) => !bill.occurrence.isPaid)
                  .toList();

              final totalAmount = bills.fold<double>(
                0,
                (sum, bill) => sum + bill.occurrence.expectedAmount,
              );

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

              final hasBills = bills.isNotEmpty;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$totalBills bills this month',
                    style: AppTextStyle.bodyM.copyWith(
                      color: colorScheme.appTextMuted,
                    ),
                  ),
                  // Text('Recurring Bills', style: AppTextStyle.titleL),
                  // FittedBox(
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         unpaidAmount.toCompactCurrency(kThreshold: 1000000),
                  //         style: AppTextStyle.amountXL,
                  //       ),
                  //       Text(' / ', style: AppTextStyle.displayS),
                  //       Text(
                  //         totalAmount.toCompactCurrency(kThreshold: 1000000),
                  //         style: AppTextStyle.amountXL,
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // const SizedBox(height: 4),
                  // Text(unpaidAmount.toCurrency(), style: AppTextStyle.amountXL),
                  // Text(totalAmount.toCurrency(), style: AppTextStyle.amountXL),
                  const SizedBox(height: 2),

                  _BillSummaryRow(
                    label: 'Remaining',
                    amount: unpaidAmount,
                    count: unpaidBillCount,
                    color: colorScheme.appOutflow,
                  ),
                  _BillSummaryRow(
                    label: 'Paid',
                    amount: paidAmount,
                    count: paidBillCount,
                    color: colorScheme.appSuccess,
                  ),

                  const Divider(),

                  // Text(
                  //   !hasBills
                  //       ? 'No bills this month'
                  //       : unpaidBills.isEmpty
                  //       ? 'All bills paid this month'
                  //       : 'Bills remaining this month',
                  //   style: AppTextStyle.bodyM.copyWith(
                  //     color: colorScheme.appTextMuted,
                  //   ),
                  // ),
                  if (bills.isNotEmpty) ...[
                    const SizedBox(height: 8),

                    ...bills.map(
                      (bill) => _BillReminderItem(
                        bill: bill,
                        onPay: () => controller.makePayment(bill),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BillReminderItem extends StatelessWidget {
  const _BillReminderItem({required this.bill, required this.onPay});

  final BillWithNextOccurrence bill;
  final VoidCallback onPay;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final color = colorScheme.appOutflow;
    final occurrence = bill.occurrence;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 36,
            height: 36,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: AppOpacity.transactionIcon,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: color,
                    ),
                  ),
                ),
                Icon(
                  AppIcons.categories.resolve(bill.category.icon),
                  size: 20,
                  color: color,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
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
                        style: AppTextStyle.labelS.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),
                    ),
                    if (occurrence.isPaid)
                      Text(
                        'Paid',
                        style: AppTextStyle.labelS.copyWith(
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
                            style: AppTextStyle.labelS.copyWith(
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
    );
  }
}

class _BillSummaryRow extends StatelessWidget {
  const _BillSummaryRow({
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
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppTextStyle.bodyM)),
          Text(
            '$count $billText',
            style: AppTextStyle.labelS.copyWith(
              color: context.colors.appTextMuted,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            amount.toCurrency(),
            style: AppTextStyle.amountM.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
