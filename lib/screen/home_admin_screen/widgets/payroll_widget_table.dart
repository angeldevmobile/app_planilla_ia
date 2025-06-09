import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecentPayrollTable extends StatefulWidget {
  const RecentPayrollTable({super.key});

  @override
  State<RecentPayrollTable> createState() => _RecentPayrollTableState();
}

class _RecentPayrollTableState extends State<RecentPayrollTable> {
  List<Map<String, dynamic>> payrolls = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPayrolls();
  }

  Future<void> fetchPayrolls() async {
    final response =
        await http.get(Uri.parse('http://localhost:8085/api/planillas'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        payrolls = data
            .map((item) => {
                  'period': '${item['periodo_mes']}/${item['periodo_anio']}',
                  'payment_date': item['fechaGeneracion'] ?? '',
                  'employees': 1, // Ajusta según los datos reales
                  'total': '\$${item['sueldoNeto'] ?? 0}',
                  'status': 'processed', // Ajusta según los datos reales
                })
            .toList();
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  Widget _statusBadge(String status) {
    Color color;
    Color bg;

    switch (status) {
      case 'processed':
        color = Colors.green.shade700;
        bg = Colors.green.shade100;
        break;
      case 'pending':
        color = Colors.orange.shade800;
        bg = Colors.orange.shade100;
        break;
      default:
        color = Colors.grey;
        bg = Colors.grey.shade200;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 400, 
      margin: const EdgeInsets.only(bottom: 8),
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
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Static headers
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                        child: Text('Periódo',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text('Fecha Pago',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text('Empleados',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text('Total',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text('Estado',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
                const Divider(),
                // Scrollable rows
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: payrolls.map((payroll) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Text(payroll['period'])),
                                Expanded(child: Text(payroll['payment_date'])),
                                Expanded(
                                    child:
                                        Text(payroll['employees'].toString())),
                                Expanded(child: Text(payroll['total'])),
                                Expanded(
                                    child: _statusBadge(payroll['status'])),
                              ],
                            ),
                            const SizedBox(height: 8), // Espaciado entre filas
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
