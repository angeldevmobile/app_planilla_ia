import 'package:flutter/material.dart';

import '../../../models/worklog.dart';

class WorkLogScreen extends StatefulWidget {
  const WorkLogScreen({super.key});

  @override
  WorkLogScreenState createState() => WorkLogScreenState();
}

class WorkLogScreenState extends State<WorkLogScreen> {
  List<WorkLog> workLogs = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F3FA),
      appBar: AppBar(title: Text('Historial de Asistencia')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: WorkLogCard(workLogs: workLogs),
      ),
    );
  }
}

class WorkLogCard extends StatelessWidget {
  final List<WorkLog> workLogs;

  const WorkLogCard({
    super.key,
    required this.workLogs,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Color(0xFFF8F9FB),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Color(0xFFD1C4E9), // Borde más visible
          width: 1.2,
        ),
      ),
      margin: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF8F9FB),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0x22000000), // Más opaco
              blurRadius: 16, // Más difuso
              offset: Offset(0, 8), // Más abajo
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: workLogs.length,
          itemBuilder: (context, index) {
            final log = workLogs[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Fecha e ícono arriba
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 16, color: Colors.deepPurple),
                        SizedBox(width: 8),
                        Text(
                          log.date,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Datos de horas y entrada/salida
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Total de horas
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Hours',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 13)),
                            SizedBox(height: 4),
                            Text(log.totalHours,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        // Clock in & out
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Clock in & Out',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 13)),
                            SizedBox(height: 4),
                            Text('${log.clockIn} — ${log.clockOut}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500)),
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
