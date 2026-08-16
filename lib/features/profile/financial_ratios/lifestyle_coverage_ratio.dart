import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/profile/models/ratio_score_band.dart';

RatioScoreBand lifestyleCoverageBand(double value) {
  if (value >= 10) {
    return const RatioScoreBand(
      category: 'Highly Covered',
      threshold: 10,
      definition: 'Net worth supports long-term lifestyle needs.',
      interpretation:
          'Your net worth is sufficient to support a decade or more of '
          'living expenses and required debt repayments. This reflects '
          'substantial long-term financial strength and a high degree of '
          'flexibility, even without immediate income.',
      points: 20,
      color: Color(0xFF059669),
    );
  }

  if (value >= 5) {
    return const RatioScoreBand(
      category: 'Well Covered',
      threshold: 5,
      definition: 'Net worth provides strong lifestyle coverage.',
      interpretation:
          'Your accumulated wealth significantly outweighs your lifestyle '
          'allocation. At this level you are well positioned to absorb '
          'long-term financial pressure and plan with confidence.',
      points: 16,
      color: Color(0xFF16A34A),
    );
  }

  if (value >= 2.5) {
    return const RatioScoreBand(
      category: 'Moderately Covered',
      threshold: 2.5,
      definition: 'Net worth supports multiple years of lifestyle needs.',
      interpretation:
          'Your net worth can sustain several years of expenses and debt '
          'repayments. This reduces reliance on income and provides greater '
          'financial flexibility over the medium term.',
      points: 12,
      color: Color(0xFF16A34A),
    );
  }

  if (value >= 1) {
    return const RatioScoreBand(
      category: 'Partially Covered',
      threshold: 1,
      definition: 'Net worth offers limited lifestyle support.',
      interpretation:
          'Your accumulated assets can support roughly one year of lifestyle '
          'allocation. This reflects early progress, but financial security '
          'still relies heavily on continued income.',
      points: 8,
      color: Color(0xFFCA8A04),
    );
  }

  if (value >= 0) {
    return const RatioScoreBand(
      category: 'Barely Covered',
      threshold: 0,
      definition: 'Net worth provides minimal lifestyle coverage.',
      interpretation:
          'Your net worth covers less than one year of combined living '
          'expenses and debt repayments. While day-to-day needs may be '
          'supported by income, long-term financial resilience remains limited.',
      points: 4,
      color: Color(0xFFEA580C),
    );
  }

  return const RatioScoreBand(
    category: 'Uncovered',
    threshold: -10,
    definition: 'Net worth is negative.',
    interpretation:
        'Your liabilities exceed your assets, resulting in a negative net '
        'worth. At this level, accumulated wealth provides no support for '
        'expenses or debt repayments, leaving long-term financial pressure very high.',
    points: 0,
    color: Color(0xFFDC2626),
  );
}
