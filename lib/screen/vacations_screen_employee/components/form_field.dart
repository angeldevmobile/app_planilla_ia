import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VacacionesForm extends StatefulWidget {
  const VacacionesForm({super.key});

  @override
  State<VacacionesForm> createState() => _VacacionesFormState();
}

class _VacacionesFormState extends State<VacacionesForm> {
  final TextEditingController _inicioController = TextEditingController();
  final TextEditingController _finController = TextEditingController();
  int diasVacaciones = 0;

  void _selectDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = DateFormat('dd/MM/yyyy').format(picked);
      if (_inicioController.text.isNotEmpty && _finController.text.isNotEmpty) {
        final inicio = DateFormat('dd/MM/yyyy').parse(_inicioController.text);
        final fin = DateFormat('dd/MM/yyyy').parse(_finController.text);
        setState(() {
          diasVacaciones = fin.difference(inicio).inDays + 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Formulario de fechas
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Fecha de Inicio"),
              const SizedBox(height: 5),
              _buildShadowedTextField(_inicioController),
              const SizedBox(height: 20),
              const Text("Fecha de Fin"),
              const SizedBox(height: 5),
              _buildShadowedTextField(_finController),
              const SizedBox(height: 20),
              const Text("Días de vacaciones :"),
              const SizedBox(height: 5),
              _buildShadowedInfoBox(diasVacaciones.toString()),
            ],
          ),
        ),
        const SizedBox(width: 40),
        // Área de subida de archivo
        _buildUploadBox(),
      ],
    );
  }

  Widget _buildShadowedTextField(TextEditingController controller) {
    return GestureDetector(
      onTap: () => _selectDate(controller),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(2, 2),
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextField(
          controller: controller,
          enabled: false,
          decoration: const InputDecoration(
            hintText: 'dd/mm/yyyy',
            suffixIcon: Icon(Icons.calendar_today),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildShadowedInfoBox(String value) {
    return Container(
      width: 150,
      height: 40,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Text(value),
    );
  }

  Widget _buildUploadBox() {
    return Container(
      width: 220,
      height: 230,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.upload_file, size: 48, color: Colors.deepPurple),
          const SizedBox(height: 12),
          const Text("Adjuntar Archivo", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text("Drop your files to upload", textAlign: TextAlign.center),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              // Acción al seleccionar archivos
            },
            child: const Text("Select files"),
          ),
        ],
      ),
    );
  }
}
