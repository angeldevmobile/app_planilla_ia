import 'package:flutter/material.dart';

import '../../../components/animated_table.dart';
class HistoryTable extends StatefulWidget {
  const HistoryTable({super.key});

  @override
  State<HistoryTable> createState() => _HistoryTableState();
}

class _HistoryTableState extends State<HistoryTable>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  final List<Map<String, String>> data = [
    {"no": "01", "tipo": "Justificación", "fecha": "13/05/2025", "archivo": "Sí", "estado": "Pendiente"},
    {"no": "02", "tipo": "Permiso", "fecha": "12/05/2025", "archivo": "Sí", "estado": "Aprobado"},
    {"no": "03", "tipo": "Justificación", "fecha": "10/03/2025", "archivo": "Sí", "estado": "Aprobado"},
    {"no": "04", "tipo": "ENERO", "fecha": "20/04/2025", "archivo": "Sí", "estado": "Rechazado"},
    {"no": "05", "tipo": "DICIEMBRE", "fecha": "15/10/2024", "archivo": "Sí", "estado": "Rechazado"},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0, 0.5, curve: Curves.easeInOut)),
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.3, 1, curve: Curves.easeOutBack)),
    );

    _controller.forward();
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
