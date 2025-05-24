import 'package:flutter/material.dart';

class VacacionesTable extends StatefulWidget {
  const VacacionesTable({super.key});

  @override
  State<VacacionesTable> createState() => _VacacionesTableState();
}

class _VacacionesTableState extends State<VacacionesTable> {
  List<Map<String, String>> solicitudes = [
    {
      "no": "01",
      "inicio": "12/05/2025",
      "fin": "13/05/2025",
      "adjunto": "Sí",
      "estado": "Pendiente"
    },
    {
      "no": "02",
      "inicio": "12/05/2025",
      "fin": "12/05/2025",
      "adjunto": "Sí",
      "estado": "Aprobado"
    },
    {
      "no": "03",
      "inicio": "14/05/2025",
      "fin": "10/03/2025",
      "adjunto": "Sí",
      "estado": "Aprobado"
    },
    {
      "no": "04",
      "inicio": "15/05/2025",
      "fin": "20/04/2025",
      "adjunto": "Sí",
      "estado": "Rechazado"
    },
    {
      "no": "05",
      "inicio": "25/05/2025",
      "fin": "15/10/2024",
      "adjunto": "Sí",
      "estado": "Rechazado"
    },
  ];

  Color getEstadoColor(String estado) {
    switch (estado) {
      case 'Pendiente':
        return Colors.lightBlue.shade100;
      case 'Aprobado':
        return Colors.green.shade100;
      case 'Rechazado':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  Color getEstadoTextColor(String estado) {
    switch (estado) {
      case 'Pendiente':
        return Colors.blue;
      case 'Aprobado':
        return Colors.green;
      case 'Rechazado':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(top: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Historial de solicitudes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                // Calcula el ancho para cada columna (6 columnas)
                final columnWidth = (constraints.maxWidth - 32) / 6;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: DataTable(
                      headingRowColor: WidgetStateColor.resolveWith(
                          (states) => const Color(0xFFE6F3F9)),
                      columnSpacing: 0,
                      columns: [
                        DataColumn(
                          label: SizedBox(
                            width: columnWidth,
                            child: const Center(child: Text("No")),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: columnWidth,
                            child: const Center(child: Text("Fecha de Inicio")),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: columnWidth,
                            child: const Center(child: Text("Fecha de Fin")),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: columnWidth,
                            child:
                                const Center(child: Text("Adjunto conforme")),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: columnWidth,
                            child: const Center(child: Text("Estado")),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: columnWidth,
                            child: const Center(child: Text("Action")),
                          ),
                        ),
                      ],
                      rows: solicitudes.map((solicitud) {
                        final estado = solicitud["estado"]!;
                        return DataRow(cells: [
                          DataCell(SizedBox(
                              width: columnWidth,
                              child: Center(child: Text(solicitud["no"]!)))),
                          DataCell(SizedBox(
                              width: columnWidth,
                              child:
                                  Center(child: Text(solicitud["inicio"]!)))),
                          DataCell(SizedBox(
                              width: columnWidth,
                              child: Center(child: Text(solicitud["fin"]!)))),
                          DataCell(SizedBox(
                              width: columnWidth,
                              child:
                                  Center(child: Text(solicitud["adjunto"]!)))),
                          DataCell(SizedBox(
                            width: columnWidth,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: getEstadoColor(estado),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  estado,
                                  style: TextStyle(
                                    color: getEstadoTextColor(estado),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )),
                          DataCell(
                            SizedBox(
                              width: columnWidth,
                              child: Center(
                                child: _AnimatedIconButton(
                                  onPressed: () {
                                    // Acción al hacer clic
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Guardado solicitud ${solicitud["no"]}')),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedIconButton extends StatefulWidget {
  final VoidCallback onPressed;
  const _AnimatedIconButton({required this.onPressed});

  @override
  State<_AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<_AnimatedIconButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 0.85);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        child: const Icon(Icons.save, color: Colors.black87),
      ),
    );
  }
}
