import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/loan_detail_sheet/loan_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class EditLoanDetails extends GetView<LoanController> {
  final AccountsTableData account;

  const EditLoanDetails({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      title: 'Edit Loan',
      child: Column(
        children: [
          // We'll put the loan editing form here.
        ],
      ),
    );
  }
}
