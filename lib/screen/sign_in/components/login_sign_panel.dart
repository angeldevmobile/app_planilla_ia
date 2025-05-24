import 'package:flutter/material.dart';

class LoginSidePanel extends StatelessWidget {
  const LoginSidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    if (isMobile) return const SizedBox.shrink();

    return Container(
      width: size.width * 0.85, // Más ancho (85% de la pantalla)
      height: size.height * 0.8, // Altura suficiente
      margin: const EdgeInsets.only(
        left: 20, // Margen izquierdo reducido para acercarlo al borde
        right: 20, // Margen derecho pequeño para equilibrio
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Imagen de fondo (ocupará todo el espacio)
            Positioned.fill(
              child: Image.asset(
                'images/planilla_form.gif',
                fit: BoxFit.cover, 
              ),
            ),
            // Overlay para mejor legibilidad del texto
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),
            // Texto superpuesto
            const Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "SmartPayroll",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 6,
                          color: Colors.black,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Gestión de nómina inteligente",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
