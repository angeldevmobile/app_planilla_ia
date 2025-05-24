import 'package:flutter/material.dart';

import '../asistencia_screen_employee/components/calendary.dart';
import '../justificacion_screen_employee/components/welcome_justification.dart';
import 'components/form_field.dart';
import 'components/table_vacation.dart';

class VacacionesScreen extends StatelessWidget {
  const VacacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeJustification(userName: 'Diana'),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Calendario a la izquierda
                Container(
                  constraints: const BoxConstraints(maxWidth: 410),
                  child: const CalendarSectionAssistant(),
                ),
                const SizedBox(width: 32),
                const Expanded(
                  child: VacacionesForm(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: VacacionesTable(),
            ),
          ],
        ),
      ),
    );
  }
}
