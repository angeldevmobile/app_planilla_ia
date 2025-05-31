import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PayrollTrendChart extends StatefulWidget {
  const PayrollTrendChart({super.key});

  @override
  State<PayrollTrendChart> createState() => _PayrollTrendChartState();
}

class _PayrollTrendChartState extends State<PayrollTrendChart> {
  final List<_PayrollData> _payrollData = [
    _PayrollData('Jan', 300),
    _PayrollData('Feb', 600),
    _PayrollData('Mar', 800),
    _PayrollData('Apr', 900),
    _PayrollData('May', 800),
    _PayrollData('Jun', 600),
    _PayrollData('Jul', 300),
  ];

  final List<String> _months = [
    'Ago',
    'Set',
    'Oct',
    'Nov',
    'Dic',
  ];
  int _nextIndex = 0;

  void _addNewMonthData() {
    if (_nextIndex < _months.length) {
      setState(() {
        _payrollData.add(
          _PayrollData(_months[_nextIndex], (300 + (_nextIndex * 100)) % 1000),
        );
        _nextIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha((0.1 * 255).toInt()),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SizedBox(
            height: 300, // Altura del gráfico
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 1000,
                interval: 100,
              ),
              enableAxisAnimation: true,
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<_PayrollData, String>>[
                ColumnSeries<_PayrollData, String>(
                  dataSource: _payrollData,
                  xValueMapper: (_PayrollData data, _) => data.month,
                  yValueMapper: (_PayrollData data, _) => data.amount,
                  name: 'Payroll',
                  color: Colors.blue,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  animationDuration: 800,
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _addNewMonthData,
          child: const Text('Agregar mes'),
        ),
      ],
    );
  }
}

class _PayrollData {
  final String month;
  final double amount;

  _PayrollData(this.month, this.amount);
}
