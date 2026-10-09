import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_gradient_card.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/protection_continutity_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class LifestyleContinuitySheet extends StatefulWidget {
  const LifestyleContinuitySheet({
    super.key,
    required this.plan,
    required this.continuityShares,
    required this.onSharesChanged,
  });

  final SavedCashflowPlanData plan;
  final Map<ProtectionType, double> continuityShares;
  final ValueChanged<Map<ProtectionType, double>> onSharesChanged;

  @override
  State<LifestyleContinuitySheet> createState() =>
      _LifestyleContinuitySheetState();
}

class _LifestyleContinuitySheetState extends State<LifestyleContinuitySheet> {
  late Map<ProtectionType, double> shares;

  @override
  void initState() {
    super.initState();
    shares = {
      for (final type in ProtectionType.values)
        type: (widget.continuityShares[type] ?? 1.0).clamp(0.0, 1.0),
    };
  }

  void updateShare(ProtectionType type, double value) {
    setState(() {
      shares[type] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final annualAmount = widget.plan.budgetPeriod.toAnnual(widget.plan.amount);

    return AppSheet(
      height: AppSheetHeight.full,
      title: 'Lifestyle Continuity',
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
          child: AppSection(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppGradientCard(
                  child: Row(
                    children: [
                      Icon(
                        AppIcons.categories.resolve(widget.plan.iconKey),
                        color: colorScheme.appInversedtext,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.plan.category,
                          style: AppTextStyle.titleL.copyWith(
                            color: colorScheme.appInversedtext,
                          ),
                        ),
                      ),
                      Text(
                        annualAmount.toCurrency(),
                        style: AppTextStyle.amountL.copyWith(
                          color: colorScheme.appInversedtext,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  'Choose how much of this expense needs to continue '
                  'under each protection scenario.',
                  style: AppTextStyle.bodyM.copyWith(
                    color: colorScheme.appText,
                  ),
                ),

                const SizedBox(height: 24),
                for (final type in ProtectionType.values) ...[
                  _ContinuitySection(
                    type: type,
                    share: shares[type] ?? 1.0,
                    annualAmount: annualAmount,
                    onChanged: (value) => updateShare(type, value),
                  ),
                  if (type != ProtectionType.values.last)
                    const SizedBox(height: 20),
                ],
                const SizedBox(height: 28),

                AppButton(
                  text: 'Done',
                  onTap: () {
                    widget.onSharesChanged(
                      Map<ProtectionType, double>.from(shares),
                    );
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContinuitySection extends StatelessWidget {
  const _ContinuitySection({
    required this.type,
    required this.share,
    required this.annualAmount,
    required this.onChanged,
  });

  final ProtectionType type;
  final double share;
  final double annualAmount;
  final ValueChanged<double> onChanged;

  String get subtitle =>
      type.continuityType == ProtectionContinuityType.dependentExpenses
      ? "Dependents' ongoing expenses"
      : 'Your ongoing lifestyle expenses';

  @override
  Widget build(BuildContext context) {
    final color = type.color;
    final colors = context.colors;
    final percentage = (share * 100).round();
    final continuedAmount = annualAmount * share;

    return AppSectionBody(
      padding: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(type.icon, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(type.label, style: AppTextStyle.titleL),
                        ),
                        Text('$percentage%', style: AppTextStyle.amountL),
                      ],
                    ),

                    Text(
                      subtitle,
                      style: AppTextStyle.bodyM.copyWith(
                        color: colors.appTextMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '${continuedAmount.toCurrency()} / year',
            style: AppTextStyle.bodyM.copyWith(color: colors.appTextMuted),
          ),
          const SizedBox(height: 8),
          Slider(
            padding: EdgeInsets.zero,
            value: share.clamp(0.0, 1.0),
            min: 0,
            max: 1,
            divisions: 20,
            activeColor: color,
            onChanged: onChanged,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0%', style: AppTextStyle.labelM),
              Text('100%', style: AppTextStyle.labelM),
            ],
          ),
        ],
      ),
    );
  }
}
