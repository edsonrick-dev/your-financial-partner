import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_group/account_group_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_group/account_group_summary.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LiabilitiesList extends GetView<NetWorthController> {
  const LiabilitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Obx(() {
      final groups = controller.groupedLiabilityItems;

      if (groups.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  PhosphorIconsRegular.creditCard,
                  size: 48,
                  color: colorScheme.appOutflow,
                ),
                SizedBox(height: 16),
                Text(
                  'No liabilities yet',
                  style: AppTextStyle.headlineM,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "Tap + to add your first liability account.",
                  style: AppTextStyle.bodyM.copyWith(
                    color: colorScheme.appText,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  "Keep track of what you owe—credit cards, installment plans, and loans.",
                  style: AppTextStyle.bodyM.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                  textAlign: TextAlign.center,
                ),

                // AppButton(
                //   text: 'Record your first liabilities',
                //   onTap: () async {
                //     final isAsset =
                //         controller.seletectedDetailsTabIndex.value == 0;

                //     final availableTypes = AccountType.values
                //         .where(
                //           (type) => isAsset ? type.isAsset : type.isLiability,
                //         )
                //         .toList();

                //     final selectedType = await AppSheets.selection
                //         .selectPaymentAccountType(accountTypes: availableTypes);
                //     if (selectedType == null) return;

                //     final accountController = Get.find<AccountController>();
                //     accountController.selectAccountType(selectedType);

                //     Get.bottomSheet(
                //       AddAccountSheet(accountType: selectedType),
                //       isScrollControlled: true,
                //       backgroundColor: Colors.transparent,
                //     ).whenComplete(() {
                //       accountController.resetForm();
                //     });
                //   },
                // ),
                // SizedBox(height: 8),
                // AppButton(
                //   type: ButtonType.outline,
                //   text: 'Watch how to set up a liability',
                //   onTap: () {
                //     Get.bottomSheet(LoanForm(), isScrollControlled: true);
                //   },
                // ),
              ],
            ),
          ),
        );
      }

      return SingleChildScrollView(
        child: Column(
          children: [
            for (final entry in groups.entries)
              AccountGroupSection(
                summary: AccountGroupSummary(
                  group: entry.key,
                  items: entry.value,
                ),
              ),
          ],
        ),
      );
    });
  }
}

class LoanForm extends StatelessWidget {
  const LoanForm({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      height: AppSheetHeight.full,
      title: 'New Loan',
      child: Column(),
    );
  }
}
