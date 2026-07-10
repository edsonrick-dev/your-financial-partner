import 'package:flutter/material.dart';
import 'dart:math' as math;

class BudgetProgressIndicator extends StatelessWidget {
  const BudgetProgressIndicator({
    super.key,
    required this.progress,
    required this.child,
    this.size = 80,
    this.strokeWidth = 8,
    required this.progressColor,
    this.backgroundColor = const Color(0xFFE7EAF0),
  });

  final double progress;
  final double size;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size.square(size),
            painter: _BudgetProgressPainter(
              progress: progress.clamp(0.0, 1.0),
              strokeWidth: strokeWidth,
              progressColor: progressColor,
              backgroundColor: backgroundColor,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _BudgetProgressPainter extends CustomPainter {
  const _BudgetProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.progressColor,
    required this.backgroundColor,
  });

  final double progress;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    final radius = (size.width - strokeWidth) / 2;

    final rect = Rect.fromCircle(center: center, radius: radius);

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, 0, math.pi * 2, false, backgroundPaint);

    canvas.drawArc(
      rect,
      -math.pi / 2,
      math.pi * 2 * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_BudgetProgressPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        progressColor != oldDelegate.progressColor ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}
