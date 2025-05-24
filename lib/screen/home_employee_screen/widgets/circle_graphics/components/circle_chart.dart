import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AbsenceDonutChart extends StatelessWidget {
  final int justified;
  final int unjustified;
  final Color justifiedColor;
  final Color unjustifiedColor;

  const AbsenceDonutChart({
    super.key,
    required this.justified,
    required this.unjustified,
    this.justifiedColor = const Color(0xFF4CAF50),
    this.unjustifiedColor = const Color(0xFFF44336),
  });

  @override
  Widget build(BuildContext context) {
    final total = justified + unjustified;
    final unjustifiedPercentage =
        total > 0 ? (unjustified / total * 100).round() : 0;
    final justifiedPercentage = total > 0 ? 100 - unjustifiedPercentage : 0;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(left: 0, right: 32, top: 8, bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Distribución de ausencias',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Gráfico de NO justificadas con valor debajo
                _buildSingleDonut(
                  context: context,
                  percentage: unjustifiedPercentage,
                  color: unjustifiedColor,
                  label: 'No Justificadas',
                  count: unjustified, 
                ),
                // Gráfico de justificadas con valor debajo
                _buildSingleDonut(
                  context: context,
                  percentage: justifiedPercentage,
                  color: justifiedColor,
                  label: 'Justificadas',
                  count: justified, 
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleDonut({
    required BuildContext context,
    required int percentage,
    required Color color,
    required String label,
    required int count, 
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 130,
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SfCircularChart(
                margin: EdgeInsets.zero,
                series: <CircularSeries>[
                  DoughnutSeries<AbsenceData, String>(
                    dataSource: [
                      AbsenceData(label, percentage, color),
                      AbsenceData(
                          'Resto', 100 - percentage, Colors.grey.shade200),
                    ],
                    xValueMapper: (AbsenceData data, _) => data.type,
                    yValueMapper: (AbsenceData data, _) => data.count,
                    pointColorMapper: (AbsenceData data, _) => data.color,
                    radius: '100%',
                    innerRadius: '75%',
                    dataLabelSettings:
                        const DataLabelSettings(isVisible: false),
                  ),
                ],
              ),
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$count',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}

class AbsenceData {
  final String type;
  final int count;
  final Color color;

  AbsenceData(this.type, this.count, this.color);
}
