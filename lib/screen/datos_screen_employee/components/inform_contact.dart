import 'package:flutter/material.dart';

class EmergencyContactCard extends StatefulWidget {
  const EmergencyContactCard({super.key});

  @override
  State<EmergencyContactCard> createState() => _EmergencyContactCardState();
}

class _EmergencyContactCardState extends State<EmergencyContactCard> {
  final _focusNodes = List.generate(4, (_) => FocusNode());
  final _controllers = List.generate(4, (_) => TextEditingController());

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
        color: focusNode.hasFocus 
            ? Colors.grey.shade50 
            : Colors.grey.shade100,
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        onTap: () => setState(() {}),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
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
              label: "Apellidos",
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
  }
}