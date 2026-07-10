import 'package:flutter/material.dart';
import 'dart:math' as math;

class AppSparkline extends StatelessWidget {
  const AppSparkline({
    super.key,
    required this.values,
    required this.color,
    this.height = 24,
    this.strokeWidth = 2,
  });

  final List<double> values;
  final Color color;
  final double height;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _SparklinePainter(
          values: values,
          color: color,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  const _SparklinePainter({
    required this.values,
    required this.color,
    required this.strokeWidth,
  });

  final List<double> values;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;

    final points = _createPoints(size);
    final path = _createSmoothPath(points);

    _drawLine(canvas, path);
  }

  List<Offset> _createPoints(Size size) {
    final minValue = values.reduce(math.min);
    final maxValue = values.reduce(math.max);

    final range = maxValue - minValue == 0 ? 1.0 : maxValue - minValue;

    return List.generate(values.length, (index) {
      final dx = index / (values.length - 1) * size.width;

      final dy =
          size.height - ((values[index] - minValue) / range) * size.height;

      return Offset(dx, dy);
    });
  }

  Path _createSmoothPath(List<Offset> points) {
    final path = Path();

    path.moveTo(points.first.dx, points.first.dy);

    for (int i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];

      final midPoint = Offset(
        (current.dx + next.dx) / 2,
        (current.dy + next.dy) / 2,
      );

      path.quadraticBezierTo(current.dx, current.dy, midPoint.dx, midPoint.dy);
    }

    path.lineTo(points.last.dx, points.last.dy);

    return path;
  }

  void _drawLine(Canvas canvas, Path path) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) {
    return values != oldDelegate.values ||
        color != oldDelegate.color ||
        strokeWidth != oldDelegate.strokeWidth;
  }
}
