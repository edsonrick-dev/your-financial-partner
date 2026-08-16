import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/profile/models/ratio_score_band.dart';

RatioScoreBand emergencyFundBand(double value) {
  if (value >= 142.86) {
    return const RatioScoreBand(
      category: 'Wealth-Secure EF',
      threshold: 142.86,
      definition: 'Fully resilient continuity and emergency buffer.',
      interpretation:
          'Your liquid funds can sustain both your lifestyle and '
          'wealth-building allocations for an extended period. This level '
          'offers exceptional resilience, allowing you to weather long '
          'crises without derailing financial progress.',
      points: 20,
      color: Color(0xFF059669),
    );
  }

  if (value >= 121.43) {
    return const RatioScoreBand(
      category: 'Comprehensive EF',
      threshold: 121.43,
      definition: 'Strong protection with sustained progress.',
      interpretation:
          'Your emergency fund covers a full year of lifestyle needs and '
          'supports several months of wealth allocation. This provides '
          'resilience against prolonged disruptions while keeping '
          'long-term goals on track.',
      points: 18,
      color: Color(0xFF059669),
    );
  }

  if (value >= 110.71) {
    return const RatioScoreBand(
      category: 'Enhanced EF',
      threshold: 110.71,
      definition: 'Lifestyle protected while continuing some wealth building.',
      interpretation:
          'Your liquid funds fully protect your lifestyle and allow limited '
          'continuation of wealth allocation during disruptions. This level '
          'supports financial progress even while managing short-term instability.',
      points: 15,
      color: Color(0xFF16A34A),
    );
  }

  if (value >= 100) {
    return const RatioScoreBand(
      category: 'Optimal EF',
      threshold: 100,
      definition: 'Full-year safety net for lifestyle needs.',
      interpretation:
          'Your emergency fund can sustain your lifestyle allocation for a '
          'full year without income. This offers high short-term security '
          'and allows you to focus on recovery rather than survival during disruptions.',
      points: 12,
      color: Color(0xFF16A34A),
    );
  }

  if (value >= 50) {
    return const RatioScoreBand(
      category: 'Adequate EF',
      threshold: 50,
      definition: 'Solid short-term financial protection.',
      interpretation:
          'Your liquid funds can support roughly half a year of lifestyle '
          'allocation. This level provides strong protection against job '
          'loss or major emergencies and is commonly considered a sound baseline.',
      points: 9,
      color: Color(0xFF16A34A),
    );
  }

  if (value >= 25) {
    return const RatioScoreBand(
      category: 'Low EF',
      threshold: 25,
      definition: 'Can handle short-term disruptions.',
      interpretation:
          'Your emergency fund can sustain several months of living expenses '
          'and debt repayments. While this offers some breathing room, '
          'longer disruptions would still pose significant financial risk.',
      points: 6,
      color: Color(0xFFCA8A04),
    );
  }

  if (value >= 8.33) {
    return const RatioScoreBand(
      category: 'Minimal EF',
      threshold: 8.33,
      definition: 'Covers only very short-term disruptions.',
      interpretation:
          'Your liquid funds can cover approximately one month of lifestyle '
          'allocation. This provides limited protection against minor '
          'disruptions but is insufficient for meaningful income loss.',
      points: 3,
      color: Color(0xFFEA580C),
    );
  }

  return const RatioScoreBand(
    category: 'No EF',
    threshold: 0,
    definition: 'You have little to no buffer for emergencies or income loss.',
    interpretation:
        'You have little to no liquid funds set aside for emergencies. '
        'Any unexpected expense or income disruption would immediately '
        'create financial strain, often requiring debt or asset liquidation.',
    points: 0,
    color: Color(0xFFDC2626),
  );
}
