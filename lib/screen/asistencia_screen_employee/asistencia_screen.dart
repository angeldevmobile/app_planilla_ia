import 'package:flutter/material.dart';

import 'components/calendary.dart';
import 'components/registry_time_work.dart';
import 'components/welcome_asistant.dart';
import 'components/table_input_output.dart';
import '../../../models/worklog.dart';

class AsistenciaScreen extends StatelessWidget {
  const AsistenciaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de workLogs para la tabla
    final List<WorkLog> workLogs = [
      WorkLog(
          date: '18 Setiembre 2025',
          totalHours: '08:00:00 hrs',
          clockIn: '09:00 AM',
          clockOut: '06:00 PM'),
      WorkLog(
          date: '17 Setiembre 2025',
          totalHours: '08:00:00 hrs',
          clockIn: '09:00 AM',
          clockOut: '06:00 PM'),
      WorkLog(
          date: '15 Setiembre 2025',
          totalHours: '08:00:00 hrs',
          clockIn: '09:00 AM',
          clockOut: '06:00 PM'),
      WorkLog(
          date: '14 Setiembre 2025',
          totalHours: '08:00:00 hrs',
          clockIn: '09:00 AM',
          clockOut: '06:00 PM'),
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Columna izquierda: bienvenida + calendario
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WelcomeAsistant(userName: 'Diana'),
                      const SizedBox(height: 20),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 410),
                        child: CalendarSectionAssistant(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(width: 24),

                /// Columna derecha: registro de horas
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      WorkHoursPage(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32), 
            WorkLogCard(workLogs: workLogs), 
          ],
        ),
      ),
    );
  }
}
