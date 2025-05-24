import 'package:flutter/material.dart';

class Bubble {
  double size;
  double x;
  double y;
  double speed;
  double opacity;
  double? initialY;

  Bubble({
    required this.size,
    required this.x,
    required this.y,
    required this.speed,
    required this.opacity,
  }) {
    initialY = y;
  }
}

class BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;
  final double animationValue;

  BubblePainter(this.bubbles, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final bubble in bubbles) {
      // Calcular posición Y con animación
      final yPos = (bubble.initialY! + animationValue * bubble.speed) % 1.2;

      paint.color = Colors.white.withOpacity(bubble.opacity);

      canvas.drawCircle(
        Offset(bubble.x * size.width, yPos * size.height),
        bubble.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
