import 'package:flutter/material.dart';

class EmployeeList extends StatefulWidget {
  final List<Map<String, String>> initialEmployeeData;
  const EmployeeList({super.key, required this.initialEmployeeData});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  late List<Map<String, String>> employeeData;

  @override
  void initState() {
    super.initState();
    employeeData = List.from(widget.initialEmployeeData); // Copia segura
  }

  void addEmployee(Map<String, String> newEmployee) {
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
        final estado = (estadoRaw ?? '').toLowerCase();
        final isActive = estado == 'activo' || estado == 'active';

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Nombre y correo
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
                    alignment:
                        Alignment.center, 
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
