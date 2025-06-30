import 'package:app_planilla_ia/api/api_service.dart';
import 'package:flutter/material.dart';

import '../../screens_employee/boletas_screen.dart';
import '../circle_graphics/circle_graphics_chart.dart';
import '../graphics/attendance_chart.dart';
import 'components/calendar_section.dart';
import 'components/stats_grid.dart';
import 'components/welcome_section.dart';
import '../../../../models/user_model.dart';

class HomeContent extends StatelessWidget {
  final UserModel user;
  const HomeContent({super.key, required this.user});

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
                    children: [
                      WelcomeSection(userName: user.nombres),
                      AttendanceStatsGrid(idUsuario: user.id_usuario),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: CalendarSection(),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: AttendanceChartCard(idUsuario: user.id_usuario),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: FutureBuilder<Map<String, int>>(
                    future: ApiService().fetchAusenciasPie(user.id_usuario),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CircleGraphics(
                          justifiedAbsences: snapshot.data!['justificadas']!,
                          unjustifiedAbsences:
                              snapshot.data!['noJustificadas']!,
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error al cargar gráfico');
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: BoletasScreen(user: user),
            ),
          ],
        ),
      ),
    );
  }
}
