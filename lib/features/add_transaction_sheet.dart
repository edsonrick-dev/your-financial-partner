import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/home_initial/widget/transaction_button.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/app/routes/app_sheets/selection_sheets.dart';
import 'package:getx_drift_app/app/routes/app_sheets/transaction_sheets.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class AddTransactionSheet extends StatelessWidget {
  const AddTransactionSheet({
    super.key,
    required this.transaction,
    required this.selection,
  });

  final TransactionSheets transaction;
  final SelectionSheets selection;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final spacing = 12.0;
    final padding = 12.0;
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(color: Colors.transparent),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.only(bottom: 52, right: 16, left: 16),
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              // padding: EdgeInsets.all(24),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.bg,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppToolbar(
                      title: 'Choose Transaction',
                      showLeading: false,
                      showTrailing: false,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 0,
                        left: padding,
                        right: padding,
                        bottom: padding,
                      ),
                      child: Column(
                        children: [
                          Row(
                            spacing: spacing,
                            children: [
                              TransactionButton(
                                padding: 12,
                                label: 'Earn',
                                color: colorScheme.appInflow,
                                icon: Icons.add,
                                onTap: () {
                                  Get.back();
                                  AppSheets.transaction.earn();
                                },
                              ),

                              TransactionButton(
                                color: colorScheme.appOutflow,
                                padding: 12,
                                icon: Icons.remove,
                                label: 'Spend',
                                onTap: () {
                                  Get.back();
                                  AppSheets.transaction.spend();
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: spacing),
                          Row(
                            spacing: spacing,
                            children: [
                              TransactionButton(
                                padding: 12,
                                color: colorScheme.appAccent,
                                icon: Icons.sync_alt_sharp,
                                label: 'Transfer',
                                onTap: () {
                                  Get.back();
                                  AppSheets.transaction.transfer();
                                },
                              ),
                              TransactionButton(
                                padding: 12,
                                color: colorScheme.appNeutral,
                                icon: Icons.more_horiz,
                                label: 'Others',
                                onTap: () {
                                  Get.back();
                                  AppSheets.selection.selectOtherTransaction();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
