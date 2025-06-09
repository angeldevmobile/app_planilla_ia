import 'package:flutter/material.dart';

import '../../../api/admin_user_details.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List<Map<String, String>> empleados = [];
  List<Map<String, String>> empleadosFiltrados = [];
  String searchText = '';
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadEmpleados();
  }

  Future<void> _loadEmpleados() async {
    try {
      final data = await UserService().fetchUsuarios();
      setState(() {
        empleados = data;
        empleadosFiltrados = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  void _filterEmpleados(String value) {
    setState(() {
      searchText = value.toLowerCase();
      empleadosFiltrados = empleados.where((emp) {
        final nombre =
            '${emp['nombres'] ?? ''} ${emp['apellidos'] ?? ''}'.toLowerCase();
        final cargo = (emp['cargo'] ?? '').toLowerCase();
        final correo = (emp['correo'] ?? '').toLowerCase();
        return nombre.contains(searchText) ||
            cargo.contains(searchText) ||
            correo.contains(searchText);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (error != null) {
      return Center(child: Text('Error: $error'));
    }
    return SizedBox(
      height: 400, // <-- Alto fijo como en tu ejemplo anterior
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha((0.1 * 255).toInt()),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search employees....',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                onChanged: _filterEmpleados,
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.separated(
                itemCount: empleadosFiltrados.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final emp = empleadosFiltrados[index];
                  return _buildEmployeeTile(
                    '${emp['nombres'] ?? ''} ${emp['apellidos'] ?? ''}',
                    emp['cargo'] ?? '',
                    emp['correo'] ?? '',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeTile(String name, String role, String email) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            role,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
      subtitle: Text(email),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {},
      ),
    );
  }
}
