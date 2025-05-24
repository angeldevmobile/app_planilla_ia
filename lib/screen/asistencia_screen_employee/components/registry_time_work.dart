import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkHoursPage extends StatefulWidget {
  const WorkHoursPage({super.key});

  @override
  _WorkHoursPageState createState() => _WorkHoursPageState();
}

class _WorkHoursPageState extends State<WorkHoursPage> {
  String ingreso = "00:00";
  String salida = "00:00";

  void _registrarHoraIngreso() {
    final now = TimeOfDay.now();
    setState(() {
      ingreso = now.format(context);
    });
  }

  void _registrarHoraSalida() {
    final now = TimeOfDay.now();
    setState(() {
      salida = now.format(context);
    });
  }

  Widget _buildHoraCard(String titulo, String hora, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (titulo == "Hora de Ingreso")
            const Text(
              "Horas de trabajo",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          Text(
            "Fecha : ${DateFormat('dd/MM/yyyy').format(DateTime.now())}",
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                "$titulo :",
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "$hora Hrs",
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7B42F6), Color(0xFFB01EFF)],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text(
                  "Registrar hora",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          _buildHoraCard("Hora de Ingreso", ingreso, _registrarHoraIngreso),
          _buildHoraCard("Hora de Salida", salida, _registrarHoraSalida),
        ],
      ),
    );
  }
}
