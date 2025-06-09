import 'package:flutter/material.dart';

class HorariosScreen extends StatelessWidget {
  const HorariosScreen({super.key});

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
              const Text(
                'Configuración de Horarios',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E384D),
                ),
              ),
              const SizedBox(height: 24),

              // Horario general
              _buildHorarioSection(
                title: 'Horario General',
                horarios: {
                  'Lunes a Viernes': {'inicio': '08:00', 'fin': '18:00'},
                  'Sábado': {'inicio': '09:00', 'fin': '14:00'},
                  'Domingo': {'inicio': 'Cerrado', 'fin': 'Cerrado'},
                },
              ),

              const SizedBox(height: 32),

              // Horarios especiales
              const Text(
                'Horarios Especiales',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E384D),
                ),
              ),
              const SizedBox(height: 16),

              _buildHorarioEspecialItem(
                  'Día del Médico', '2023-10-23', 'Cerrado'),
              _buildHorarioEspecialItem('Navidad', '2023-12-25', 'Cerrado'),

              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3366FF),
                ),
                child: const Text('Agregar Horario Especial'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHorarioSection(
      {required String title,
      required Map<String, Map<String, String>> horarios}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E384D),
          ),
        ),
        const SizedBox(height: 12),
        ...horarios.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text(entry.key),
                ),
                const SizedBox(width: 16),
                _buildTimePicker(entry.value['inicio']!),
                const SizedBox(width: 16),
                const Text('a'),
                const SizedBox(width: 16),
                _buildTimePicker(entry.value['fin']!),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildTimePicker(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(time),
          const SizedBox(width: 8),
          const Icon(Icons.access_time, size: 18),
        ],
      ),
    );
  }

  Widget _buildHorarioEspecialItem(
      String nombre, String fecha, String horario) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(fecha),
              ],
            ),
          ),
          Text(horario),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
