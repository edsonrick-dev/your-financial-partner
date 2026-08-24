import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/app_calculator.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';

class TransactionAmountHolder extends GetView<TransactionController> {
  const TransactionAmountHolder({super.key});

  Future<void> _openCalculator(BuildContext context) async {
    final calculatorController = Get.find<AppCalculatorController>();

    calculatorController.initialize(controller.amount.value);

    final amount = await Get.bottomSheet<double>(
      const AppCalculator(),
      isScrollControlled: true,
    );

    if (amount == null) return;

    controller.amount.value = amount;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      onTap: () => _openCalculator(context),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 6,
            bottom: 24,
          ),
          child: Column(
            children: [
              Text(
                'Amount',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 15,
                  height: 20 / 15,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 4),

              Obx(
                () => Text(
                  controller.amount.value.toStringAsFixed(2),
                  style: AppTextStyle.amountXL.copyWith(
                    color: colorScheme.textInversed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
