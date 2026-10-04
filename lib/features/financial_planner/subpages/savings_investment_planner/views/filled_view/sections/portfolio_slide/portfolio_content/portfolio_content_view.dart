import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/asset_class/asset_class_enum.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class PortfolioContentView extends StatelessWidget {
  const PortfolioContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentValue = 395708.0;
    final investedAmount = 200000.0;

    final gainLoss = currentValue - investedAmount;

    final gainLossRate = investedAmount == 0 ? 0.0 : gainLoss / investedAmount;
    final gainLossSymbol = gainLoss >= 0 ? '+' : '';
    final colorScheme = context.colors;
    return Column(
      spacing: 12,
      children: [
        AppSection(
          child: AppSectionBody(
            padding: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Portfolio Summary', style: AppTextStyle.titleL),
                // SizedBox(height: 16),
                Text(currentValue.toCurrency(), style: AppTextStyle.amountXL),
                Row(
                  spacing: 8,
                  children: [
                    Text(gainLoss.toCurrency(), style: AppTextStyle.amountL),
                    Text(
                      '$gainLossSymbol${(gainLossRate * 100).toStringAsFixed(1)}% return',
                      style: AppTextStyle.labelM.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                  ],
                ),

                Container(decoration: BoxDecoration(), child: Column()),
              ],
            ),
          ),
        ),

        AppSection(
          sectionTitle: 'Financial Instruments',
          child: Column(
            spacing: 12,
            children: [
              PortfolioAssetCard(
                asset: AssetClass.cash,
                targetInvestment: 18000,
                thisYearsInvestment: 8000,
                currentValue: 120000,
              ),
              PortfolioAssetCard(
                asset: AssetClass.localBonds,
                targetInvestment: 18000,
                thisYearsInvestment: 8000,
                currentValue: 120000,
              ),
              PortfolioAssetCard(
                asset: AssetClass.localEquities,
                targetInvestment: 18000,
                thisYearsInvestment: 8000,
                currentValue: 120000,
              ),
              PortfolioAssetCard(
                asset: AssetClass.globalBonds,
                targetInvestment: 54000,
                thisYearsInvestment: 20000,
                currentValue: 48000,
              ),
              PortfolioAssetCard(
                asset: AssetClass.globalEquities,
                targetInvestment: 54000,
                thisYearsInvestment: 20000,
                currentValue: 48000,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PortfolioAssetCard extends StatelessWidget {
  const PortfolioAssetCard({
    super.key,
    required this.asset,
    this.currentValue = 0,
    this.targetInvestment = 0,
    this.thisYearsInvestment = 0,
  });

  final AssetClass asset;
  final double currentValue;
  final double thisYearsInvestment;
  final double targetInvestment;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final remainingAmount = (targetInvestment - thisYearsInvestment).clamp(
      0.0,
      double.infinity,
    );

    final completionRate = targetInvestment > 0
        ? thisYearsInvestment / targetInvestment
        : 0.0;
    return AppCard(
      padding: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(asset.icon()),
              SizedBox(width: 8),
              Expanded(child: Text(asset.label, style: AppTextStyle.titleM)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Total Amount',
                    style: AppTextStyle.labelXS.copyWith(
                      color: colorScheme.appTextMuted,
                    ),
                  ),
                  Text(currentValue.toCurrency(), style: AppTextStyle.amountM),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),

          LinearProgressIndicator(
            value: completionRate,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
            backgroundColor: colorScheme.appText.withAlpha(40),
            // valueColor: AlwaysStoppedAnimation(statusColor),
          ),

          SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Invested so far",
                      style: AppTextStyle.labelXS.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                    Text(
                      thisYearsInvestment.toCurrency(),
                      style: AppTextStyle.amountM,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Target invested",
                      style: AppTextStyle.labelXS.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                    Text(
                      targetInvestment.toCurrency(),
                      style: AppTextStyle.amountM,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Remaining",
                      style: AppTextStyle.bodyS.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        remainingAmount.toCurrency(),
                        style: AppTextStyle.amountM,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
