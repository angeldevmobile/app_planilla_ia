import 'package:flutter/material.dart';
import '../../../../models/user_model.dart';

class BasicInfoForm extends StatefulWidget {
  final UserModel user;

  const BasicInfoForm({super.key, required this.user});

  @override
  BasicInfoFormState createState() => BasicInfoFormState();
}

class BasicInfoFormState extends State<BasicInfoForm> {
  late final TextEditingController _nombresController;
  late final TextEditingController _apellidosController;
  late final TextEditingController _documentoController;
  late final TextEditingController _cargoController;
  late final TextEditingController _fechaIngresoController;
  late final TextEditingController _fechaNacimientoController;
  //nuevo
  @override
  void initState() {
    super.initState();
    _nombresController = TextEditingController(text: widget.user.nombres);
    _apellidosController = TextEditingController(text: widget.user.apellidos);
    _documentoController = TextEditingController(text: widget.user.dni);

    _cargoController = TextEditingController(text: widget.user.cargo);
    _fechaIngresoController =
        TextEditingController(text: widget.user.fechaIngreso);
    _fechaNacimientoController =
        TextEditingController(text: widget.user.fechaNacimiento);
  }

//FIN

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
                      const SizedBox(height: 5),
                      InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Fecha de Nacimiento  :'),
                            const SizedBox(height: 5),
                            TextField(
                              controller: _fechaNacimientoController,
                              decoration: _inputDecoration('Cargo'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Cargo  :'),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _cargoController,
                        decoration: _inputDecoration('Cargo'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Fecha Ingreso  :'),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _fechaIngresoController,
                        decoration: _inputDecoration('Cargo'),
                      ),
                    ],
                  ),
                )
              ],
            ),
            /*Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Cargo  :'),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _nombresController,
                        decoration: _inputDecoration('Cargo'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Fecha Ingreso :'),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _apellidosController,
                        decoration: _inputDecoration('Fecha Ingreso'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            */
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
    _cargoController.dispose();
    _fechaIngresoController.dispose();
    super.dispose();
  }
}
