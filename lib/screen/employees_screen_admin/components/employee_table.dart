import 'package:flutter/material.dart';

class EmployeeTable extends StatelessWidget {
  final List<Map<String, String>> employeeData;
  const EmployeeTable({super.key, required this.employeeData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezados fijos
            Row(
              children: const [
                Expanded(
                  flex: 2,
                  child: Text('NOMBRES',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: Text('ROL',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: Text('CARGO',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: Text('ESTADO',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: Text('ACCIONES',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const Divider(),
            // Solo las filas hacen scroll
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: employeeData.length,
                itemBuilder: (context, index) {
                  final employee = employeeData[index];
                  final estadoRaw = employee['estado'];
                  final estado = (estadoRaw ?? '').toLowerCase();
                  final isActive = estado == 'activo' || estado == 'active';

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${employee['nombres'] ?? ''} ${employee['apellidos'] ?? ''}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  employee['correo'] ?? '',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: Text(employee['rol'] ?? '')),
                          Expanded(child: Text(employee['cargo'] ?? '')),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? Colors.green[100]
                                    : Colors.red[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment:
                                  Alignment.center, 
                              child: Text(
                                isActive ? 'activo' : 'inactivo',
                                style: TextStyle(
                                  color: isActive ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign:
                                    TextAlign.center, // <-- Centra el texto
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, size: 18),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline,
                                      size: 18),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (index != employeeData.length - 1)
                        const Divider(height: 1),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
