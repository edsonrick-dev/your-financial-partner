import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/domain/app_calculator.dart';
import 'package:getx_drift_app/features/widgets/fields/shared/field_container.dart';
import 'package:getx_drift_app/data/enums/field_states.dart';

class AppAmountField extends StatelessWidget {
  final String label;
  final double amount;
  final String hintText;
  final bool optional;
  final String prefixText;
  final ValueChanged<double>? onChanged;

  const AppAmountField({
    super.key,
    required this.label,
    required this.amount,
    this.hintText = '0.00',
    this.optional = false,
    this.prefixText = '₱',
    this.onChanged,
  });

  Future<void> _openCalculator(BuildContext context) async {
    final calculatorController = Get.find<AppCalculatorController>();
    calculatorController.initialize(amount);

    final result = await Get.bottomSheet<double>(
      const AppCalculator(),
      isScrollControlled: true,
    );

    if (result == null) return;

    onChanged?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    return AppFieldContainer(
      state: amount > 0 ? FieldState.filled : FieldState.empty,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        _openCalculator(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ${optional ? '(Optional)' : ''}',
            style: AppTextStyle.titleM,
          ),
          Row(
            children: [
              Text(prefixText, style: AppTextStyle.amountM),
              const SizedBox(width: 4),
              Text(
                amount == 0 ? hintText : amount.toStringAsFixed(2),
                style: AppTextStyle.amountM,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
