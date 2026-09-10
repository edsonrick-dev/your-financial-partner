import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/app/routes/app_sheets/selection_sheets.dart';
import 'package:getx_drift_app/app/routes/app_sheets/transaction_sheets.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
    final padding = 12.0;
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(color: Colors.transparent),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(bottom: 52, right: 16, left: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 0,
                      left: padding,
                      // right: padding,
                      bottom: padding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: 12,
                      children: [
                        NewTransactionButton(
                          color: colorScheme.appInflow,
                          icon: Icons.add,
                          label: 'Earn Money',
                          onTap: () {
                            Get.back();
                            AppSheets.transaction.earn();
                          },
                        ),
                        NewTransactionButton(
                          color: colorScheme.appOutflow,
                          icon: Icons.remove,
                          label: 'Spend Money',
                          onTap: () {
                            Get.back();
                            AppSheets.transaction.spend();
                          },
                        ),
                        NewTransactionButton(
                          color: colorScheme.appAccent,
                          icon: Icons.sync_alt_sharp,
                          label: 'Transfer Money',
                          onTap: () {
                            Get.back();
                            AppSheets.transaction.transfer();
                          },
                        ),
                        NewTransactionButton(
                          color: colorScheme.appInflow,
                          icon: PhosphorIconsRegular.handCoins,
                          label: 'Receive Money',
                          onTap: () {
                            Get.back();
                            AppSheets.transaction.receiveMoney();
                          },
                        ),
                        NewTransactionButton(
                          color: colorScheme.appOutflow,
                          icon: PhosphorIconsRegular.handDeposit,
                          label: 'Give Money',
                          onTap: () {
                            Get.back();
                            AppSheets.transaction.giveMoney();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NewTransactionButton extends StatelessWidget {
  const NewTransactionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AdaptivePressable(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.transactionButtonBorder),
              color: colorScheme.bg,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(label, style: AppTextStyle.titleM),
          ),
          SizedBox(width: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: 1,
                child: Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                ),
              ),
              Icon(icon, color: colorScheme.bgLight),
            ],
          ),
        ],
      ),
    );
  }
}
