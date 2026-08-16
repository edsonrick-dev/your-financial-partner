import 'package:flutter/material.dart';
import 'dart:math' as math;

class FinancialStabilityGauge extends StatelessWidget {
  final int score;
  final int maxScore;
  final ColorScheme colorScheme;

  const FinancialStabilityGauge({
    super.key,
    required this.score,
    this.maxScore = 80,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final clampedScore = score.clamp(0, maxScore).toDouble();
    final progress = clampedScore / maxScore;
    final normalizedScore = (score / 80) * 100;
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(80, 80),
            painter: _FinancialStabilityGaugePainter(progress: progress),
          ),

          // Score
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                normalizedScore.round().toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
              const SizedBox(height: 2),
              // Text(
              //   'out of ${maxScore.toStringAsFixed(0)}',
              //   style: const TextStyle(
              //     fontSize: 9,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FinancialStabilityGaugePainter extends CustomPainter {
  final double progress;

  const _FinancialStabilityGaugePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 8.0;

    final center = Offset(size.width / 2, size.height / 2);

    final radius = (size.width / 2) - strokeWidth;

    final rect = Rect.fromCircle(center: center, radius: radius);

    // 80% of a full circle = 288°
    const gapAngle = math.pi * 0.4; // 72°
    const sweepAngle = (math.pi * 2) - gapAngle;
    const startAngle = math.pi / 2 + (gapAngle / 2);

    // Your stability colors.
    const unstable = Color(0xFFDC2626);
    const early = Color(0xFFEA580C);
    const partial = Color(0xFFCA8A04);
    const good = Color(0xFF16A34A);
    const excellent = Color(0xFF059669);

    // The gauge crosses the 360° boundary at this score.
    //
    // startAngle = 126°
    // 126° + 234° = 360°
    //
    // 234 / 288 * 80 = 65
    const wrapScore = 65.0;

    // Color at score 65, which lies between Good (55)
    // and Excellent (70).
    final wrapColor = Color.lerp(
      good,
      excellent,
      (wrapScore - 55) / (70 - 55),
    )!;

    /*
      We map the gauge onto the full 360° shader space.

      0°   → score 65
      54°  → score 80
      126° → score 0
      198° → score 20
      270° → score 40
      324° → score 55
      360° → score 65

      The 54° → 126° section is the unused gap, so its
      colors don't matter visually.
    */
    final gradient = SweepGradient(
      startAngle: 0,
      endAngle: math.pi * 2,
      stops: const [0.00, 0.15, 0.35, 0.55, 0.75, 0.90, 1.00],
      colors: [
        wrapColor, // score 65
        excellent, // score 80
        unstable, // score 0
        early, // score 20
        partial, // score 40
        good, // score 55
        wrapColor, // score 65
      ],
    );

    // Unreached portion.
    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = Colors.black.withValues(alpha: 0.06);

    canvas.drawArc(rect, startAngle, sweepAngle, false, backgroundPaint);

    // Reached portion.
    if (progress > 0) {
      final progressPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..shader = gradient.createShader(rect);

      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _FinancialStabilityGaugePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
