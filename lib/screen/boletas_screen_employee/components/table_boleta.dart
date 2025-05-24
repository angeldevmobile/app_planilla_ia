import 'package:flutter/material.dart';

class IssuedBoletasTable extends StatefulWidget {
  const IssuedBoletasTable({super.key});

  @override
  State<IssuedBoletasTable> createState() => _IssuedBoletasTableState();
}

class _IssuedBoletasTableState extends State<IssuedBoletasTable> with TickerProviderStateMixin {
  final List<Map<String, String>> _boletas = [
    {
      "no": "01",
      "mes": "ABRIL",
      "año": "2025",
      "fecha": "12 May 2024",
      "estado": "Pendiente"
    },
    {
      "no": "02",
      "mes": "MARZO",
      "año": "2025",
      "fecha": "12 May 2024",
      "estado": "Completado"
    },
    {
      "no": "03",
      "mes": "FEBRERO",
      "año": "2025",
      "fecha": "12 May 2024",
      "estado": "Completado"
    },
    {
      "no": "04",
      "mes": "ENERO",
      "año": "2025",
      "fecha": "12 May 2024",
      "estado": "Completado"
    },
    {
      "no": "05",
      "mes": "DICIEMBRE",
      "año": "2024",
      "fecha": "12 May 2024",
      "estado": "Completado"
    },
  ];

  Color _estadoColor(String estado) {
    switch (estado) {
      case "Completado":
        return Colors.greenAccent.shade100;
      case "Pendiente":
        return Colors.blue.shade100;
      default:
        return Colors.grey.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Boletas Emitidas",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildHeader(),
                  const Divider(height: 1),
                  ..._boletas.map((boleta) => _buildRow(boleta))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.lightBlue.shade50,
      child: Row(
        children: const [
          _HeaderCell("No", flex: 1),
          _HeaderCell("MES", flex: 2),
          _HeaderCell("AÑO", flex: 2),
          _HeaderCell("Fecha de pago", flex: 3),
          _HeaderCell("Estado", flex: 2),
          _HeaderCell("Action", flex: 1),
        ],
      ),
    );
  }

  Widget _buildRow(Map<String, String> boleta) {
    return InkWell(
      onTap: () {
        // Aquí puedes agregar una acción futura
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Seleccionaste el mes ${boleta["mes"]}"),
          duration: const Duration(seconds: 1),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Row(
          children: [
            _DataCell(boleta["no"]!, flex: 1),
            _DataCell(boleta["mes"]!, flex: 2),
            _DataCell(boleta["año"]!, flex: 2),
            _DataCell(boleta["fecha"]!, flex: 3),
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _estadoColor(boleta["estado"]!),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    boleta["estado"]!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: boleta["estado"] == "Pendiente" ? Colors.blue : Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Descargando boleta de ${boleta["mes"]}..."),
                      duration: const Duration(seconds: 1),
                    ));
                  },
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 150),
                    scale: 1.0,
                    child: const Icon(Icons.download_rounded),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widgets reutilizables para claridad
class _HeaderCell extends StatelessWidget {
  final String text;
  final int flex;
  const _HeaderCell(this.text, {required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;
  final int flex;
  const _DataCell(this.text, {required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(text, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
