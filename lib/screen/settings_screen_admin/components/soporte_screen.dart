import 'package:flutter/material.dart';

class SoporteScreen extends StatelessWidget {
  const SoporteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.05 * 255).toInt()),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Soporte Técnico',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E384D),
                  )),
              const SizedBox(height: 24),

              // Información de contacto
              Card(
                color: const Color(0xFFF0F5FF),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(Icons.phone, color: Color(0xFF3366FF)),
                        title: Text('Teléfono de Soporte'),
                        subtitle:
                            Text('+51 1 234-5678 (Lunes a Viernes 9am-6pm)'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.email, color: Color(0xFF3366FF)),
                        title: Text('Correo Electrónico'),
                        subtitle: Text('soporte@clinicasystem.com'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.chat, color: Color(0xFF3366FF)),
                        title: Text('Chat en Vivo'),
                        subtitle: Text('Disponible 24/7 para emergencias'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3366FF),
                        ),
                        child: const Text('Iniciar Chat de Soporte'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Formulario de soporte
              const Text(
                'Enviar Solicitud de Soporte',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E384D),
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Asunto',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: 'Problema técnico',
                decoration: InputDecoration(
                  labelText: 'Tipo de problema',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                      value: 'Problema técnico',
                      child: Text('Problema técnico')),
                  DropdownMenuItem(value: 'Consulta', child: Text('Consulta')),
                  DropdownMenuItem(
                      value: 'Error del sistema',
                      child: Text('Error del sistema')),
                  DropdownMenuItem(
                      value: 'Solicitud de función',
                      child: Text('Solicitud de función')),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Descripción detallada',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3366FF),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Enviar Solicitud de Soporte'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
