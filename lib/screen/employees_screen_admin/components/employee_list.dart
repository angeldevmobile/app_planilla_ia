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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 1200),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: employeeData.length,
          itemBuilder: (context, index) {
            final employee = employeeData[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(employee['name']!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(employee['email']!,
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('Position: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(employee['position']!),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text('Department: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(employee['department']!),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text('Salary: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(employee['salary']!),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
