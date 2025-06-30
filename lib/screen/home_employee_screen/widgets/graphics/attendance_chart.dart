import 'package:flutter/material.dart';

import 'components/attendance_bar_chart.dart';

class AttendanceChartCard extends StatefulWidget {
  final int idUsuario;

  const AttendanceChartCard({super.key, required this.idUsuario});

  @override
  State<AttendanceChartCard> createState() => _AttendanceChartCardState();
}

class _AttendanceChartCardState extends State<AttendanceChartCard> {
  String? selectedYear;
  final List<String> years = ['2022', '2023', '2024', '2025'];

  @override
  void initState() {
    super.initState();
    selectedYear = DateTime.now().year.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Registro de Asistencias',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        child: DropdownButton<String>(
                          value: selectedYear,
                          hint: const Text('Año'),
                          items: years
                              .map((year) => DropdownMenuItem(
                                    value: year,
                                    child: Text(year),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedYear = value;
                            });
                          },
                          underline: const SizedBox(),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black87),
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AttendanceChart(
                  idUsuario: widget.idUsuario,
                  selectedYear: selectedYear ?? DateTime.now().year.toString(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
