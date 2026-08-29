import 'package:flutter/material.dart';

import 'package:getx_drift_app/features/profile/models/ratio_score_band.dart';

RatioScoreBand lifestyleCoverageBand(double? value) {
  if (value == null) {
    return lifestyleCoverageNotAssessedBand;
  }

  return lifestyleCoverageBands.lastWhere(
    (band) => value >= band.threshold,
    orElse: () => lifestyleCoverageBands.first,
  );
}

const lifestyleCoverageNotAssessedBand = RatioScoreBand(
  category: 'Not Assessed',
  threshold: 0,
  definition: 'Lifestyle coverage cannot currently be calculated.',
  interpretation:
      'A planned annual lifestyle budget is required to determine '
      'how much of your lifestyle your net worth can support.',
  points: 0,
  color: Color(0xFF9CA3AF),
);

const lifestyleCoverageBands = [
  RatioScoreBand(
    category: 'Uncovered',
    threshold: -1,
    definition: 'Net worth is negative.',
    interpretation:
        'Your liabilities exceed your assets, resulting in a negative net '
        'worth. Your accumulated wealth currently provides no financial '
        'coverage for your planned lifestyle allocation.',
    points: 0,
    color: Color(0xFFDC2626),
  ),
  RatioScoreBand(
    category: 'Barely Covered',
    threshold: 0,
    definition: 'Net worth provides minimal lifestyle coverage.',
    interpretation:
        'Your net worth covers less than one year of your planned lifestyle '
        'allocation. While day-to-day needs may be supported by income, '
        'long-term financial resilience remains limited.',
    points: 4,
    color: Color(0xFFEA580C),
  ),

  RatioScoreBand(
    category: 'Partially Covered',
    threshold: 1,
    definition: 'Net worth offers limited lifestyle support.',
    interpretation:
        'Your accumulated wealth can support roughly one year of your '
        'planned lifestyle allocation. This reflects early progress, but '
        'financial security still relies heavily on continued income.',
    points: 8,
    color: Color(0xFFCA8A04),
  ),

  RatioScoreBand(
    category: 'Moderately Covered',
    threshold: 2.5,
    definition: 'Net worth supports multiple years of lifestyle needs.',
    interpretation:
        'Your net worth can support several years of your planned lifestyle '
        'allocation. This reduces reliance on income and provides greater '
        'financial flexibility over the medium term.',
    points: 12,
    color: Color(0xFF16A34A),
  ),

  RatioScoreBand(
    category: 'Well Covered',
    threshold: 5,
    definition: 'Net worth provides strong lifestyle coverage.',
    interpretation:
        'Your accumulated wealth significantly outweighs your planned '
        'lifestyle allocation. At this level, you are well positioned to '
        'absorb long-term financial pressure and plan with confidence.',
    points: 16,
    color: Color(0xFF16A34A),
  ),

  RatioScoreBand(
    category: 'Highly Covered',
    threshold: 10,
    definition: 'Net worth supports long-term lifestyle needs.',
    interpretation:
        'Your net worth is sufficient to support a decade or more of '
        'your planned lifestyle allocation. This reflects substantial '
        'long-term financial strength and a high degree of flexibility, '
        'even without immediate income.',
    points: 20,
    color: Color(0xFF059669),
  ),
];
