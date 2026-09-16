import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_state.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_status.dart';
import 'package:getx_drift_app/features/financial_insights/financial_profile_cashflow_controller_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_debt_load_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_emergency_fund_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_lifestyle_coverage_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_wealth_building_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/enum/financial_stability_level.dart';

class FinancialState {
  // Cash Flow

  final CashflowState cashflow;

  // Foundation

  // final int accountCount;
  final bool hasAssets;
  final bool hasLiabilities;
  // final int transactionCount;

  // Net Worth

  final double totalAssets;
  final double totalLiabilities;
  final double netWorth;

  // Financial Ratios

  final double? debtLoadRatio;
  final double? wealthBuildingRatio;
  final double? emergencyFundRatio;
  final double? lifestyleCoverageRatio;

  // Stability

  final int financialScore;
  final FinancialStabilityLevel stabilityLevel;

  const FinancialState({
    required this.cashflow,

    // required this.accountCount,
    required this.hasAssets,
    required this.hasLiabilities,

    // required this.transactionCount,
    required this.totalAssets,
    required this.totalLiabilities,
    required this.netWorth,

    required this.debtLoadRatio,
    required this.wealthBuildingRatio,
    required this.emergencyFundRatio,
    required this.lifestyleCoverageRatio,

    required this.financialScore,
    required this.stabilityLevel,
  });

  bool get hasAssetsOrLiabilities => hasAssets || hasLiabilities;

  bool get hasFinancialFoundation =>
      hasAssetsOrLiabilities && cashflow.status == CashflowStatus.complete;
}

extension FinancialProfileStateExtension on FinancialProfileController {
  FinancialState get financialState {
    return FinancialState(
      cashflow: cashflowState,

      // accountCount: ...,
      hasAssets: hasAssets,
      hasLiabilities: hasLiabilities,

      // transactionCount: ...,
      totalAssets: assets,
      totalLiabilities: liabilities,
      netWorth: netWorth,

      debtLoadRatio: debtLoadRatio,
      wealthBuildingRatio: wealthBuildingRatio,
      emergencyFundRatio: emergencyFundRatio,
      lifestyleCoverageRatio: lifestyleCoverageRatio,

      financialScore: financialScore,
      stabilityLevel: stability.level,
    );
  }
}
