import 'package:flutter/material.dart';

class NeonText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final double blurRadius;

  const NeonText({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.color = Colors.white,
    this.blurRadius = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: color,
            shadows: [
              Shadow(
                  color: color,
                  blurRadius: blurRadius,
                  offset: const Offset(0, 0)),
              Shadow(
                  color: color.withOpacity(0.7),
                  blurRadius: blurRadius * 1.5,
                  offset: const Offset(0, 0)),
              Shadow(
                  color: color.withOpacity(0.4),
                  blurRadius: blurRadius * 3,
                  offset: const Offset(0, 0)),
            ],
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: color.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}