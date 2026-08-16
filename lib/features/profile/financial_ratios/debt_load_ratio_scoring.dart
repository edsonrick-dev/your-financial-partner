import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/profile/models/ratio_score_band.dart';

RatioScoreBand debtLoadBand(double value) {
  if (value >= 50) {
    return const RatioScoreBand(
      category: 'Severe Load',
      threshold: 50,
      definition: 'Debt dominates income.',
      interpretation:
          'More than half of your income is allocated to debt repayments.',
      points: 0,
    );
  }

  if (value >= 35) {
    return const RatioScoreBand(
      category: 'High Load',
      threshold: 35,
      definition: 'Debt significantly constrains cash flow.',
      interpretation:
          'A large portion of income is committed to debt servicing.',
      points: 5,
    );
  }

  if (value >= 25) {
    return const RatioScoreBand(
      category: 'Moderate Load',
      threshold: 25,
      definition: 'Debt creates manageable income pressure.',
      interpretation: 'Debt repayments consume a noticeable share of income.',
      points: 10,
    );
  }

  if (value >= 15) {
    return const RatioScoreBand(
      category: 'Low Load',
      threshold: 15,
      definition: 'Debt is easily manageable.',
      interpretation:
          'A small portion of your income is allocated to debt repayments.',
      points: 15,
      color: Color(0xFF16A34A),
    );
  }

  return const RatioScoreBand(
    category: 'Minimal Load',
    threshold: 0,
    definition: 'Debt places little to no pressure on income.',
    interpretation:
        'You have no required debt repayments relative to your income.',
    points: 20,
    color: Color(0xFF16A34A),
  );
}
