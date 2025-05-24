import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as custom_picker;

class JustificationForm extends StatefulWidget {
  const JustificationForm({super.key});

  @override
  State<JustificationForm> createState() => _JustificationFormState();
}

class _JustificationFormState extends State<JustificationForm> {
  String? _selectedJustificationType;
  final List<String> _justificationTypes = [
    'Justificación por Falta',
    'Enfermedad',
    'Problemas familiares',
    'Problemas de transporte',
    'Compromiso laboral',
    'Otro motivo'
  ];

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F6FA),
            borderRadius: BorderRadius.circular(12.0),
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
              const Text(
                'Solicitudes de Justificación y Permisos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Tipo de solicitud',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: DropdownButtonFormField<String>(
                  value: _selectedJustificationType,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  hint: const Text('Seleccione un motivo'),
                  items: _justificationTypes
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedJustificationType = value;
                    });
                  },
                  isExpanded: true,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Fecha de Falta',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'dd/mm/yyyy',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {
                        custom_picker.DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime(2020),
                          maxTime: DateTime(2100),
                          locale: custom_picker.LocaleType.es,
                          onConfirm: (date) {
                            setState(() {
                              _dateController.text =
                                  DateFormat('dd/MM/yyyy').format(date);
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Justificación Detallada :',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  controller: _detailController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                    hintText: 'Describa el motivo de su justificación...',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedJustificationType == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Por favor seleccione un tipo de justificación'),
                        ),
                      );
                      return;
                    }
                    // Aquí va la lógica de envío del formulario
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    'Enviar Solicitud',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
