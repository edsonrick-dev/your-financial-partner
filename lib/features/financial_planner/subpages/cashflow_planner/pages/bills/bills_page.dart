import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/bill_details_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/bills_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/controller/bill_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_category.dart';
import 'package:getx_drift_app/features/widgets/cards/bills_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BillsPage extends GetView<BillController> {
  const BillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BillController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bills', style: AppTextStyle.headlineL),
        actions: [
          IconButton(
            onPressed: () {
              // controller.resetForm();
              Get.bottomSheet(
                BillForm(),
                isScrollControlled: true,
              ).whenComplete(controller.resetForm);
            },
            icon: Icon(PhosphorIconsRegular.plus),
          ),
        ],
      ),

      body: StreamBuilder<List<BillWithCategory>>(
        stream: database.billsDao.watchAllActiveBills(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong: ${snapshot.error}'),
            );
          }

          final bills = snapshot.data ?? [];

          if (bills.isEmpty) {
            return const Center(child: Text('No bills yet.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: bills.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = bills[index];

              return BillsCard(
                onLongPress: () {
                  controller.deleteBill(item);
                },
                onTap: () {
                  Get.bottomSheet(
                    BillDetailsSheet(item: item),
                    isScrollControlled: true,
                  );
                },
                bill: item,
                // billName: item.bill.name,
                // billType: item.bill.frequency.capitalize!,
                // dueDate: item.occurrence.dueDate,
                // amountDue: item.occurrence.expectedAmount,
                // iconKey: item.category.icon,
              );
            },
          );
        },
      ),
    );
  }
}
