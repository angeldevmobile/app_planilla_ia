import 'package:flutter/material.dart';

class OTPHeader extends StatelessWidget {
  final bool showError;
  final String email;
  final Color primaryColor;
  final Color errorColor;

  const OTPHeader({
    super.key,
    required this.showError,
    required this.email,
    required this.primaryColor,
    required this.errorColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: showError
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Código incorrecto',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: errorColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'El código ingresado no es válido. Inténtalo de nuevo.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: errorColor,
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verificación en dos pasos',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'Ingresa el código de 6 dígitos enviado a ',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                    children: [
                      TextSpan(
                        text: email,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
