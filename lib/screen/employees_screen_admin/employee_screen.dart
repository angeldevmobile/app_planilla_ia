import 'package:flutter/material.dart';

import 'components/employee_data.dart';
import 'components/employee_list.dart';
import 'components/employee_table.dart';
import 'components/employee_top_app_bar.dart';

class EmployeeDirectory extends StatefulWidget {
  const EmployeeDirectory({super.key});

  @override
  State<EmployeeDirectory> createState() => _EmployeeDirectoryState();
}

class _EmployeeDirectoryState extends State<EmployeeDirectory> {
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EmployeeTopAppBar(
                searchFocusNode: _searchFocusNode,
                isSearchFocused: _isSearchFocused,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.person_add),
                    label: const Text('Agregar Empleado'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Total empleados',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tu empresa tiene ${employeeData.length} empleados registrados en la compañía.',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 800) {
                    return EmployeeList(initialEmployeeData: employeeData);
                  } else {
                    return EmployeeTable(employeeData: employeeData);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
