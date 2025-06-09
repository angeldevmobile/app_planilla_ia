import 'package:flutter/material.dart';
import '../../../api/contacto_service.dart';
import '../../../models/contacto_emergencia_model.dart';

class EmergencyContactCard extends StatefulWidget {
  final int idUsuario;

  const EmergencyContactCard({super.key, required this.idUsuario});

  @override
  State<EmergencyContactCard> createState() => _EmergencyContactCardState();
}

class _EmergencyContactCardState extends State<EmergencyContactCard> {
  final _focusNodes = List.generate(4, (_) => FocusNode());
  final _controllers = List.generate(4, (_) => TextEditingController());
  late Future<ContactoEmergenciaModel> _futureContacto;

  @override
  void initState() {
    super.initState();
    _futureContacto = _loadContacto();
  }

  Future<ContactoEmergenciaModel> _loadContacto() async {
    final contactos =
        await ContactoService().getContactosPorUsuario(widget.idUsuario);
    if (contactos.isEmpty) {
      throw Exception('No se encontró contacto de emergencia');
    }

    final contacto = contactos.first;

    // Llenar los campos
    _controllers[0].text = contacto.nombre_contacto;
    _controllers[1].text =
        contacto.direccion_contacto; 
    _controllers[2].text = contacto.parentesco;
    _controllers[3].text = contacto.telefono_contacto;

    return contacto;
  }

  Widget _buildAnimatedField({
    required String label,
    required String hint,
    required FocusNode focusNode,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: focusNode.hasFocus ? Colors.grey.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: focusNode.hasFocus
              ? Theme.of(context).primaryColor.withAlpha((0.3 * 255).toInt())
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: focusNode.hasFocus
                ? Theme.of(context).primaryColor
                : Colors.grey.shade600,
          ),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        onTap: () => setState(() {}),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ContactoEmergenciaModel>(
      future: _futureContacto,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Text('Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red)),
          );
        }

        return Card(
          color: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Información de contacto de emergencia",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 20),
                _buildAnimatedField(
                  label: "Nombres",
                  hint: "Ej: Juan",
                  focusNode: _focusNodes[0],
                  controller: _controllers[0],
                ),
                _buildAnimatedField(
                  label: "Direccion",
                  hint: "Ej: Pérez",
                  focusNode: _focusNodes[1],
                  controller: _controllers[1],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildAnimatedField(
                        label: "Parentesco",
                        hint: "Ej: Familiar",
                        focusNode: _focusNodes[2],
                        controller: _controllers[2],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 4,
                      child: _buildAnimatedField(
                        label: "Celular",
                        hint: "Ej: +51 987654321",
                        focusNode: _focusNodes[3],
                        controller: _controllers[3],
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
