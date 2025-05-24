import 'package:flutter/material.dart';
import '../../../../models/boleta_model.dart';

class BoletasTable extends StatelessWidget {
  final List<Boleta> boletas;
  final Function(Boleta) onBoletaUpdated;

  const BoletasTable({
    super.key,
    required this.boletas,
    required this.onBoletaUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: const EdgeInsets.only(top: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: DataTable(
                  columnSpacing: 20,
                  dataRowMinHeight: 50,
                  dataRowMaxHeight: 70,
                  headingRowHeight: 60,
                  columns: const [
                    DataColumn(
                        label: Text('No',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('MES',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('AÑO',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Fecha de pago',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Estado',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Acción',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: boletas.map((boleta) {
                    return DataRow(
                      cells: [
                        DataCell(Text(boleta.no)),
                        DataCell(Text(boleta.mes)),
                        DataCell(Text(boleta.ano)),
                        DataCell(Text(boleta.fechaPago)),
                        DataCell(
                          Container(
                            decoration: BoxDecoration(
                              color: boleta.estado == 'Pendiente'
                                  ? Colors.blue.shade100
                                  : Colors.green.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: Text(
                              boleta.estado,
                              style: TextStyle(
                                color: boleta.estado == 'Pendiente'
                                    ? Colors.blue
                                    : Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.print, color: Colors.black),
                            onPressed: () {
                              final updatedBoleta = boleta.copyWith(
                                completado: !boleta.completado,
                                estado: !boleta.completado
                                    ? 'Completado'
                                    : 'Pendiente',
                              );
                              onBoletaUpdated(updatedBoleta);
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
