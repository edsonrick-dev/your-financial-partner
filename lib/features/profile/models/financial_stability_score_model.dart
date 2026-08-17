import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/profile/enum/financial_stability_level.dart';

class FinancialStability {
  final FinancialStabilityLevel level;
  final int minScore;
  final String title;
  final String shortDescription;
  final String longDescription;
  final Color color;

  const FinancialStability({
    required this.level,
    required this.minScore,
    required this.title,
    required this.shortDescription,
    required this.longDescription,
    required this.color,
  });

  static const unstable = FinancialStability(
    level: FinancialStabilityLevel.unstable,
    minScore: 0,
    title: 'Unstable',
    shortDescription: 'Your finances are under significant financial stress.',
    longDescription:
        'Your finances have major vulnerabilities that may make it difficult '
        'to absorb unexpected expenses, income disruptions, or other financial shocks.',
    color: Color(0xFFDC2626),
  );

  static const early = FinancialStability(
    level: FinancialStabilityLevel.early,
    minScore: 20,
    title: 'Early Stability',
    shortDescription: 'Your financial foundation is beginning to take shape.',
    longDescription:
        'You have started building financial stability, but important gaps '
        'remain in areas such as liquidity, debt management, protection, '
        'or wealth building.',
    color: Color(0xFFEA580C),
  );

  static const partial = FinancialStability(
    level: FinancialStabilityLevel.partial,
    minScore: 40,
    title: 'Partial Stability',
    shortDescription: 'Your finances are functional but vulnerable to stress.',
    longDescription:
        'You meet core financial needs and have some protective measures '
        'in place, but weaknesses in one or more areas increase vulnerability.',
    color: Color(0xFFCA8A04),
  );

  static const good = FinancialStability(
    level: FinancialStabilityLevel.good,
    minScore: 55,
    title: 'Good Stability',
    shortDescription: 'Your finances are stable with room for optimization.',
    longDescription:
        'Your financial foundation is solid, with good protection against '
        'common disruptions. While most areas are performing well, targeted '
        'improvements can further enhance long-term stability.',
    color: Color(0xFF16A34A),
  );

  static const excellent = FinancialStability(
    level: FinancialStabilityLevel.excellent,
    minScore: 70,
    title: 'Excellent Stability',
    shortDescription: 'Your finances are strong, resilient, and well-balanced.',
    longDescription:
        'You have a high level of financial stability across liquidity, '
        'lifestyle coverage, debt management, and wealth-building activity. '
        'Your financial structure can absorb disruptions, sustain your '
        'lifestyle, and continue progressing toward long-term goals with minimal stress.',
    color: Color(0xFF059669),
  );

  static FinancialStability fromScore(num score) {
    if (score < 0 || score > 80) {
      throw ArgumentError(
        'Financial stability score must be between 0 and 80.',
      );
    }

    if (score >= 70) return excellent;
    if (score >= 55) return good;
    if (score >= 40) return partial;
    if (score >= 20) return early;

    return unstable;
  }
}
