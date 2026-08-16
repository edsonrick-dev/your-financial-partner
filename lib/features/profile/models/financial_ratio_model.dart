import 'package:getx_drift_app/features/profile/enum/finanical_ratio_type_enum.dart';
import 'package:getx_drift_app/features/profile/models/ratio_score_band.dart';

class FinancialRatio {
  final FinancialRatioType type;
  final double value;
  final RatioScoreBand scoreBand;
  final double? displayValue;

  const FinancialRatio({
    required this.type,
    required this.value,
    required this.scoreBand,
    this.displayValue,
  });

  int get points => scoreBand.points;
  int get normalizedPoints => (points / 20 * 25).round();
}
