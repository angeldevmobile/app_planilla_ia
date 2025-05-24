import 'package:flutter/material.dart';

import 'components/form_data.dart';
import 'components/table_history.dart';
import 'components/upload_document.dart';
import 'components/welcome_justification.dart';

class JustificacionScreen extends StatelessWidget {
  const JustificacionScreen({super.key});

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
                      WelcomeJustification(userName: 'Diana'),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          JustificationForm(),
                          const SizedBox(width: 90),
                          UploadDocument(),
                        ],
                      ),
                      HistoryTable(),
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
