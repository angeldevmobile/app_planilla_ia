import 'package:flutter/material.dart';
import 'class_bubble.dart';


import 'dart:math';
class AnimatedBubbles extends StatefulWidget {
  final bool isDesktop;
  const AnimatedBubbles({super.key, required this.isDesktop});

  @override
  State<AnimatedBubbles> createState() => _AnimatedBubblesState();
}

class _AnimatedBubblesState extends State<AnimatedBubbles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Bubble> bubbles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Más burbujas para desktop
    final bubbleCount = widget.isDesktop ? 30 : 15;

    for (int i = 0; i < bubbleCount; i++) {
      bubbles.add(Bubble(
        size: Random().nextDouble() * (widget.isDesktop ? 50 : 30) + 10,
        x: Random().nextDouble(),
        y: Random().nextDouble(),
        speed: Random().nextDouble() * 0.5 + 0.1,
        opacity: Random().nextDouble() * 0.3 + 0.1,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: BubblePainter(bubbles, _controller.value),
        );
      },
    );
  }
}
