import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/user_model.dart';
import '../../../api/vacacion_service.dart';
import '../../../models/vacacion_model.dart';

class TableVacation extends StatefulWidget {
  final UserModel user;
  const TableVacation({super.key, required this.user});

  @override
  State<TableVacation> createState() => _TableVacationState();
}

class _TableVacationState extends State<TableVacation> {
  List<VacacionModel> vacaciones = [];

  @override
  void initState() {
    super.initState();
    _cargarVacaciones();
  }

  Future<void> _cargarVacaciones() async {
    final resultado = await VacacionService()
        .obtenerVacacionesPorUsuario(widget.user.id_usuario);
    setState(() {
      vacaciones = resultado;
    });
  }

  Color getEstadoColor(String estado) {
    switch (estado) {
      case 'Pendiente':
        return Colors.orange.shade100;
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
        return Colors.orange;
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
                                child: const Center(child: Text("No")))),
                        DataColumn(
                            label: SizedBox(
                                width: columnWidth,
                                child: const Center(
                                    child: Text("Fecha de Inicio")))),
                        DataColumn(
                            label: SizedBox(
                                width: columnWidth,
                                child:
                                    const Center(child: Text("Fecha de Fin")))),
                        DataColumn(
                            label: SizedBox(
                                width: columnWidth,
                                child: const Center(
                                    child: Text("Adjunto conforme")))),
                        DataColumn(
                            label: SizedBox(
                                width: columnWidth,
                                child: const Center(child: Text("Estado")))),
                        DataColumn(
                            label: SizedBox(
                                width: columnWidth,
                                child: const Center(child: Text("Action")))),
                      ],
                      rows: vacaciones.asMap().entries.map((entry) {
                        final index = entry.key + 1;
                        final vacacion = entry.value;
                        return DataRow(cells: [
                          DataCell(SizedBox(
                              width: columnWidth,
                              child: Center(
                                  child:
                                      Text(index.toString().padLeft(2, '0'))))),
                          DataCell(SizedBox(
                            width: columnWidth,
                            child: Text(
                              DateFormat('dd/MM/yyyy').format(
                                DateFormat('yyyy-MM-dd')
                                    .parse(vacacion.fechaInicio),
                              ),
                            ),
                          )),
                          DataCell(SizedBox(
                            width: columnWidth,
                            child: Text(
                              DateFormat('dd/MM/yyyy').format(
                                DateFormat('yyyy-MM-dd')
                                    .parse(vacacion.fechaFin),
                              ),
                            ),
                          )),
                          DataCell(SizedBox(
                              width: columnWidth,
                              child: Center(
                                  child: Text(
                                      (vacacion.documentoRespaldo?.isNotEmpty ??
                                              false)
                                          ? "Sí"
                                          : "No")))),
                          DataCell(SizedBox(
                            width: columnWidth,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: getEstadoColor(
                                      vacacion.aprobado ?? 'Pendiente'),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  vacacion.aprobado ?? 'Pendiente',
                                  style: TextStyle(
                                    color: getEstadoTextColor(
                                        vacacion.aprobado ?? 'Pendiente'),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )),
                          DataCell(SizedBox(
                            width: columnWidth,
                            child: Center(
                              child: _AnimatedIconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Guardado solicitud $index')),
                                  );
                                },
                              ),
                            ),
                          )),
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

  void _onTapDown(TapDownDetails details) => setState(() => _scale = 0.85);
  void _onTapUp(TapUpDetails details) => setState(() => _scale = 1.0);
  void _onTapCancel() => setState(() => _scale = 1.0);

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
