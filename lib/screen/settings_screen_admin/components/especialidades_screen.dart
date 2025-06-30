import 'package:flutter/material.dart';

class EspecialidadesScreen extends StatefulWidget {
  const EspecialidadesScreen({super.key});

  @override
  State<EspecialidadesScreen> createState() => _EspecialidadesScreenState();
}

class _EspecialidadesScreenState extends State<EspecialidadesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  final List<Map<String, dynamic>> _especialidades = [
    {
      'nombre': 'Cardiología',
      'activa': false,
      'color': const Color(0xFF6A11CB)
    },
    {'nombre': 'Pediatría', 'activa': true, 'color': const Color(0xFF2575FC)},
    {
      'nombre': 'Dermatología',
      'activa': false,
      'color': const Color(0xFFF857A6)
    },
    {'nombre': 'Neurología', 'activa': true, 'color': const Color(0xFF4AC29A)},
    {
      'nombre': 'Oftalmología',
      'activa': true,
      'color': const Color(0xFFFF8E53)
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<double>(begin: 20, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 8,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Colors.grey[50]!,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.05 * 255).toInt()),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gestión de Especialidades Médicas',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E384D),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Lista de especialidades
                      ..._buildEspecialidadesList(),

                      const SizedBox(height: 24),
                      _buildAddButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildEspecialidadesList() {
    return _especialidades.map((especialidad) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _buildEspecialidadItem(
          especialidad['nombre'],
          especialidad['activa'],
          especialidad['color'],
        ),
      );
    }).toList();
  }

  Widget _buildEspecialidadItem(String nombre, bool activa, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.8),
                color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            _getIconForSpecialty(nombre),
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          nombre,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: activa ? const Color(0xFF2E384D) : Colors.grey[600],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.scale(
              scale: 1.2,
              child: Switch(
                value: activa,
                onChanged: (value) {
                  setState(() {
                    _especialidades.firstWhere(
                        (e) => e['nombre'] == nombre)['activa'] = value;
                  });
                },
                activeColor: color,
                activeTrackColor: color.withOpacity(0.3),
                inactiveThumbColor: Colors.grey[400],
                inactiveTrackColor: Colors.grey[200],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.grey[600]),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForSpecialty(String nombre) {
    switch (nombre) {
      case 'Cardiología':
        return Icons.favorite;
      case 'Pediatría':
        return Icons.child_care;
      case 'Dermatología':
        return Icons.healing;
      case 'Neurología':
        return Icons.psychology;
      case 'Oftalmología':
        return Icons.remove_red_eye;
      default:
        return Icons.medical_services;
    }
  }

  Widget _buildAddButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
          backgroundColor: const Color(0xFF3366FF),
          shadowColor: const Color(0xFF3366FF).withOpacity(0.3),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, size: 20),
            SizedBox(width: 8),
            Text(
              'Agregar Nueva Especialidad',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
