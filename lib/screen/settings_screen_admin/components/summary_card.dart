import 'package:flutter/material.dart';

import '../../../api/admin_user_details.dart';
import '../../../api/permiso_service.dart';

class SummaryCard extends StatefulWidget {
  const SummaryCard({super.key});

  @override
  State<SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  late Future<List<Map<String, String>>> _futureEmployeeData;
  late Future<List<dynamic>> _futurePermisos;

  @override
  void initState() {
    super.initState();
    _futureEmployeeData = UserService().fetchUsuarios();
    _futurePermisos = PermisosService().fetchPermisos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([_futureEmployeeData, _futurePermisos]),
      builder: (context, snapshot) {
        int empleados = 0;
        int permisos = 0;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          empleados = 0;
          permisos = 0;
        } else if (snapshot.hasData) {
          empleados = (snapshot.data![0] as List).length;
          permisos = (snapshot.data![1] as List).length;
        }

        return Container(
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
          child: Wrap(
            spacing: 24,
            runSpacing: 16,
            children: [
              _SummaryItem('Médicos Activos', empleados.toString(),
                  Icons.medical_services),
              _SummaryItem(
                  'Permisos', permisos.toString(), Icons.perm_contact_cal),
              const _SummaryItem(
                  'Total especialidades', '12', Icons.medical_information),
              const _SummaryItem('Ingresos Hoy', '\$2,450', Icons.attach_money),
              const _SummaryItem(
                  'Asistencias', '8', Icons.supervised_user_circle),
              const _SummaryItem('Vacaciones', '5', Icons.beach_access),
            ],
          ),
        );
      },
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _SummaryItem(this.title, this.value, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F5FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF3366FF), size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E384D),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
