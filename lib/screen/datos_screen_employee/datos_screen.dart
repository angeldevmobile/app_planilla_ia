import 'package:flutter/material.dart';

import '../home_employee_screen/widgets/welcome_dash/components/welcome_section.dart';
import 'components/inform_aditional.dart';
import 'components/inform_basic.dart';
import 'components/inform_contact.dart';
import 'components/login_details.dart';

class DatosScreen extends StatelessWidget {
  final String userName;
  const DatosScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
                      WelcomeSection(userName: userName),
                      const SizedBox(height: 20),
                      BasicInfoForm(),
                      const SizedBox(height: 20),
                      EmergencyContactCard(),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const SizedBox(height: 170),
                      LoginDetailsSection(),
                      const SizedBox(height: 20),
                      const AdditionalInfoCard(),
                    ],
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
