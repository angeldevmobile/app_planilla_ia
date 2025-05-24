import 'package:flutter/material.dart';

class AnimatedTextField extends StatelessWidget {
  final FocusNode focusNode;
  final String labelText;
  final IconData icon;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final bool isMobile;
  final TextEditingController? controller;

  const AnimatedTextField({
    super.key,
    required this.focusNode,
    required this.labelText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
    this.isMobile = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: focusNode.hasFocus 
              ? Colors.blueAccent 
              : Colors.grey.withOpacity(0.5),
          width: focusNode.hasFocus ? 1.5 : 1,
        ),
        boxShadow: focusNode.hasFocus
            ? [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: focusNode.hasFocus 
                  ? Colors.blueAccent 
                  : Colors.grey.shade600,
            ),
            border: InputBorder.none,
            icon: Icon(
              icon,
              size: isMobile ? 20 : 24,
              color: focusNode.hasFocus 
                  ? Colors.blueAccent 
                  : Colors.grey.shade600,
            ),
            suffixIcon: suffixIcon,
          ),
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: TextStyle(
            fontSize: isMobile ? 15 : 17,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}