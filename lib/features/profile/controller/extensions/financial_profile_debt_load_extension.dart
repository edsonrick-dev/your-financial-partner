import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/enum/finanical_ratio_type_enum.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/debt_load_ratio_scoring.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';

extension FinancialProfileDebtLoadExtension on FinancialProfileController {
  bool get canAssessDebtLoad {
    return hasIncome && annualIncome > 0;
  }

  double? calculateDebtLoadRatio({
    required double annualDebtRepayment,
    required double annualIncome,
  }) {
    if (annualIncome <= 0) return null;

    final ratio = (annualDebtRepayment / annualIncome) * 100;

    return ratio.clamp(0, 100);
  }

  double? get debtLoadRatio => calculateDebtLoadRatio(
    annualDebtRepayment: annualDebtRepayments,
    annualIncome: annualIncome,
  );

  // double calculateDebtLoadRatio({
  //   required double annualDebtRepayment,
  //   required double annualIncome,
  // }) {
  //   if (annualIncome <= 0) return 0;

  //   final ratio = (annualDebtRepayment / annualIncome) * 100;

  //   return ratio.clamp(0, 100);
  // }

  // double get debtLoadRatio => calculateDebtLoadRatio(
  //   annualDebtRepayment: annualDebtRepayments,
  //   annualIncome: annualIncome,
  // );

  FinancialRatio get debtLoad {
    final value = debtLoadRatio;

    return FinancialRatio(
      type: FinancialRatioType.debtLoad,
      value: value,
      scoreBand: debtLoadBand(value),
    );
  }
}
