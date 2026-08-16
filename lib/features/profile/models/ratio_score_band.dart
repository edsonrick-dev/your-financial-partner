import 'package:flutter/material.dart';

class RatioScoreBand {
  final String category;
  final double threshold;
  final String definition;
  final String interpretation;
  final int points;
  final Color? color;
  const RatioScoreBand({
    required this.category,
    required this.threshold,
    required this.definition,
    required this.interpretation,
    required this.points,
    this.color,
  });
}
