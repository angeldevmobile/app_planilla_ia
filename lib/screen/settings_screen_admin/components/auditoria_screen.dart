import 'package:flutter/material.dart';

class AuditoriaScreen extends StatelessWidget {
  const AuditoriaScreen({super.key});

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
                'Registro de Auditoría',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E384D),
                ),
              ),
              const SizedBox(height: 24),

              // Filtros
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Buscar',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  DropdownButton<String>(
                    value: 'Todos',
                    items: const [
                      DropdownMenuItem(value: 'Todos', child: Text('Todos')),
                      DropdownMenuItem(value: 'Login', child: Text('Login')),
                      DropdownMenuItem(
                          value: 'Config', child: Text('Configuración')),
                      DropdownMenuItem(
                          value: 'Pacientes', child: Text('Pacientes')),
                    ],
                    onChanged: (value) {},
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3366FF),
                    ),
                    child: const Text('Filtrar'),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Tabla de auditoría
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Fecha')),
                    DataColumn(label: Text('Usuario')),
                    DataColumn(label: Text('Acción')),
                    DataColumn(label: Text('Detalle')),
                    DataColumn(label: Text('IP')),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('2023-10-15 10:30')),
                      DataCell(Text('admin@clinica.com')),
                      DataCell(Text('Login')),
                      DataCell(Text('Inicio de sesión exitoso')),
                      DataCell(Text('192.168.1.1')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('2023-10-15 10:35')),
                      DataCell(Text('admin@clinica.com')),
                      DataCell(Text('Configuración')),
                      DataCell(Text('Cambió horario de atención')),
                      DataCell(Text('192.168.1.1')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('2023-10-15 11:20')),
                      DataCell(Text('doctor@clinica.com')),
                      DataCell(Text('Paciente')),
                      DataCell(Text('Actualizó historial médico')),
                      DataCell(Text('192.168.1.15')),
                    ]),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Exportar
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Exportar a PDF'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.file_download),
                    label: const Text('Exportar a CSV'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
