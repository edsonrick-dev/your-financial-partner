import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/constants/app_opacity.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_next_occurrence.dart';
import 'package:getx_drift_app/features/transactions/controllers/extensions/dropdown_selectors.dart';

class BillList extends StatelessWidget {
  const BillList({super.key, this.selectedBill});

  final BillWithNextOccurrence? selectedBill;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BillWithNextOccurrence>>(
      stream: database.billsDao.watchBillsWithNextOccurrence(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Unable to load bills.', style: AppTextStyle.bodyM),
          );
        }

        final bills = [...?snapshot.data];

        // ----------------------------------------------------------
        // EDITING AN EXISTING BILL PAYMENT
        // ----------------------------------------------------------

        if (selectedBill != null) {
          final selectedBillId = selectedBill!.bill.id;

          final index = bills.indexWhere(
            (bill) => bill.bill.id == selectedBillId,
          );

          if (index >= 0) {
            // Replace the streamed occurrence with the occurrence
            // belonging to the transaction currently being edited.
            bills[index] = selectedBill!;
          } else {
            // The selected occurrence may be paid, so it won't normally
            // appear in the "next unpaid occurrence" stream.
            bills.insert(0, selectedBill!);
          }
        }

        if (bills.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('No bills available.', style: AppTextStyle.bodyM),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
          itemCount: bills.length,
          separatorBuilder: (_, _) => const SizedBox(height: 4),
          itemBuilder: (context, index) {
            final bill = bills[index];

            return BillListItem(
              bill: bill,
              onTap: () {
                final isSameBill =
                    selectedBill != null &&
                    selectedBill!.bill.id == bill.bill.id;

                final effectiveBill = isSameBill ? selectedBill! : bill;

                Get.back<CategoryOrBillSelection>(
                  result: BillSelection(effectiveBill),
                );
              },
            );
          },
        );
      },
    );
  }
}

class BillListItem extends StatelessWidget {
  const BillListItem({super.key, required this.bill, required this.onTap});

  final BillWithNextOccurrence bill;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final color = colorScheme.appOutflow;
    return AdaptivePressable(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
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
                    bill.isLoanPayment
                        ? AppIcons.categories.resolve(bill.loanAccount!.icon)
                        : AppIcons.categories.resolve(bill.category!.icon),
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
                  Text(bill.bill.name, style: AppTextStyle.titleM),

                  const SizedBox(height: 2),

                  Text(
                    bill.isLoanPayment
                        ? bill.loanAccount!.name
                        : bill.category!.name,
                    style: AppTextStyle.labelS.copyWith(
                      color: colorScheme.appTextMuted,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  bill.occurrence.expectedAmount?.toCurrency() ?? '—',
                  style: AppTextStyle.amountM,
                ),

                const SizedBox(height: 2),

                Text(
                  'Due ${_formatDate(bill.occurrence.dueDate)}',
                  style: AppTextStyle.labelS.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final month = AppMonth.values.firstWhere(
      (month) => month.number == date.month,
    );

    return '${month.shortName} ${date.day}';
  }
}
