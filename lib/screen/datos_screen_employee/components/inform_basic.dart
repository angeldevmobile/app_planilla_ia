import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class BasicInfoForm extends StatefulWidget {
  const BasicInfoForm({super.key});

  @override
  BasicInfoFormState createState() => BasicInfoFormState();
}

class BasicInfoFormState extends State<BasicInfoForm> {
  String? _selectedGender = 'Femenino';
  DateTime? _selectedDate;
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _documentoController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue.shade400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: screenWidth * 0.5,
        margin: const EdgeInsets.only(left: 17),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Información Básica',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nombres :'),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _nombresController,
                        decoration: _inputDecoration('Nombres'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Apellidos :'),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _apellidosController,
                        decoration: _inputDecoration('Apellidos'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Género'),
            Row(
              children: [
                Radio<String>(
                  value: 'Femenino',
                  groupValue: _selectedGender,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() => _selectedGender = value);
                  },
                ),
                const Text('Femenino'),
                const SizedBox(width: 20),
                Radio<String>(
                  value: 'Masculino',
                  groupValue: _selectedGender,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() => _selectedGender = value);
                  },
                ),
                const Text('Masculino'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Documento de Identidad'),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _documentoController,
                        decoration: _inputDecoration('Documento'),
                      ),
                      const SizedBox(height: 15),
                      const Text('Fecha de nacimiento'),
                      const SizedBox(height: 5),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: InputDecorator(
                          decoration: _inputDecoration('dd/mm/yyyy'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'dd/mm/yyyy'
                                    : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                              ),
                              const Icon(Icons.calendar_today, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DottedBorder(
                    color: Colors.grey.shade400,
                    strokeWidth: 2,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    dashPattern: [8, 4],
                    child: Container(
                      height: 160,
                      margin: const EdgeInsets.only(top: 10),
                      color: Colors.grey.shade100,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.upload_file,
                                size: 40, color: Colors.grey),
                            const SizedBox(height: 8),
                            const Text('Sube tus archivos'),
                            const SizedBox(height: 8),
                            OutlinedButton(
                              onPressed: () {
                                // Lógica para seleccionar archivos
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.blue,
                                side: const BorderSide(color: Colors.blue),
                              ),
                              child: const Text('Seleccionar archivos'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nombresController.dispose();
    _apellidosController.dispose();
    _documentoController.dispose();
    super.dispose();
  }
}
