import 'package:app_planilla_ia/api/api_service.dart';
import 'package:app_planilla_ia/models/asistencia_dashboard_model.dart';
import 'package:flutter/material.dart';

class AttendanceStatsGrid extends StatefulWidget {
  final int idUsuario;

  const AttendanceStatsGrid({super.key, required this.idUsuario});

  @override
  _AttendanceStatsGridState createState() => _AttendanceStatsGridState();
}

class _AttendanceStatsGridState extends State<AttendanceStatsGrid> {
  late Future<DashboardStats> futureStats;

  @override
  void initState() {
    super.initState();
    futureStats = ApiService().fetchDashboardStats(widget.idUsuario);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DashboardStats>(
      future: futureStats,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final stats = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        value: stats.porcentajeAsistencia,
                        label: 'Asistencia del mes pasado',
                        icon: Icons.calendar_today,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        value: stats.vacaciones.toString(),
                        label: 'Vacaciones registradas',
                        icon: Icons.beach_access,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        value: stats.ausencias.toString(),
                        label: 'Ausencias Registradas',
                        icon: Icons.warning,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        value: stats.asistencias.toString(),
                        label: 'Asistencias Registradas',
                        icon: Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          debugPrint('Error detallado: ${snapshot.error}');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(height: 8),
                Text('Error al cargar estadísticas'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: color)),
                  const SizedBox(height: 5),
                  Text(label,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
