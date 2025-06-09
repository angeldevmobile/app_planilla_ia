import 'package:flutter/material.dart';
import '../../../components/custom_button.dart';
import '../../../../models/user_model.dart';
import '../../../api/api_service.dart';

class LoginDetailsSection extends StatefulWidget {
  final UserModel user;

  const LoginDetailsSection({super.key, required this.user});

  @override
  State<LoginDetailsSection> createState() => _LoginDetailsSectionState();
}

class _LoginDetailsSectionState extends State<LoginDetailsSection> {
  late TextEditingController logeoController;
  late TextEditingController telefonoController;
  late TextEditingController correoController;
  late TextEditingController direccionController;

  @override
  void initState() {
    super.initState();
    logeoController = TextEditingController(text: widget.user.idLogeo);
    telefonoController = TextEditingController(text: widget.user.telefono);
    correoController = TextEditingController(text: widget.user.correo);
    direccionController = TextEditingController(text: widget.user.direccion);
  }

  @override
  void dispose() {
    logeoController.dispose();
    telefonoController.dispose();
    correoController.dispose();
    direccionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCard(
          title: 'Detalles de inicio de sesión',
          content: Row(
            children: [
              Expanded(
                child: _styledTextField(
                  controller: logeoController,
                  hint: 'ID logeo',
                  enabled: false, // Campo de solo lectura
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildCard(
          title: 'Información de contacto',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _styledTextField(
                      controller: telefonoController,
                      hint: 'Celular',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _styledTextField(
                      controller: correoController,
                      hint: 'Correo',
                      enabled: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Dirección:'),
              const SizedBox(height: 8),
              _styledTextField(
                controller: direccionController,
                hint: 'Dirección',
              ),
              const SizedBox(height: 24),
              Center(
                child: AnimatedButton(
                  text: 'Actualizar',
                  onTap: () async {
                    final updatedData = {
                      'telefono': telefonoController.text.trim(),
                      'direccion': direccionController.text.trim(),
                    };

                    final success = await ApiService()
                        .updateUser(widget.user.idLogeo, updatedData);

                    if (!mounted) return;

                    if (success) {
                      setState(() {
                        telefonoController.text =
                            telefonoController.text.trim();
                        direccionController.text =
                            direccionController.text.trim();
                        // Si también quieres forzar actualización visual, podrías usar:
                        // correoController.text = correoController.text;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Usuario actualizado correctamente')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Error al actualizar usuario')),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required String title, required Widget content}) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      shadowColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            content,
          ],
        ),
      ),
    );
  }

  Widget _styledTextField({
    required TextEditingController controller,
    required String hint,
    bool enabled = true,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF5F4F9),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: enabled ? Colors.blue : Colors.grey,
            width: 1.8,
          ),
        ),
      ),
    );
  }
}
