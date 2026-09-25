import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/bill_details_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_category.dart';
import 'package:getx_drift_app/features/widgets/cards/bills_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class BillsByCategoryView extends StatelessWidget {
  const BillsByCategoryView({super.key, required this.plan});

  final SavedCashflowPlanData plan;

  @override
  Widget build(BuildContext context) {
    final categoryId = plan.categoryId;
    final colorScheme = context.colors;

    return StreamBuilder<List<BillWithCategory>>(
      stream: database.billsDao.watchAllActiveBills(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong: ${snapshot.error}'));
        }

        final bills = (snapshot.data ?? [])
            .where((bill) => bill.bill.categoryId == categoryId)
            .toList();

        if (bills.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.receipt_long_outlined, size: 48),
                const SizedBox(height: 16),
                Text(
                  'No bills for this category yet',
                  style: AppTextStyle.headlineM,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Keep your bills organized for this category.',
                  style: AppTextStyle.bodyM.copyWith(
                    // color: colorScheme.appTextMuted,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap + to add a ${plan.category} bill.',
                  style: AppTextStyle.bodyM.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.only(top: 12, bottom: 24),
          children: [
            AppSection(
              // sectionTitle: 'Bills',
              child: Column(
                spacing: 12,
                children: bills.map((bill) {
                  return BillsCard(
                    bill: bill,
                    onTap: () {
                      Get.bottomSheet(
                        BillDetailsSheet(item: bill),
                        isScrollControlled: true,
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
