import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/bills_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/controller/bill_controller.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BillsPage extends StatelessWidget {
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
              Get.bottomSheet(BillForm(), isScrollControlled: true);
            },
            icon: Icon(PhosphorIconsRegular.plus),
          ),
        ],
      ),
      body: SingleChildScrollView(child: Column(children: [          ],
        )),
    );
  }
}
