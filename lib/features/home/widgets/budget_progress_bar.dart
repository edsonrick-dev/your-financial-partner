import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class BudgetProgressBar extends StatelessWidget {
  const BudgetProgressBar({
    super.key,
    required this.progress,
    this.marker,
    required this.color,
    this.height = 6,
  });

  final double progress;
  final double? marker;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            decoration: BoxDecoration(
              color: colors.appBorderMuted,
              borderRadius: BorderRadius.circular(999),
            ),
          ),

          FractionallySizedBox(
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),

          if (marker != null)
            Align(
              alignment: Alignment(marker!.clamp(0.0, 1.0) * 2 - 1, 0),
              child: Container(
                width: 2,
                height: 10,
                decoration: BoxDecoration(
                  color: colors.appTextMuted,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
