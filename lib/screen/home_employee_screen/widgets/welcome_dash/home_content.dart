import 'package:flutter/material.dart';

import '../../screens_employee/boletas_screen.dart';
import '../circle_graphics/circle_graphics_chart.dart';
import '../graphics/attendance_chart.dart';
import 'components/calendar_section.dart';
import 'components/stats_grid.dart';
import 'components/welcome_section.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key, required String userName});

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
                      WelcomeSection(userName: 'Diana'),
                      AttendanceStatsGrid(),
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
                  child: AttendanceChartCard(),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: CircleGraphics(
                    justifiedAbsences: 5,
                    unjustifiedAbsences: 3,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: BoletasScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
