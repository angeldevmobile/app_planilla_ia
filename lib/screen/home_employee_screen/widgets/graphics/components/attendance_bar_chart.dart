import 'package:app_planilla_ia/models/asistencia_mensual_model.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:app_planilla_ia/api/api_service.dart';

class AttendanceChart extends StatefulWidget {
  final int idUsuario;
  final String selectedYear;

  const AttendanceChart({
    super.key,
    required this.idUsuario,
    required this.selectedYear,
  });

  @override
  State<AttendanceChart> createState() => _AttendanceChartState();
}

class _AttendanceChartState extends State<AttendanceChart> {
  late Future<List<AsistenciaMensual>> futureAsistencias;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void didUpdateWidget(covariant AttendanceChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedYear != widget.selectedYear) {
      _fetchData();
    }
  }

  void _fetchData() {
    setState(() {
      futureAsistencias = ApiService().fetchAsistenciaMensual(widget.idUsuario);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AsistenciaMensual>>(
      future: futureAsistencias,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No hay datos disponibles.');
        }

        final List<AsistenciaMensual> data = snapshot.data!;
        final yearFiltered = int.parse(widget.selectedYear);
        final filtered = data.where((e) => e.anio == yearFiltered).toList();

        return SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: filtered.map((e) {
                return BarChartGroupData(
                  x: e.mes,
                  barRods: [
                    BarChartRodData(
                      toY: e.totalAsistencias.toDouble(),
                      width: 20,
                      borderRadius: BorderRadius.circular(4),
                    )
                  ],
                );
              }).toList(),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const meses = [
                        '',
                        'Ene',
                        'Feb',
                        'Mar',
                        'Abr',
                        'May',
                        'Jun',
                        'Jul',
                        'Ago',
                        'Sep',
                        'Oct',
                        'Nov',
                        'Dic'
                      ];
                      return Text(meses[value.toInt()]);
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
