import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/profile/models/ratio_score_band.dart';

RatioScoreBand wealthBuildingBand(double value) {
  if (value >= 30) {
    return const RatioScoreBand(
      category: 'Very High Pace',
      threshold: 30,
      definition: 'Wealth is building at a highly accelerated pace.',
      interpretation:
          'You prioritize long-term wealth building and consistently '
          'allocate a large share of your income toward it. This pace '
          'supports accelerated asset growth and can significantly shorten '
          'the time needed to reach major financial goals.',
      points: 20,
      color: Color(0xFF059669),
    );
  }

  if (value >= 20) {
    return const RatioScoreBand(
      category: 'High Pace',
      threshold: 20,
      definition: 'Wealth is building quickly and efficiently.',
      interpretation:
          'A significant portion of your income is allocated toward future '
          'growth. At this pace, wealth compounds faster, increasing '
          'financial resilience and expanding future options.',
      points: 15,
      color: Color(0xFF16A34A),
    );
  }

  if (value >= 10) {
    return const RatioScoreBand(
      category: 'Moderate Pace',
      threshold: 10,
      definition: 'Wealth is building at a healthy, sustainable pace.',
      interpretation:
          'You deliberately and consistently allocate income toward '
          'wealth-building activities. This pace supports steady progress '
          'over time and creates a solid foundation for long-term financial growth.',
      points: 10,
      color: Color(0xFF16A34A),
    );
  }

  if (value >= 5) {
    return const RatioScoreBand(
      category: 'Low Pace',
      threshold: 5,
      definition: 'Wealth is building slowly with limited momentum.',
      interpretation:
          'You consistently allocate part of your income toward future use, '
          'but progress remains gradual. This pace provides some stability, '
          'though growth may be easily disrupted by changes in income or expenses.',
      points: 5,
      color: Color(0xFFCA8A04),
    );
  }

  if (value >= 1) {
    return const RatioScoreBand(
      category: 'Very Low Pace',
      threshold: 1,
      definition: 'Wealth building ongoing, but progress is minimal.',
      interpretation:
          'A small portion of your income is being allocated toward future '
          'goals, but the pace is very slow. At this rate, wealth accumulation '
          'will take a long time to meaningfully improve your financial position.',
      points: 2,
      color: Color(0xFFEA580C),
    );
  }

  return const RatioScoreBand(
    category: 'Not Building Wealth',
    threshold: 0,
    definition: 'Currently no allocation toward wealth building.',
    interpretation:
        'You are not allocating any portion of your income toward long-term '
        'financial goals such as savings, investments, or retirement. This '
        'means wealth accumulation has not yet started, leaving you fully '
        'dependent on future income and vulnerable to unexpected expenses.',
    points: 0,
    color: Color(0xFFDC2626),
  );
}
