import 'package:flutter/material.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  final String email;

  const Header({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Crear Nueva Contraseña',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: kPrimaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Para $email',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Usa una contraseña fuerte que no hayas usado antes',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}