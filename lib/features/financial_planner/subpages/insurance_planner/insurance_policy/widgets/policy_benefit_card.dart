import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/app_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_type.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class PolicyBenefitCard extends StatelessWidget {
  const PolicyBenefitCard({
    super.key,
    required this.type,
    required this.amount,
    this.name,
    this.onAmountChanged,
    this.onTap,
    this.isRequired = false,
  });

  final String? name;
  final BenefitType type;
  final double amount;
  final ValueChanged<double>? onAmountChanged;
  final VoidCallback? onTap;
  final bool isRequired;

  Future<void> _openCalculator(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    final calculatorController = Get.find<AppCalculatorController>();
    calculatorController.initialize(amount);

    final result = await Get.bottomSheet<double>(
      AppCalculator(title: name?.isNotEmpty == true ? name! : type.label),
      isScrollControlled: true,
    );

    if (result != null) {
      onAmountChanged?.call(result);
    }
  }

  String get _amountLabel {
    if (amount == 0) return 'Not set';

    return amount.toCompactCurrency(kThreshold: 1000000);
  }

  TextStyle get _amountStyle {
    if (amount == 0) return AppTextStyle.titleL;

    return AppTextStyle.amountL;
  }

  Color _borderColor(BuildContext context) {
    final colorScheme = context.colors;
    if (amount == 0) return colorScheme.appBorder;
    return colorScheme.appText;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppCard(
      borderColor: _borderColor(context),
      onTap: onTap ?? () => _openCalculator(context),
      padding: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isRequired) Text("Required to tanga!"),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  name?.isNotEmpty == true ? name! : type.label,
                  style: AppTextStyle.bodyL,
                ),
              ),
              const SizedBox(width: 16),
              Text(_amountLabel, style: _amountStyle),
            ],
          ),
          if (name?.isNotEmpty == true) ...[
            const SizedBox(height: 4),
            Text(
              type.label,
              style: AppTextStyle.bodyS.copyWith(
                color: colorScheme.appTextMuted,
              ),
            ),
          ],
          const SizedBox(height: 4),
          Text(
            onTap != null
                ? 'Tap card to edit benefit'
                : 'Tap card to edit coverage',
            style: AppTextStyle.bodyS.copyWith(color: colorScheme.appTextMuted),
          ),
        ],
      ),
    );
  }
}
