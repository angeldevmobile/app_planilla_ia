import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PayrollTableCard extends StatefulWidget {
  const PayrollTableCard({super.key});

  @override
  State<PayrollTableCard> createState() => _PayrollTableCardState();
}

class _PayrollTableCardState extends State<PayrollTableCard> {
  DateTime _selectedDay = DateTime.now();
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
                  'date': item['fechaGeneracion'] ?? '',
                  'employees': 1, 
                  'total': '\$${item['sueldoNeto'] ?? 0}',
                  'status': 'processed', 
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

  void _openCalendarDialog() {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Card(
          elevation: 8,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 320, // Ajusta el tamaño a tu gusto
              height: 340,
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _selectedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            const Expanded(
              child: Text(
                "Historial de Pagos",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _openCalendarDialog,
              icon: const Icon(Icons.calendar_today),
              label: const Text(
                "Filtrar por fecha",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Visuzaliza la nómina de pagos de tus empleados",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 16),

        /// TABLA SCROLLEABLE HORIZONTAL
        LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: DataTable(
                      columnSpacing: 32,
                      headingRowColor:
                          WidgetStateProperty.all(Colors.grey.shade100),
                      columns: const [
                        DataColumn(label: Text("PERIODO DE PAGO")),
                        DataColumn(label: Text("FECHA DE PAGO")),
                        DataColumn(label: Text("EMPLEADOS")),
                        DataColumn(label: Text("TOTAL")),
                        DataColumn(label: Text("ESTADO")),
                      ],
                      rows: payrolls.map((row) {
                        return DataRow(cells: [
                          DataCell(Text(row['period'])),
                          DataCell(Text(row['date'])),
                          DataCell(Text(row['employees'].toString())),
                          DataCell(Text(row['total'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold))),
                          DataCell(_statusBadge(row['status'])),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
