import 'package:flutter/material.dart';

class EspecialidadesScreen extends StatelessWidget {
  const EspecialidadesScreen({super.key});

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
                'Gestión de Especialidades Médicas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E384D),
                ),
              ),
              const SizedBox(height: 24),

              // Lista de especialidades
              _buildEspecialidadItem('Cardiología', true),
              _buildEspecialidadItem('Pediatría', true),
              _buildEspecialidadItem('Dermatología', false),
              _buildEspecialidadItem('Neurología', true),
              _buildEspecialidadItem('Oftalmología', true),

              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3366FF),
                ),
                child: const Text('Agregar Nueva Especialidad'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEspecialidadItem(String nombre, bool activa) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Checkbox(
            value: activa,
            onChanged: (value) {},
            activeColor: const Color(0xFF3366FF),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              nombre,
              style: const TextStyle(fontSize: 16),
            ),
          ),
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
