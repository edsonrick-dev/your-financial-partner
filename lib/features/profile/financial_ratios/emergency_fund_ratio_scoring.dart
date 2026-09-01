import 'package:flutter/material.dart';

import 'package:getx_drift_app/features/profile/models/ratio_score_band.dart';

// RatioScoreBand emergencyFundBand(double value) {
//   return emergencyFundBands.firstWhere((band) => value >= band.threshold);
// }
RatioScoreBand emergencyFundBand(double? value) {
  if (value == null) {
    return emergencyFundNotAssessedBand;
  }

  return emergencyFundBands.firstWhere(
    (band) => value >= band.threshold,
    orElse: () => emergencyFundBands.last,
  );
}

const emergencyFundNotAssessedBand = RatioScoreBand(
  category: 'Not Assessed',
  threshold: 0,
  definition: 'Your emergency fund cannot currently be assessed.',
  interpretation:
      'An income plan and budget plan, along with liquid fund data, '
      'are required to determine how long your financial needs can be covered.',
  points: 0,
  color: Color(0xFF9CA3AF),
);
RatioScoreBand opportunityFundBand(double? value) {
  if (value == null) {
    return opportunityFundNotAssessedBand;
  }

  return opportunityFundBands.firstWhere(
    (band) => value >= band.threshold,
    orElse: () => opportunityFundBands.last,
  );
}

const opportunityFundNotAssessedBand = RatioScoreBand(
  category: 'Not Assessed',
  threshold: 0,
  definition: 'Opportunity fund cannot currently be assessed.',
  interpretation:
      'Additional liquid funds beyond your emergency fund target '
      'are required to assess your opportunity fund.',
  points: 0,
  color: Color(0xFF9CA3AF),
);
const opportunityFundBands = [
  RatioScoreBand(
    category: 'Wealth-Secured Fund',
    threshold: 142.86,
    definition: 'Fully resilient continuity and emergency buffer.',
    interpretation:
        'Your liquid funds can sustain both your lifestyle and '
        'wealth-building allocations for an extended period. This level '
        'offers exceptional resilience, allowing you to weather long '
        'crises without derailing financial progress.',
    points: 20,
    color: Color(0xFF059669),
  ),

  RatioScoreBand(
    category: 'Comprehensive Fund',
    threshold: 121.43,
    definition: 'Strong protection with sustained progress.',
    interpretation:
        'Your emergency fund covers a full year of lifestyle needs and '
        'supports several months of wealth allocation. This provides '
        'resilience against prolonged disruptions while keeping '
        'long-term goals on track.',
    points: 18,
    color: Color(0xFF059669),
  ),

  RatioScoreBand(
    category: 'Enhanced Fund',
    threshold: 110.71,
    definition: 'Lifestyle protected while continuing some wealth building.',
    interpretation:
        'Your liquid funds fully protect your lifestyle and allow limited '
        'continuation of wealth allocation during disruptions. This level '
        'supports financial progress even while managing short-term instability.',
    points: 15,
    color: Color(0xFF16A34A),
  ),
  RatioScoreBand(
    category: 'Optimal Fund',
    threshold: 100,
    definition: 'Full-year safety net for lifestyle needs.',
    interpretation:
        'Your emergency fund can sustain your lifestyle allocation for a '
        'full year without income. This offers high short-term security '
        'and allows you to focus on recovery rather than survival during disruptions.',
    points: 12,
    color: Color(0xFF16A34A),
  ),
];
const emergencyFundBands = [
  RatioScoreBand(
    category: 'Optimal Fund',
    threshold: 100,
    definition: 'Full-year safety net for lifestyle needs.',
    interpretation:
        'Your emergency fund can sustain your lifestyle allocation for a '
        'full year without income. This offers high short-term security '
        'and allows you to focus on recovery rather than survival during disruptions.',
    points: 12,
    color: Color(0xFF16A34A),
  ),
  RatioScoreBand(
    category: 'Adequate Fund',
    threshold: 50,
    definition: 'Solid short-term financial protection.',
    interpretation:
        'Your liquid funds can support roughly half a year of lifestyle '
        'allocation. This level provides strong protection against job '
        'loss or major emergencies and is commonly considered a sound baseline.',
    points: 9,
    color: Color(0xFF16A34A),
  ),

  RatioScoreBand(
    category: 'Low Fund',
    threshold: 25,
    definition: 'Can handle short-term disruptions.',
    interpretation:
        'Your emergency fund can sustain several months of living expenses '
        'and debt repayments. While this offers some breathing room, '
        'longer disruptions would still pose significant financial risk.',
    points: 6,
    color: Color(0xFFCA8A04),
  ),

  RatioScoreBand(
    category: 'Minimal Fund',
    threshold: 8.33,
    definition: 'Covers only very short-term disruptions.',
    interpretation:
        'Your liquid funds can cover approximately one month of lifestyle '
        'allocation. This provides limited protection against minor '
        'disruptions but is insufficient for meaningful income loss.',
    points: 3,
    color: Color(0xFFEA580C),
  ),

  RatioScoreBand(
    category: 'No Fund',
    threshold: 0,
    definition: 'You have little to no buffer for emergencies or income loss.',
    interpretation:
        'You have little to no liquid funds set aside for emergencies. '
        'Any unexpected expense or income disruption would immediately '
        'create financial strain, often requiring debt or asset liquidation.',
    points: 0,
    color: Color(0xFFDC2626),
  ),
];
const fundBands = [
  // Stage 2 — Opportunity Fund
  RatioScoreBand(
    category: 'Wealth-Secured Fund',
    threshold: 142.86,
    definition: 'Fully resilient continuity and emergency buffer.',
    interpretation:
        'Your liquid funds can sustain both your lifestyle and '
        'wealth-building allocations for an extended period.',
    points: 20,
    color: Color(0xFF059669),
  ),

  RatioScoreBand(
    category: 'Comprehensive Fund',
    threshold: 121.43,
    definition: 'Strong protection with sustained progress.',
    interpretation:
        'Your liquid funds cover a full year of lifestyle needs '
        'while providing additional capacity for wealth allocation.',
    points: 18,
    color: Color(0xFF059669),
  ),

  RatioScoreBand(
    category: 'Enhanced Fund',
    threshold: 110.71,
    definition: 'Lifestyle protected while continuing some wealth building.',
    interpretation:
        'Your liquid funds fully protect your lifestyle and provide '
        'additional capacity beyond the emergency fund.',
    points: 15,
    color: Color(0xFF16A34A),
  ),

  // Stage 1 — Emergency Fund
  RatioScoreBand(
    category: 'Optimal Fund',
    threshold: 100,
    definition: 'Full-year safety net for lifestyle needs.',
    interpretation:
        'Your emergency fund can sustain your lifestyle allocation '
        'for a full year without income.',
    points: 12,
    color: Color(0xFF16A34A),
  ),

  RatioScoreBand(
    category: 'Adequate Fund',
    threshold: 50,
    definition: 'Solid short-term financial protection.',
    interpretation:
        'Your liquid funds can support roughly half a year of '
        'lifestyle allocation.',
    points: 9,
    color: Color(0xFF16A34A),
  ),

  RatioScoreBand(
    category: 'Low Fund',
    threshold: 25,
    definition: 'Can handle short-term disruptions.',
    interpretation:
        'Your emergency fund provides some short-term breathing room.',
    points: 6,
    color: Color(0xFFCA8A04),
  ),

  RatioScoreBand(
    category: 'Minimal Fund',
    threshold: 8.33,
    definition: 'Covers only very short-term disruptions.',
    interpretation:
        'Your liquid funds can cover approximately one month '
        'of lifestyle allocation.',
    points: 3,
    color: Color(0xFFEA580C),
  ),

  RatioScoreBand(
    category: 'No Fund',
    threshold: 0,
    definition: 'You have little to no buffer for emergencies or income loss.',
    interpretation:
        'You have little to no liquid funds set aside for emergencies.',
    points: 0,
    color: Color(0xFFDC2626),
  ),
];
RatioScoreBand fundBand(double? value) {
  if (value == null) {
    return emergencyFundNotAssessedBand;
  }

  return fundBands.firstWhere(
    (band) => value >= band.threshold,
    orElse: () => fundBands.last,
  );
}
