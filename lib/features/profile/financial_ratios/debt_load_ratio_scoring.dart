import 'package:flutter/animation.dart';
import 'package:getx_drift_app/features/profile/models/ratio_score_band.dart';

RatioScoreBand debtLoadBand(double? value) {
  if (value == null) {
    return debtLoadNotAssessedBand;
  }

  return debtLoadBands.lastWhere(
    (band) => value >= band.threshold,
    orElse: () => debtLoadBands.first,
  );
}

const debtLoadNotAssessedBand = RatioScoreBand(
  category: 'Not Assessed',
  threshold: 0,
  definition: 'Debt load cannot currently be calculated.',
  interpretation:
      'A planned income is required to determine how much of your income '
      'is committed to debt repayments.',
  points: 0,
  color: Color(0xFF9CA3AF),
);

const debtLoadBands = [
  RatioScoreBand(
    category: 'Debt Free',
    threshold: 0,
    definition: 'Debt places very little weight on your financial growth.',
    interpretation:
        'With no income committed to debt repayments, more of your income remains available for essential expenses, savings, investments, and other financial goals.',
    points: 20,
    color: Color(0xFF22C55E),
  ),
  RatioScoreBand(
    category: 'Very Light',
    threshold: 0.001,
    definition: 'Debt places very little weight on your financial growth.',
    interpretation:
        'Very little of your income is committed to debt repayments, giving you strong capacity for savings, investments, and other financial goals.',
    points: 20,
    color: Color(0xFF22C55E),
  ),

  RatioScoreBand(
    category: 'Light',
    threshold: 10,
    definition: 'Debt places some weight on your financial growth.',
    interpretation:
        'Debt leaves substantial capacity for essential expenses and wealth building.',
    points: 15,
    color: Color(0xFF16A34A),
  ),
  RatioScoreBand(
    category: 'Moderate',
    threshold: 20,
    definition: 'Debt creates manageable income pressure.',
    interpretation: 'Debt repayments consume a noticeable share of income.',
    points: 10,
    color: Color(0xFFD97706),
  ),
  RatioScoreBand(
    category: 'Heavy',
    threshold: 30,
    definition: 'Debt places significant weight on your financial growth.',
    interpretation:
        'A large share of your income is committed to debt repayments, significantly reducing your capacity to save and build wealth.',
    points: 5,
    color: Color(0xFFEA580C),
  ),
  RatioScoreBand(
    category: 'Very Heavy',
    threshold: 50,
    definition: 'Debt places a severe weight on your financial growth.',
    interpretation:
        'At least half of your income is committed to debt repayments, leaving limited capacity for savings, investments, and other financial goals.',
    points: 0,
    color: Color(0xFFDC2626),
  ),
];
