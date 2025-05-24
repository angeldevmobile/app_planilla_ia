import 'package:flutter/material.dart';

import 'components/bole_component.dart';
import 'components/table_boleta.dart';

class BoletasScreen extends StatelessWidget {
  const BoletasScreen({super.key});

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
                      BoleComponent(userName: 'Diana'),
                      const SizedBox(height: 20),
                      IssuedBoletasTable(),
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
