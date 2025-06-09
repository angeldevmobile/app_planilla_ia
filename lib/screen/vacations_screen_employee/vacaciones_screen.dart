import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import '../../../models/user_model.dart';
import '../../../models/vacacion_model.dart';
import '../../../api/vacacion_service.dart';
import 'components/table_vacation.dart';
import 'components/form_field.dart';
import 'components/calendary_vacaciones.dart';
import '../justificacion_screen_employee/components/welcome_justification.dart';


class VacacionesScreen extends StatefulWidget {
  final UserModel user;
  const VacacionesScreen({super.key, required this.user});

  @override
  State<VacacionesScreen> createState() => _VacacionesScreenState();
}

class _VacacionesScreenState extends State<VacacionesScreen> {
  final TextEditingController fechaInicioController = TextEditingController();
  final TextEditingController fechaFinController = TextEditingController();
  int diasCalculados = 0;
  String? documentoRespaldoNombre;
  String? documentoRespaldoBase64;

  @override
  void dispose() {
    fechaInicioController.dispose();
    fechaFinController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarDocumento() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        documentoRespaldoNombre = result.files.single.name;
        documentoRespaldoBase64 = base64Encode(result.files.single.bytes!);
      });
    }
  }

  Future<void> _registrarVacaciones() async {
    if (fechaInicioController.text.isEmpty ||
        fechaFinController.text.isEmpty ||
        diasCalculados == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completa todos los campos")),
      );
      return;
    }

    final model = VacacionModel(
      idUsuario: widget.user.id_usuario,
      fechaInicio: fechaInicioController.text,
      fechaFin: fechaFinController.text,
      diasCalculados: diasCalculados,
      fechaSolicitud: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      documentoRespaldo: documentoRespaldoNombre ?? '',
    );

    debugPrint('📦 Vacacion enviada: ${jsonEncode(model.toJson())}'); //PRUEBAAA

    final exito = await VacacionService().registrarVacacion(model);
    if (exito) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vacaciones registradas correctamente")),
      );
      setState(() {
        fechaInicioController.clear();
        fechaFinController.clear();
        diasCalculados = 0;
        documentoRespaldoNombre = null;
        documentoRespaldoBase64 = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al registrar vacaciones")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WelcomeJustification(userName: widget.user.nombres),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: CalendaryVacaciones(
                  onDateRangeSelected: (start, end) {
                    setState(() {
                      fechaInicioController.text =
                          DateFormat('dd/MM/yyyy').format(start);
                      fechaFinController.text =
                          DateFormat('dd/MM/yyyy').format(end);
                      diasCalculados = end.difference(start).inDays + 1;
                    });
                  },
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomFormField(
                            labelText: 'Fecha de Inicio',
                            controller: fechaInicioController,
                            readOnly: true,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomFormField(
                            labelText: 'Fecha de Fin',
                            controller: fechaFinController,
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('Días de vacaciones : $diasCalculados'),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _seleccionarDocumento,
                      icon: const Icon(Icons.upload_file),
                      label: const Text("Adjuntar archivo"),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      documentoRespaldoNombre ?? 'Ningún archivo seleccionado',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: _registrarVacaciones,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text("Registrar Vacaciones"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TableVacation(user: widget.user),
        ],
      ),
    );
  }
}
