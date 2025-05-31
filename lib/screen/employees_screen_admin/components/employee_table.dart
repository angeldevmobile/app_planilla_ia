import 'package:flutter/material.dart';

class EmployeeTable extends StatelessWidget {
  final List<Map<String, String>> employeeData;
  const EmployeeTable({super.key, required this.employeeData});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: screenWidth < 1200 ? 600 : 1200,
            ),
            child: DataTable(
              columnSpacing: 40,
              horizontalMargin: 24,
              columns: const [
                DataColumn(
                    label: Text('NOMBRES',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('ROL',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('DEPARTMENTO',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('SALARIO',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('ESTADO',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('ACCIONES',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: employeeData.map((employee) {
                return DataRow(cells: [
                  DataCell(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(employee['name']!,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(employee['email']!,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 12)),
                    ],
                  )),
                  DataCell(Text(employee['position']!)),
                  DataCell(Text(employee['department']!)),
                  DataCell(Text(employee['salary']!)),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: employee['status'] == 'activo'
                            ? Colors.green.withAlpha((0.2).toInt())
                            : Colors.red.withAlpha((0.2).toInt()),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        employee['status']!,
                        style: TextStyle(
                          color: employee['status'] == 'activo'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, size: 18),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, size: 18),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ]);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
