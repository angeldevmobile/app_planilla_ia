import 'package:flutter/material.dart';

class BackupScreen extends StatelessWidget {
  const BackupScreen({super.key});

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
                'Gestión de Copias de Seguridad',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E384D),
                ),
              ),
              const SizedBox(height: 24),

              // Configuración de backup automático
              _buildBackupSetting(
                title: 'Backup Automático',
                description:
                    'Realiza copias de seguridad automáticas cada 24 horas',
                enabled: true,
              ),

              const SizedBox(height: 32),

              // Últimos backups
              const Text('Últimas Copias de Seguridad',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E384D),
                  )),
              SizedBox(height: 16),

              _buildBackupItem('2023-10-15 23:59', 'Completo', '2.5 GB'),
              _buildBackupItem('2023-10-14 23:59', 'Completo', '2.4 GB'),
              _buildBackupItem('2023-10-13 23:59', 'Parcial', '1.8 GB'),

              const SizedBox(height: 24),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3366FF),
                    ),
                    child: const Text('Crear Backup Ahora'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Restaurar desde Backup'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackupSetting({
    required String title,
    required String description,
    required bool enabled,
  }) {
    return Row(
      children: [
        Switch(
          value: enabled,
          onChanged: (value) {},
          activeColor: const Color(0xFF3366FF),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                description,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackupItem(String fecha, String tipo, String tamano) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.backup, size: 30, color: Color(0xFF3366FF)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fecha,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Tipo: $tipo | Tamaño: $tamano'),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.cloud_download),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
