import 'package:flutter/material.dart';
import 'dart:math' as math;

class BudgetConsumptionGuagePainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  const BudgetConsumptionGuagePainter({
    required this.progress,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 4.0;

    final center = Offset(size.width / 2, size.height / 2);

    final radius = (size.width / 2) - strokeWidth;

    final rect = Rect.fromCircle(center: center, radius: radius);

    const gapAngle = math.pi * 0.4; // 72°
    const sweepAngle = (math.pi * 2) - gapAngle;
    const startAngle = math.pi / 2 + (gapAngle / 2);

    final consumption = progress.clamp(0.0, 1.0);

    // ----------------------------------------------------------
    // Consumption color
    // ----------------------------------------------------------

    const green = Color(0xFF16A34A);
    const yellow = Color(0xFFEAB308);
    const orange = Color(0xFFF97316);
    const red = Color(0xFFDC2626);

    Color consumptionColor;

    if (consumption <= 0.5) {
      // 0% → 50%
      // Green → Yellow
      consumptionColor = Color.lerp(green, yellow, consumption / 0.5)!;
    } else if (consumption <= 0.8) {
      // 50% → 80%
      // Yellow → Orange
      consumptionColor = Color.lerp(yellow, orange, (consumption - 0.5) / 0.3)!;
    } else {
      // 80% → 100%
      // Orange → Red
      consumptionColor = Color.lerp(orange, red, (consumption - 0.8) / 0.2)!;
    }

    // ----------------------------------------------------------
    // Background
    // ----------------------------------------------------------

    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = backgroundColor;

    canvas.drawArc(rect, startAngle, sweepAngle, false, backgroundPaint);

    // ----------------------------------------------------------
    // Progress
    // ----------------------------------------------------------

    if (progress > 0) {
      final progressPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..color = consumptionColor;

      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle * consumption,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant BudgetConsumptionGuagePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
