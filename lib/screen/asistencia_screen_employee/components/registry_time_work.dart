import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../api/asistencia_service.dart';
import '../../../models/asistencia_model.dart';
import '../../../models/user_model.dart';

class WorkHoursPage extends StatefulWidget {
  final UserModel user;
  const WorkHoursPage({super.key, required this.user});

  @override
  WorkHoursPageState createState() => WorkHoursPageState();
}

class WorkHoursPageState extends State<WorkHoursPage> {
  String ingreso = "00:00 Hrs";
  String salida = "00:00 Hrs";
  bool ingresoRegistrado = false;
  bool salidaRegistrada = false;

  @override
  void initState() {
    super.initState();
    _verificarAsistencia();
  }

  Future<void> _verificarAsistencia() async {
    final asistencia = await AsistenciaService()
        .obtenerAsistenciaDeHoy(widget.user.id_usuario);

    if (asistencia != null) {
      setState(() {
        ingreso =
            "${DateFormat('hh:mm a').format(DateFormat('HH:mm:ss').parse(asistencia.hora_entrada))} Hrs";
        ingresoRegistrado = true;

        if (asistencia.hora_salida != null) {
          salida =
              "${DateFormat('hh:mm a').format(DateFormat('HH:mm:ss').parse(asistencia.hora_salida!))} Hrs";
          salidaRegistrada = true;
        }
      });
    } else {
      setState(() {
        ingreso = "00:00 Hrs";
        salida = "00:00 Hrs";
      });
    }
  }

  void _registrarHoraIngreso() async {
    if (ingresoRegistrado) return;
    final now = DateTime.now();
    final asistencia = AsistenciaModel(
      idAsistencia: 0, // Valor dummy, el backend lo ignora al crear
      id_usuario: widget.user.id_usuario,
      fecha: DateFormat('yyyy-MM-dd').format(now),
      hora_entrada: DateFormat('HH:mm:ss').format(now),
      hora_salida: null,
      horasExtra: 0.0, // Valor dummy, el backend lo ignora al crear
    );

    final exito = await AsistenciaService().registrarAsistencia(asistencia);
    if (exito) {
      setState(() {
        ingreso = "${DateFormat('hh:mm a').format(now)} Hrs";
        ingresoRegistrado = true;
      });
    }
  }

  void _registrarHoraSalida() async {
    if (salidaRegistrada) return;
    final now = DateTime.now();
    final horaSalida = DateFormat('HH:mm:ss').format(now);

    final exito = await AsistenciaService()
        .actualizarSalida(widget.user.id_usuario, horaSalida);
    if (exito) {
      setState(() {
        salida = "${DateFormat('hh:mm a').format(now)} Hrs";
        salidaRegistrada = true;
      });
    }
  }

  Widget _buildHoraCard(
      String titulo, String hora, VoidCallback onPressed, bool yaRegistrado) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.3 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Fecha : ${DateFormat('dd/MM/yyyy').format(DateTime.now())}",
              style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Text(titulo, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Text(hora, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: yaRegistrado ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: yaRegistrado ? Colors.grey : null,
              ),
              child: Text(yaRegistrado ? "Ya registrado" : "Registrar hora"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHoraCard("Hora de Ingreso :", ingreso, _registrarHoraIngreso,
            ingresoRegistrado),
        if (ingresoRegistrado)
          _buildHoraCard("Hora de Salida :", salida, _registrarHoraSalida,
              salidaRegistrada),
      ],
    );
  }
}