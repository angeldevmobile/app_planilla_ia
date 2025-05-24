import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;

  const AnimatedButton({super.key, required this.onTap, required this.text});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        Future.delayed(const Duration(milliseconds: 150), () {
          setState(() => _isPressed = false);
          widget.onTap();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 160,
        height: 44,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isPressed
                ? [Colors.blue.shade700, Colors.blue.shade400]
                : [Colors.blue.shade500, Colors.blue.shade300],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            if (!_isPressed)
              BoxShadow(
                color: Colors.blue.withAlpha((0.3 * 255).toInt()),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          widget.text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
