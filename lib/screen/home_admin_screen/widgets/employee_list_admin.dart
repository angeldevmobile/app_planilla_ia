import 'package:flutter/material.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            ),
          ),
          _buildEmployeeTile('Alicia Wang', 'Médico', 'alicia@pyroll.com'),
          const Divider(height: 1),
          _buildEmployeeTile('David Lee', 'Enfermero', 'david@pyroll.com'),
          const Divider(height: 1),
          _buildEmployeeTile('Emily', 'Enfermera', 'emily@pyroll.com'),
          const Divider(height: 1),
          _buildEmployeeTile('Michael', 'Gerente', 'michael@pyroll.com'),
        ],
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
