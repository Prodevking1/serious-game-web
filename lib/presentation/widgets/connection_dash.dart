import 'package:flutter/material.dart';

class RegionConnectionsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    // Draw the dashed lines between regions here
    canvas.drawLine(const Offset(100, 100), const Offset(200, 200), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
