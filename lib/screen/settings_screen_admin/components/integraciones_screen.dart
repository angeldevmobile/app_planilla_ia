import 'package:flutter/material.dart';

class IntegracionesScreen extends StatelessWidget {
  const IntegracionesScreen({super.key});

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
              Text(
                'Integraciones con Sistemas Externos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E384D),
                ),
              ),
              SizedBox(height: 24),
              _buildIntegrationCard(
                title: 'Sistema de Pago',
                icon: Icons.payment,
                connected: true,
                description:
                    'Integración con pasarela de pagos para cobros en línea',
              ),
              _buildIntegrationCard(
                title: 'Historial Clínico Electrónico',
                icon: Icons.medical_information,
                connected: false,
                description:
                    'Sincronización con el sistema nacional de historias clínicas',
              ),
              _buildIntegrationCard(
                title: 'Laboratorios Externos',
                icon: Icons.science,
                connected: true,
                description:
                    'Conexión con laboratorios para resultados de exámenes',
              ),
              _buildIntegrationCard(
                title: 'Sistema de Facturación',
                icon: Icons.receipt,
                connected: true,
                description: 'Generación automática de facturas electrónicas',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntegrationCard({
    required String title,
    required IconData icon,
    required bool connected,
    required String description,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 40, color: const Color(0xFF3366FF)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(description),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Chip(
              label: Text(connected ? 'Conectado' : 'Desconectado'),
              backgroundColor: connected ? Colors.green[50] : Colors.red[50],
              labelStyle: TextStyle(
                color: connected ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: connected ? null : const Color(0xFF3366FF),
              ),
              child: Text(connected ? 'Configurar' : 'Conectar'),
            ),
          ],
        ),
      ),
    );
  }
}
