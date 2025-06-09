import 'package:flutter/material.dart';

import 'components/form_data.dart';
import 'components/table_history.dart';
import 'components/upload_document.dart';
import 'components/welcome_justification.dart';
import '../../../../models/user_model.dart';

class JustificacionScreen extends StatelessWidget {
  final UserModel user;
  const JustificacionScreen({super.key, required this.user});

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
                      WelcomeJustification(userName: user.nombres),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          JustificationForm(user: user),
                          const SizedBox(width: 90),
                          UploadDocument(),
                        ],
                      ),
                      HistoryTable(user: user),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
