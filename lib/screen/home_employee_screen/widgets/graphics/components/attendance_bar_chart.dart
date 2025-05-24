import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AttendanceChart extends StatefulWidget {
  final String? year;
  const AttendanceChart({super.key, this.year});

  @override
  State<AttendanceChart> createState() => _AttendanceChartState();
}

class _AttendanceChartState extends State<AttendanceChart> {
  List<Color> gradientColors = [
    Colors.blue,
    Colors.cyan,
  ];

  final Map<String, List<FlSpot>> yearData = {
    '2022': [
      FlSpot(0, 8),
      FlSpot(1, 12),
      FlSpot(2, 10),
      FlSpot(3, 15),
      FlSpot(4, 13),
      FlSpot(5, 18),
      FlSpot(6, 14),
    ],
    '2023': [
      FlSpot(0, 12),
      FlSpot(1, 18),
      FlSpot(2, 14),
      FlSpot(3, 20),
      FlSpot(4, 16),
      FlSpot(5, 22),
      FlSpot(6, 19),
    ],
    '2024': [
      FlSpot(0, 15),
      FlSpot(1, 19),
      FlSpot(2, 17),
      FlSpot(3, 23),
      FlSpot(4, 20),
      FlSpot(5, 25),
      FlSpot(6, 21),
    ],
    '2025': [
      FlSpot(0, 18),
      FlSpot(1, 22),
      FlSpot(2, 20),
      FlSpot(3, 26),
      FlSpot(4, 23),
      FlSpot(5, 28),
      FlSpot(6, 24),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: LineChart(mainData()),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Ene';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Abr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(text, style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 5:
        text = '5';
        break;
      case 10:
        text = '10';
        break;
      case 15:
        text = '15';
        break;
      case 20:
        text = '20';
        break;
      case 25:
        text = '25';
        break;
      case 30:
        text = '30';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    // Usa el año seleccionado, si no hay, muestra 2025 por defecto
    final spots = yearData[widget.year] ?? yearData['2025']!;
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 5,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.grey,
            strokeWidth: 0.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.grey,
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) => bottomTitleWidgets(value, meta),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 5,
            getTitlesWidget: (value, meta) => leftTitleWidgets(value, meta),
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: Colors.grey.withAlpha(77),
        ),
      ),
      minX: 0,
      maxX: 7,
      minY: 0,
      maxY: 30,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors:
                  gradientColors.map((color) => color.withAlpha(51)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
