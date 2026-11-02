import 'package:flutter/cupertino.dart';
import 'package:getx_drift_app/features/profile/enum/financial_ratio_type_enum.dart';

class FinancialStabilityDetail {
  final String title;
  final FinancialRatioType? ratioType;
  final Widget page;

  const FinancialStabilityDetail({
    required this.title,
    this.ratioType,
    required this.page,
  });
}
