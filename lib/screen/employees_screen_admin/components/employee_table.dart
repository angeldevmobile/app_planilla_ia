import 'package:flutter/material.dart';
import '../../../api/planilla_service.dart';

class EmployeeTable extends StatefulWidget {
  final List<Map<String, dynamic>> employeeData;
  final PlanillaService planillaService;

  const EmployeeTable({
    super.key,
    required this.employeeData,
    required this.planillaService,
  });

  @override
  State<EmployeeTable> createState() => _EmployeeTableState();
}

class _EmployeeTableState extends State<EmployeeTable> {
  String? loadingId;

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
            Row(
              children: const [
                Expanded(
                    flex: 2,
                    child: Text('NOMBRES',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('ROL',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('CARGO',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('ESTADO',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('ACCIONES',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            const Divider(),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: widget.employeeData.length,
                itemBuilder: (context, index) {
                  final employee = widget.employeeData[index];

                  // Paso 1: Imprime los datos recibidos para depuración
                  print('Empleado recibido: $employee');

                  final estadoRaw = employee['estado'];
                  final estado = (estadoRaw ?? '').toLowerCase();
                  final isActive =
                      estado == 'activo' || estado == 'active' || estado == '1';

                  // Paso 2: Obtén idPlanilla de forma robusta
                  final idPlanilla = employee.containsKey('id_planilla') &&
                          employee['id_planilla'] != null
                      ? employee['id_planilla'].toString()
                      : null;

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${employee['nombres'] ?? ''} ${employee['apellidos'] ?? ''}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text(employee['correo'] ?? '',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12)),
                                // Paso 2: Muestra el ID de planilla para depuración visual
                                Text('ID Planilla: ${idPlanilla ?? "Ninguna"}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.blueGrey)),
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
                              alignment: Alignment.center,
                              child: Text(
                                isActive ? 'activo' : 'inactivo',
                                style: TextStyle(
                                  color: isActive ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
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
                                loadingId == idPlanilla
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      )
                                    : IconButton(
                                        icon: const Icon(Icons.picture_as_pdf,
                                            size: 18, color: Colors.indigo),
                                        tooltip: 'Generar Planilla',
                                        onPressed: () async {
                                          // Paso 3: Verifica que el botón solo se activa si el
                                          // idPlanilla es válido y no está en uso
                                          if (idPlanilla != null &&
                                              idPlanilla.isNotEmpty) {
                                            setState(() {
                                              loadingId = idPlanilla;
                                            });
                                            try {
                                              final mensaje = await widget
                                                  .planillaService
                                                  .generarPlanillaPDF(
                                                      idPlanilla);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(mensaje)),
                                              );
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Error al generar el PDF')),
                                              );
                                            } finally {
                                              setState(() {
                                                loadingId = null;
                                              });
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'No hay planilla disponible')),
                                            );
                                          }
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (index != widget.employeeData.length - 1)
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
