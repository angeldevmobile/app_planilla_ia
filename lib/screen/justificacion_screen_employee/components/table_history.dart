import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../components/animated_table.dart';

import '../../../models/user_model.dart';
import '../../../api/ausencia_service.dart';

class HistoryTable extends StatefulWidget {
  final UserModel user;
  const HistoryTable({super.key, required this.user});

  @override
  State<HistoryTable> createState() => _HistoryTableState();
}

class _HistoryTableState extends State<HistoryTable>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  List<Map<String, String>> data = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0, 0.5, curve: Curves.easeInOut)),
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.3, 1, curve: Curves.easeOutBack)),
    );

    _controller.forward();

    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    try {
      final ausencias = await AusenciaService()
          .obtenerAusenciasPorUsuario(widget.user.id_usuario);

      setState(() {
        data = ausencias.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final ausencia = entry.value;
          final tieneDocumento = (ausencia.documentoRespaldo != null &&
              ausencia.documentoRespaldo!.isNotEmpty);

          return {
            "no": index.toString().padLeft(2, '0'),
            "tipo": "Justificación",
            "fecha":
                DateFormat('dd/MM/yyyy').format(DateTime.parse(ausencia.fecha)),
            "archivo": tieneDocumento ? "Sí" : "No",
            "estado": ausencia.justificada ? "Completado" : "Pendiente",
            "documento": ausencia.documentoRespaldo ?? "",
          };
        }).toList();
      });
    } catch (e) {
      print('❌ Error al cargar ausencias: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: AnimatedTable(data: data),
      ),
    );
  }
}
