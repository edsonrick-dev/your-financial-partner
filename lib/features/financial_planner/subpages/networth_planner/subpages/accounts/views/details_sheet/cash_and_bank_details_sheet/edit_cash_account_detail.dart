import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class EditCashAccountDetail extends GetView<AccountController> {
  final AccountsTableData account;

  const EditCashAccountDetail({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      adaptiveHeight: true,
      title: 'Edit ${account.name}',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              label: 'Account Name',
              focusNode: controller.nameFocusNode,
              controller: controller.nameController,
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: controller.actualBalance < 0
                    ? null
                    : () {
                        controller.updateAccountDetails(account);
                      },
                child: Text('Update ${account.name}'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
