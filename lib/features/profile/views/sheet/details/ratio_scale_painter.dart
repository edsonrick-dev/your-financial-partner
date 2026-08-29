import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/models/ratio_score_band.dart';

class RatioScale extends StatelessWidget {
  const RatioScale({
    super.key,
    required this.value,
    required this.bands,
    this.minValue = 0,
    this.maxValue = 100,
  });

  final double value;
  final List<RatioScoreBand> bands;
  final double minValue;
  final double maxValue;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: CustomPaint(
        painter: RatioScalePainter(
          value: value,
          bands: bands,
          minValue: minValue,
          maxValue: maxValue,
          lineColor: colorScheme.appText,
        ),
      ),
    );
  }
}

class RatioScalePainter extends CustomPainter {
  const RatioScalePainter({
    required this.value,
    required this.bands,
    required this.minValue,
    required this.maxValue,
    required this.lineColor,
  });

  final double value;
  final List<RatioScoreBand> bands;
  final double minValue;
  final double maxValue;
  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    const double lineY = 16;
    const double lineHeight = 8;
    const double indicatorHeight = 6;

    final double width = size.width;
    final double range = maxValue - minValue;

    double xFromValue(double value) {
      if (range <= 0) return 0;

      return ((value - minValue) / range).clamp(0.0, 1.0) * width;
    }

    // ----------------------------------------
    // Draw colored bands
    // ----------------------------------------

    for (int i = 0; i < bands.length; i++) {
      final band = bands[i];

      final startValue = band.threshold;

      final endValue = i < bands.length - 1 ? bands[i + 1].threshold : maxValue;

      final startX = xFromValue(startValue);
      final endX = xFromValue(endValue);

      final rect = Rect.fromLTRB(startX, lineY, endX, lineY + lineHeight);

      final paint = Paint()..color = band.color ?? Colors.grey;

      final borderRadius = BorderRadius.circular(lineHeight / 2);

      final path = Path()..addRRect(borderRadius.toRRect(rect));

      canvas.drawPath(path, paint);
    }

    // ----------------------------------------
    // Threshold labels
    // ----------------------------------------

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (final band in bands) {
      final threshold = band.threshold;

      if (threshold < minValue || threshold > maxValue) {
        continue;
      }

      final x = xFromValue(threshold);

      textPainter.text = TextSpan(
        text: threshold.toStringAsFixed(0),
        style: AppTextStyle.amountXS.copyWith(color: lineColor.withAlpha(150)),
      );

      textPainter.layout();

      // Keep labels inside the scale.
      final labelX = (x - textPainter.width / 2).clamp(
        0.0,
        width - textPainter.width,
      );

      textPainter.paint(canvas, Offset(labelX, lineY + lineHeight + 4));
    }

    // ----------------------------------------
    // Current value indicator
    // ----------------------------------------

    final currentX = xFromValue(value);

    final indicatorPaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(currentX, lineY - indicatorHeight),
      Offset(currentX, lineY + lineHeight + indicatorHeight),
      indicatorPaint,
    );
  }

  @override
  bool shouldRepaint(covariant RatioScalePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.bands != bands ||
        oldDelegate.minValue != minValue ||
        oldDelegate.maxValue != maxValue ||
        oldDelegate.lineColor != lineColor;
  }
}
