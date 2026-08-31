import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TrackAsDebtSection extends GetView<TransactionController> {
  const TrackAsDebtSection({super.key, required this.transactionType});

  final TransactionType transactionType;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Obx(
      () => AnimatedContainer(
        duration: Duration(milliseconds: 180),
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.appInfoSoft,
          borderRadius: BorderRadius.circular(
            controller.isDebt.value == true ? 24 : 12,
          ),
          border: Border.all(color: colorScheme.appInfo),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 4,
                        children: [
                          Icon(
                            PhosphorIconsRegular.coins,
                            color: colorScheme.appInfo,
                          ),
                          Text(
                            'Track as Debt',
                            style: TextStyle(
                              // fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.appInfo,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        'Balance automatically adjust with this person',
                        style: TextStyle(
                          color: colorScheme.appInfo,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                Obx(
                  () => Opacity(
                    opacity: controller.canEnableDebt ? 1 : .4,
                    child: IgnorePointer(
                      ignoring: !controller.canEnableDebt,
                      child: CupertinoSwitch(
                        value: controller.isDebt.value,
                        onChanged: (value) {
                          controller.isDebt.value = value;

                          // if (!value) {
                          //   controller.participants.clear();
                          // }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Obx(() {
              // debugPrint(
              //   'Widget balance: '
              //   '${controller.selectedPersonBalance.value?.netBalance}',
              // );

              if (controller.isDebt.value == true) {
                return Row(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _BalanceSection(
                        controller: controller,
                        label: controller.currentBalanceLabel,
                        sectionTitle: 'Current Balance',
                        amount:
                            (controller
                                .selectedPersonBalance
                                .value
                                ?.netBalance ??
                            0),
                      ),
                    ),
                    // Spacer(),
                    Icon(
                      PhosphorIconsRegular.arrowRight,
                      color: colorScheme.appInfo,
                      size: 24,
                    ),
                    // Spacer(),
                    Expanded(
                      child: _BalanceSection(
                        controller: controller,
                        label: controller.projectedBalanceLabel(
                          transactionType,
                        ),
                        sectionTitle: 'Balance After',
                        amount: controller.projectedBalance(transactionType),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            }),
            // Obx(() {
            //   final person = controller.selectedPerson.value;

            //   if (person == null) {
            //     return const SizedBox.shrink();
            //   }

            //   return Text(
            //     controller.selectedPersonBalance.value?.netBalance
            //             .toCurrency() ??
            //         '',
            //   );
            // }),
          ],
        ),
      ),
    );
  }
}

class _BalanceSection extends StatelessWidget {
  const _BalanceSection({
    required this.controller,
    required this.sectionTitle,
    required this.label,
    this.amount = 0,
  });
  final String sectionTitle;
  final String label;
  final TransactionController controller;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            spacing: 4,
            children: [
              Text(sectionTitle, style: TextStyle(color: colorScheme.appInfo)),

              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  amount.abs().toCurrency(),
                  style: AppTextStyle.amountL.copyWith(
                    color: amount.isNegative
                        ? colorScheme.appOutflow
                        : colorScheme.appInflow,
                  ),
                ),
              ),
              Text(label, style: AppTextStyle.labelXS),
            ],
          ),
        ],
      ),
    );
  }
}
