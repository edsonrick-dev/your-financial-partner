import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/profile/models/ratio_score_band.dart';

RatioScoreBand wealthBuildingBand(double? value) {
  if (value == null) {
    return wealthBuildingNotAssessedBand;
  }

  return wealthBuildingBands.firstWhere(
    (band) => value >= band.threshold,
    orElse: () => wealthBuildingBands.last,
  );
}

const wealthBuildingNotAssessedBand = RatioScoreBand(
  category: 'Not Assessed',
  threshold: 0,
  definition: 'Wealth-building rate cannot currently be calculated.',
  interpretation:
      'A planned income and budget are required to determine how much '
      'of your income is available for wealth building.',
  points: 0,
  color: Color(0xFF9CA3AF),
);

const wealthBuildingBands = [
  RatioScoreBand(
    category: 'Very High Pace',
    threshold: 30,
    definition: 'Wealth is building at a highly accelerated pace.',
    interpretation:
        'This is a large share of your income directed toward wealth '
        'building. This creates strong momentum for asset growth and can '
        'accelerate progress toward major financial goals.',
    points: 20,
    color: Color(0xFF059669),
  ),

  RatioScoreBand(
    category: 'High Pace',
    threshold: 20,
    definition: 'Wealth is building quickly and consistently.',
    interpretation:
        'A significant portion of your income is being directed toward '
        'future growth. This pace creates strong momentum for building '
        'assets and expanding your future financial options.',
    points: 15,
    color: Color(0xFF16A34A),
  ),

  RatioScoreBand(
    category: 'Moderate Pace',
    threshold: 10,
    definition: 'Wealth is building at a healthy, sustainable pace.',
    interpretation:
        'You are consistently directing part of your income toward '
        'wealth building. This provides a solid foundation for steady '
        'long-term financial progress.',
    points: 10,
    color: Color(0xFF16A34A),
  ),

  RatioScoreBand(
    category: 'Low Pace',
    threshold: 5,
    definition: 'Wealth is building slowly with limited momentum.',
    interpretation:
        'You are directing part of your income toward future goals, '
        'but the current pace is modest. Increasing this rate over time '
        'can accelerate your progress toward greater financial capacity.',
    points: 5,
    color: Color(0xFFCA8A04),
  ),

  RatioScoreBand(
    category: 'Very Low Pace',
    threshold: 2,
    definition: 'Wealth building has started, but progress is minimal.',
    interpretation:
        'A small portion of your income is being directed toward future '
        'goals. This creates some progress, but the current pace provides '
        'limited momentum for building financial reserves and investments.',
    points: 2,
    color: Color(0xFFEA580C),
  ),

  RatioScoreBand(
    category: 'Not Building Wealth',
    threshold: 0,
    definition: 'No income is currently being directed toward wealth building.',
    interpretation:
        'Your current income is not contributing to savings or investments. '
        'Without consistent wealth-building contributions, your financial '
        'position is unlikely to improve through accumulation alone.',
    points: 0,
    color: Color(0xFFDC2626),
  ),
];
