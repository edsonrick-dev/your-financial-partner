import 'package:flutter/material.dart';

import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/enum/financial_stability_level.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LearnThumbnail extends StatelessWidget {
  const LearnThumbnail({
    super.key,
    this.status = LearnStatus.available,
    this.type = ContentType.article,
    this.showThumbnail = true,
  });

  final LearnStatus status;
  final ContentType type;
  final bool showThumbnail;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final icon = switch (status) {
      LearnStatus.watched => PhosphorIconsRegular.check,
      LearnStatus.available =>
        type == ContentType.video
            ? PhosphorIconsFill.play
            : PhosphorIconsFill.book,
      LearnStatus.locked => PhosphorIconsRegular.lock,
    };
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.bgLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showThumbnail)
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 108,
                    height: 60,
                    child: Container(color: colorScheme.appText),
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(icon, size: 14, color: colorScheme.appTextMuted),
                    const SizedBox(width: 4),
                    Text(type.label, style: AppTextStyle.labelM),

                    const SizedBox(width: 4),

                    Text('•', style: AppTextStyle.labelM),

                    const SizedBox(width: 4),

                    Text(
                      '5 min. ${type.actionLabel}',
                      style: AppTextStyle.labelM,
                    ),

                    const Spacer(),
                  ],
                ),

                const SizedBox(height: 6),

                SizedBox(
                  height: 44,
                  child: Text(
                    'What is Financial Stability and Why Does It Matter?',
                    style: AppTextStyle.titleM,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum LearnStatus {
  available,
  watched,
  locked;

  IconData get icon {
    return switch (this) {
      LearnStatus.available => PhosphorIconsFill.book,
      LearnStatus.watched => PhosphorIconsRegular.check,
      LearnStatus.locked => PhosphorIconsRegular.lock,
    };
  }
}

enum ContentType {
  article,
  video;

  String get label {
    switch (this) {
      case ContentType.article:
        return 'Article';
      case ContentType.video:
        return 'Video';
    }
  }

  String get actionLabel {
    switch (this) {
      case ContentType.article:
        return 'read';
      case ContentType.video:
        return 'watch';
    }
  }
}

enum LearnContext {
  home,
  netWorth,
  cashFlow,
  debt,
  insurance,
  savingsInvestment,
  dti,
  wbr,
  lcr,
  efr,
  financialStability,
}

class CashflowLearnContent {}

class FinancialState {
  // Foundation
  final int accountCount;
  final bool hasAssets;
  final bool hasLiabilities;

  final bool hasIncomePlan;
  final bool hasBudgetPlan;
  final bool hasDebtPlan;

  final int transactionCount;

  // Cash Flow
  final double plannedIncome;
  final double plannedAllocation;

  final double actualIncome;
  final double actualSpending;

  final double budgetConfidence;

  // Net Worth
  final double totalAssets;
  final double totalLiabilities;
  final double netWorth;

  // Financial Ratios
  final double savingsRate;
  final double emergencyFundRatio;
  final double debtToIncomeRatio;
  final double lifestyleCoverageRatio;

  // Stability
  final FinancialStabilityLevel stabilityLevel;

  const FinancialState({
    required this.accountCount,
    required this.hasAssets,
    required this.hasLiabilities,
    required this.hasIncomePlan,
    required this.hasBudgetPlan,
    required this.hasDebtPlan,
    required this.transactionCount,
    required this.plannedIncome,
    required this.plannedAllocation,
    required this.actualIncome,
    required this.actualSpending,
    required this.budgetConfidence,
    required this.totalAssets,
    required this.totalLiabilities,
    required this.netWorth,
    required this.savingsRate,
    required this.emergencyFundRatio,
    required this.debtToIncomeRatio,
    required this.lifestyleCoverageRatio,
    required this.stabilityLevel,
  });

  bool get hasAssetsOrLiabilities => hasAssets || hasLiabilities;

  bool get hasFinancialFoundation =>
      hasAssetsOrLiabilities && hasIncomePlan && hasBudgetPlan;
}
