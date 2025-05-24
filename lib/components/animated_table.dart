import 'package:flutter/material.dart';
import 'row_utils.dart';

class AnimatedTable extends StatelessWidget {
  final List<Map<String, String>> data;
  const AnimatedTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 12,
            spreadRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1)),
              ),
              child: Text(
                "Historial de solicitudes",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade800,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder(
                  horizontalInside: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                  4: FlexColumnWidth(1),
                  5: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey.shade50),
                    children: [
                      buildHeader("No"),
                      buildHeader("Tipo"),
                      buildHeader("Fecha"),
                      buildHeader("Archivo"),
                      buildHeader("Estado"),
                      buildHeader("Acción"),
                    ],
                  ),
                  for (var i = 0; i < data.length; i++) buildRow(data[i], i),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
