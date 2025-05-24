import 'package:flutter/material.dart';

import '../../neon_text/animated.dart';

class AnimatedBackground extends StatelessWidget {
  final bool isDesktop;

  const AnimatedBackground({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900,
              Colors.blueAccent.shade700,
              Colors.blueAccent.shade400,
            ],
            stops: const [0.1, 0.5, 0.9],
          ),
        ),
        child: Stack(
          children: [
            AnimatedBubbles(isDesktop: isDesktop),
            // Efecto de partículas adicional
            if (isDesktop)
              Positioned.fill(
                child: IgnorePointer(
                  child: Opacity(
                    opacity: 0.15,
                    child: Image.asset(
                      'assets/images/planilla.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
