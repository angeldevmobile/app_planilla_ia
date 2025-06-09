import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final bool isTablet;

  const Footer({super.key, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 8,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Column(
          children: [
            Text(
              "OPTIMIZADO PARA CHROME, EDGE Y FIREFOX",
              style: TextStyle(
                color: Colors.white.withAlpha((0.7 * 255).toInt()),
                fontSize: isTablet ? 12 : 14,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFooterIcon(
                  icon: Icons.language,
                  label: "Idioma",
                  isTablet: isTablet,
                ),
                _buildFooterIcon(
                  icon: Icons.help_outline,
                  label: "Ayuda",
                  isTablet: isTablet,
                ),
                _buildFooterIcon(
                  icon: Icons.phone,
                  label: "Contacto",
                  isTablet: isTablet,
                ),
                _buildFooterIcon(
                  icon: Icons.security,
                  label: "Seguridad",
                  isTablet: isTablet,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "© 2025 SmartPayroll - Todos los derechos reservados",
              style: TextStyle(
                color: Colors.white.withAlpha((0.5 * 255).toInt()),
                fontSize: isTablet ? 10 : 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterIcon({
    required IconData icon,
    required String label,
    required bool isTablet,
  }) {
    return Tooltip(
      message: label,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withAlpha((0.3 * 255).toInt()),
            width: 1,
          ),
        ),
        child: IconButton(
          icon: Icon(icon,
              color: Colors.white.withAlpha((0.7 * 255).toInt()), size: isTablet ? 20 : 24),
          onPressed: () {},
          splashRadius: 20,
        ),
      ),
    );
  }
}
