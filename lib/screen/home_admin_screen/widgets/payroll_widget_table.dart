import 'package:flutter/material.dart';

class RecentPayrollTable extends StatelessWidget {
  RecentPayrollTable({super.key});

  final List<Map<String, dynamic>> payrolls = [
    {
      'period': 'March 16-31, 2024',
      'payment_date': 'Mar 30, 2024',
      'employees': 6,
      'total': '\$504,500',
      'status': 'processed',
    },
    {
      'period': 'March 16-31, 2024',
      'payment_date': 'Mar 30, 2024',
      'employees': 6,
      'total': '\$504,500',
      'status': 'processed',
    },
    {
      'period': 'March 16-31, 2024',
      'payment_date': 'Mar 30, 2024',
      'employees': 6,
      'total': '\$504,500',
      'status': 'processed',
    },
    {
      'period': 'March 16-31, 2024',
      'payment_date': 'Mar 30, 2024',
      'employees': 6,
      'total': '\$504,500',
      'status': 'pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width *
          0.95, // Ajustar el ancho al 95% del ancho de la pantalla
      margin:
          const EdgeInsets.only(bottom: 8), // Reducir el espacio entre tablas
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 24, // Aumentar el espacio entre columnas
          columns: const [
            DataColumn(label: Text('Periódo')),
            DataColumn(label: Text('Fecha Pago')),
            DataColumn(label: Text('Empleados')),
            DataColumn(label: Text('Total')),
            DataColumn(label: Text('Estado')),
          ],
          rows: payrolls.map((payroll) {
            return DataRow(cells: [
              DataCell(Text(payroll['period'])),
              DataCell(Text(payroll['payment_date'])),
              DataCell(Text(payroll['employees'].toString())),
              DataCell(Text(payroll['total'])),
              DataCell(
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: payroll['status'] == 'processed'
                        ? Colors.green[50]
                        : Colors.orange[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    payroll['status'],
                    style: TextStyle(
                      color: payroll['status'] == 'processed'
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
