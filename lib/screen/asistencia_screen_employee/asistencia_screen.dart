import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'components/calendary.dart';
import 'components/registry_time_work.dart';
import 'components/welcome_asistant.dart';
import 'components/table_input_output.dart';
import '../../../models/worklog.dart';
import '../../../api/asistencia_service.dart';
import '../../../models/user_model.dart';

class AsistenciaScreen extends StatefulWidget {
  final UserModel user;
  const AsistenciaScreen({super.key, required this.user});

  @override
  State<AsistenciaScreen> createState() => _AsistenciaScreenState();
}

class _AsistenciaScreenState extends State<AsistenciaScreen> {
  List<WorkLog> workLogs = [];

  @override
  void initState() {
    super.initState();
    cargarAsistencias();
  }

  Future<void> cargarAsistencias() async {
    final asistencias = await AsistenciaService()
        .obtenerAsistenciasUsuario(widget.user.id_usuario);

    setState(() {
      workLogs = asistencias.map((asistencia) {
        final entrada = asistencia.hora_entrada;
        final salida = asistencia.hora_salida ?? '--:--';
        final horasTotales = calcularHoras(entrada, salida);

        return WorkLog(
          date: DateFormat('dd MMMM yyyy', 'es_ES')
              .format(DateTime.parse(asistencia.fecha)),
          totalHours: horasTotales,
          clockIn: DateFormat('hh:mm a')
              .format(DateFormat('HH:mm:ss').parse(entrada)),
          clockOut: salida == '--:--'
              ? '--:--'
              : DateFormat('hh:mm a')
                  .format(DateFormat('HH:mm:ss').parse(salida)),
        );
      }).toList();
    });
  }

  String calcularHoras(String entrada, String salida) {
    if (salida == '--:--') return '--:--:-- hrs';

    final start = DateFormat('HH:mm:ss').parse(entrada);
    final end = DateFormat('HH:mm:ss').parse(salida);
    final duration = end.difference(start);
    return '${duration.toString().split('.').first} hrs';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WelcomeAsistant(userName: widget.user.nombres),
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
                Expanded(
                  flex: 3,
                  child: WorkHoursPage(user: widget.user),
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
