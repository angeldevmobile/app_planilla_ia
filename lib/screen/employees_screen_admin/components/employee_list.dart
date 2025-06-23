import 'package:flutter/material.dart';
import '../../../api/planilla_service.dart';

class EmployeeList extends StatefulWidget {
  final List<Map<String, dynamic>> employeeData;
  final PlanillaService planillaService;

  const EmployeeList({
    super.key,
    required this.employeeData,
    required this.planillaService,
  });

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  late List<Map<String, dynamic>> employeeData; // Cambiado a dynamic

  @override
  void initState() {
    super.initState();
    employeeData = List.from(widget.employeeData);
  }

  void addEmployee(Map<String, dynamic> newEmployee) {
    // Cambiado a dynamic
    setState(() {
      employeeData.add(newEmployee);
    });
  }

  void removeEmployee(int index) {
    setState(() {
      employeeData.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: employeeData.length,
      itemBuilder: (context, index) {
        final employee = employeeData[index];
        final estadoRaw = employee['estado'];
        final estado = (estadoRaw ?? '').toString().toLowerCase();
        final isActive =
            estado == 'activo' || estado == 'active' || estado == '1';
        final idPlanilla = employee['id_planilla']?.toString();
        final idUsuario = employee['id_usuario']?.toString();

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Nombre, correo, id_usuario, id_planilla
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${employee['nombres'] ?? ''} ${employee['apellidos'] ?? ''}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        employee['correo'] ?? '',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        'ID Usuario: ${idUsuario ?? "No disponible"}',
                        style: const TextStyle(
                            fontSize: 12, color: Colors.deepPurple),
                      ),
                      Text(
                        'ID Planilla: ${idPlanilla ?? "Ninguna"}',
                        style: const TextStyle(
                            fontSize: 12, color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
                // Cargo
                Expanded(
                  flex: 2,
                  child: Text(employee['cargo'] ?? ''),
                ),
                // Rol
                Expanded(
                  flex: 2,
                  child: Text(employee['rol'] ?? ''),
                ),
                // Estado
                Expanded(
                  flex: 2,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isActive ? Colors.green[100] : Colors.red[100],
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
                // Acciones
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 18),
                      onPressed: () {
                        // implementar editar si lo necesitas
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 18),
                      onPressed: () {
                        removeEmployee(index);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.picture_as_pdf,
                          size: 18, color: Colors.indigo),
                      tooltip: 'Activar planilla para descarga',
                      onPressed: () async {
                        if (idPlanilla != null) {
                          try {
                            final mensaje = await widget.planillaService
                                .generarPlanillaPDF(idPlanilla);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(mensaje)),
                            );
                          } catch (e) {
                            print('Error al generar el PDF: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Error al generar el PDF')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('No se encontró una planilla activa')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
