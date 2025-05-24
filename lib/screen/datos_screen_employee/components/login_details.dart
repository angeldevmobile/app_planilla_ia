import 'package:flutter/material.dart';

import '../../../components/custom_button.dart';

class LoginDetailsSection extends StatelessWidget {
  const LoginDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCard(
          title: 'Detalles de inicio de sesión',
          content: Row(
            children: [
              Expanded(child: _styledTextField(hint: '')),
              const SizedBox(width: 16),
              Expanded(child: _styledTextField(hint: '')),
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
                  Expanded(child: _styledTextField(hint: 'Celular')),
                  const SizedBox(width: 12),
                  Expanded(child: _styledTextField(hint: 'example@gmail.com')),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Dirección :'),
              const SizedBox(height: 8),
              _styledTextField(hint: ''),
              const SizedBox(height: 24),
              Center(child: AnimatedButton(text: 'Actualizar', onTap: () {})),
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
            Text(title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            content,
          ],
        ),
      ),
    );
  }

  Widget _styledTextField({required String hint}) {
    return TextFormField(
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
          borderSide:
              const BorderSide(color: Colors.blue, width: 1.8),
        ),
      ),
    );
  }
}
