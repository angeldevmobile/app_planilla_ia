import 'package:flutter/material.dart';

import '../../../api/register_modal_admin.dart';
import '../../../models/register_data_ad.dart';

class EmployeeRegistrationModal extends StatefulWidget {
  const EmployeeRegistrationModal({super.key});

  @override
  State<EmployeeRegistrationModal> createState() =>
      _EmployeeRegistrationModalState();
}

class _EmployeeRegistrationModalState extends State<EmployeeRegistrationModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  final _formKey = GlobalKey<FormState>();

  // 1. Controladores y variables de estado
  final nombresController = TextEditingController();
  final apellidosController = TextEditingController();
  final dniController = TextEditingController();
  final telefonoController = TextEditingController();
  final correoController = TextEditingController();
  final direccionController = TextEditingController();
  final especialidadController = TextEditingController();
  final sueldoController = TextEditingController();
  final fechaIngresoController = TextEditingController();
  final fechaNacimientoController = TextEditingController();
  final nombreContactoController = TextEditingController();
  final telefonoContactoController = TextEditingController();
  final parentescoContactoController = TextEditingController();
  final direccionContactoController = TextEditingController();

  String? sexoValue;
  String? turnoValue;
  String? puestoValue;
  String? tipoContratoValue;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    nombresController.dispose();
    apellidosController.dispose();
    dniController.dispose();
    telefonoController.dispose();
    correoController.dispose();
    direccionController.dispose();
    especialidadController.dispose();
    sueldoController.dispose();
    fechaIngresoController.dispose();
    fechaNacimientoController.dispose();
    nombreContactoController.dispose();
    telefonoContactoController.dispose();
    parentescoContactoController.dispose();
    direccionContactoController.dispose();
    super.dispose();
  }

  // Modifica tu modernTextField para aceptar controller
  Widget _modernTextField({
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon:
              icon != null ? Icon(icon, color: Colors.deepPurple) : null,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.deepPurple),
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          fillColor: Colors.deepPurple.withAlpha((0.05 * 255).toInt()),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        ),
        cursorColor: Colors.deepPurple,
      ),
    );
  }

  int _getTipoContratoId(String? value) {
    switch (value) {
      case 'regimen_general':
        return 1;
      case 'plazo_fijo':
        return 2;
      case 'locacion_servicios':
        return 3;
      case 'practicante_pre':
        return 4;
      case 'practicante_pro':
        return 5;
      case 'cas':
        return 6;
      case 'snp':
        return 7;
      case 'suplencia':
        return 8;
      case 'terceros':
        return 9;
      case 'consultor_externo':
        return 10;
      default:
        return 0; // Valor inválido
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.92,
            constraints: const BoxConstraints(maxWidth: 600),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withAlpha((0.15 * 255).toInt()),
                  blurRadius: 32,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          const Icon(Icons.person_add_alt_1,
                              color: Colors.deepPurple, size: 32),
                          const SizedBox(width: 12),
                          const Text(
                            'Registrar Empleado',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.close,
                                color: Colors.deepPurple),
                            onPressed: () => Navigator.of(context).pop(),
                            splashRadius: 22,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
                      const SizedBox(height: 10),

                      // Subheader
                      const Text(
                        'Información Personal',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Form fields
                      Row(
                        children: [
                          Expanded(
                            child: _modernTextField(
                              label: 'Nombres',
                              hint: 'Ej: Juan Carlos',
                              icon: Icons.person_outline,
                              controller: nombresController,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _modernTextField(
                              label: 'DNI',
                              hint: 'Ej: 87654321',
                              keyboardType: TextInputType.number,
                              icon: Icons.badge_outlined,
                              controller: dniController,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _modernTextField(
                              label: 'Apellidos',
                              hint: 'Ej: Pérez Gómez',
                              icon: Icons.person_outline,
                              controller: apellidosController,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _modernTextField(
                              label: 'Celular',
                              hint: 'Ej: 987 654 321',
                              keyboardType: TextInputType.phone,
                              icon: Icons.phone_outlined,
                              controller: telefonoController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Contract Type Dropdown
                      DropdownButtonFormField<String>(
                        value: tipoContratoValue,
                        decoration: InputDecoration(
                          labelText: 'Tipo de contrato',
                          labelStyle: const TextStyle(color: Colors.deepPurple),
                          filled: true,
                          fillColor:
                              Colors.deepPurple.withAlpha((0.05 * 255).toInt()),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 18),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'regimen_general',
                            child: Text('Régimen General (DL 728)'),
                          ),
                          DropdownMenuItem(
                            value: 'locacion_servicios',
                            child: Text(
                                'Locación de Servicios (Recibo por Honorarios)'),
                          ),
                          DropdownMenuItem(
                            value: 'practicante_pre',
                            child: Text('Practicante Preprofesional'),
                          ),
                          DropdownMenuItem(
                            value: 'practicante_pro',
                            child: Text('Practicante Profesional'),
                          ),
                          DropdownMenuItem(
                            value: 'snp',
                            child: Text('Servicios No Personales (SNP)'),
                          ),
                          DropdownMenuItem(
                            value: 'consultor_externo',
                            child: Text('Consultor Externo'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            tipoContratoValue = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),

                      // Position Dropdown and Email
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Puesto',
                                labelStyle:
                                    const TextStyle(color: Colors.deepPurple),
                                filled: true,
                                fillColor: Colors.deepPurple
                                    .withAlpha((0.05 * 255).toInt()),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 18),
                              ),
                              items: const [
                                DropdownMenuItem(
                                    value: 'Cirujano', child: Text('Cirujano')),
                                DropdownMenuItem(
                                    value: 'Enfermera',
                                    child: Text('Enfermera')),
                                DropdownMenuItem(
                                    value: 'Director', child: Text('Gerente')),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  puestoValue = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // Sueldo
                      _modernTextField(
                        label: 'Sueldo',
                        hint: 'Ej: 2500.00',
                        keyboardType: TextInputType.number,
                        icon: Icons.attach_money,
                        controller: sueldoController,
                      ),

                      // Fecha de ingreso
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: TextFormField(
                          controller: fechaIngresoController,
                          readOnly: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.date_range,
                                color: Colors.deepPurple),
                            labelText: 'Fecha de ingreso',
                            labelStyle:
                                const TextStyle(color: Colors.deepPurple),
                            filled: true,
                            fillColor: Colors.deepPurple
                                .withAlpha((0.05 * 255).toInt()),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 18),
                          ),
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              fechaIngresoController.text =
                                  picked.toIso8601String().split('T').first;
                            }
                          },
                        ),
                      ),

                      // Especialidad
                      _modernTextField(
                        label: 'Especialidad',
                        hint: 'Ej: Cardiología',
                        icon: Icons.medical_services_outlined,
                        controller: especialidadController,
                      ),

                      // Dirección
                      _modernTextField(
                        label: 'Dirección',
                        hint: 'Ej: Av. Siempre Viva 123',
                        icon: Icons.home_outlined,
                        controller: direccionController,
                      ),

                      // Sexo
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Sexo',
                          labelStyle: const TextStyle(color: Colors.deepPurple),
                          filled: true,
                          fillColor:
                              Colors.deepPurple.withAlpha((0.05 * 255).toInt()),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 18),
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: 'M', child: Text('Masculino')),
                          DropdownMenuItem(value: 'F', child: Text('Femenino')),
                          DropdownMenuItem(value: 'O', child: Text('Otro')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            sexoValue = value;
                          });
                        },
                      ),

                      // Fecha de nacimiento
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: TextFormField(
                          controller: fechaNacimientoController,
                          readOnly: true,
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.cake, color: Colors.deepPurple),
                            labelText: 'Fecha de nacimiento',
                            labelStyle:
                                const TextStyle(color: Colors.deepPurple),
                            filled: true,
                            fillColor: Colors.deepPurple
                                .withAlpha((0.05 * 255).toInt()),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 18),
                          ),
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime(1990),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            // Maneja el valor seleccionado
                            if (picked != null) {
                              fechaNacimientoController.text =
                                  picked.toIso8601String().split('T').first;
                            }
                          },
                        ),
                      ),

                      // Estado civil
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.contact_page,
                                color: Colors.deepPurple),
                            labelText: 'Nombre del contacto',
                            labelStyle:
                                const TextStyle(color: Colors.deepPurple),
                            hintText: 'Ej: María Pérez',
                            filled: true,
                            fillColor: Colors.deepPurple
                                .withAlpha((0.05 * 255).toInt()),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 18),
                          ),
                        ),
                      ),

                      // Número de colegiatura
                      _modernTextField(
                        label: 'Teléfono del contacto',
                        hint: '+51 987 654 321',
                        keyboardType: TextInputType.number,
                        icon: Icons.phone_outlined,
                        controller: telefonoContactoController,
                      ),

                      // Turno
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Turno',
                          labelStyle: const TextStyle(color: Colors.deepPurple),
                          filled: true,
                          fillColor:
                              Colors.deepPurple.withAlpha((0.05 * 255).toInt()),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 18),
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: 'mañana', child: Text('Mañana')),
                          DropdownMenuItem(
                              value: 'tarde', child: Text('Tarde')),
                          DropdownMenuItem(
                              value: 'noche', child: Text('Noche')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            turnoValue = value;
                          });
                        },
                      ),

                      // Observaciones -> Parentesco del contacto y Dirección del contacto
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: TextFormField(
                          controller: parentescoContactoController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.family_restroom,
                                color: Colors.deepPurple),
                            labelText: 'Parentesco del contacto',
                            labelStyle:
                                const TextStyle(color: Colors.deepPurple),
                            hintText:
                                'Ej: Madre, Padre, Esposo/a, Hermano/a...',
                            filled: true,
                            fillColor: Colors.deepPurple
                                .withAlpha((0.05 * 255).toInt()),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 18),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: TextFormField(
                          controller: direccionContactoController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on,
                                color: Colors.deepPurple),
                            labelText: 'Dirección del contacto',
                            labelStyle:
                                const TextStyle(color: Colors.deepPurple),
                            hintText: 'Ej: Av. Siempre Viva 456',
                            filled: true,
                            fillColor: Colors.deepPurple
                                .withAlpha((0.05 * 255).toInt()),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 18),
                          ),
                        ),
                      ),

                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                // Validación de fechas requeridas
                                if (fechaNacimientoController.text.isEmpty ||
                                    fechaIngresoController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Completa las fechas requeridas')),
                                  );
                                  return;
                                }
                                // 2. Crea el DTO y llama al servicio
                                final dto = RegisterEmployeeDTO(
                                  nombres: nombresController.text,
                                  apellidos: apellidosController.text,
                                  dni: dniController.text,
                                  telefono: telefonoController.text,
                                  correo: correoController.text,
                                  direccion: direccionController.text,
                                  rol: 'Empleado',
                                  cargo: puestoValue ?? '',
                                  estado: 'Activo',
                                  sexo: sexoValue ?? '',
                                  fechaNacimiento:
                                      fechaNacimientoController.text,
                                  turno: turnoValue ?? '',
                                  fechaIngreso: fechaIngresoController.text,
                                  idTipoContrato:
                                      _getTipoContratoId(tipoContratoValue),
                                  fechaInicioContrato:
                                      fechaIngresoController.text,
                                  fechaFinContrato: null,
                                  sueldoBruto:
                                      double.tryParse(sueldoController.text) ??
                                          0.0,
                                  condicionesContrato: '',
                                  periodoMes: DateTime.now().month,
                                  periodoAnio: DateTime.now().year,
                                  bonificaciones: 0.0,
                                  nombreContacto: nombreContactoController.text,
                                  telefonoContacto:
                                      telefonoContactoController.text,
                                  parentescoContacto:
                                      parentescoContactoController.text,
                                  direccionContacto:
                                      direccionContactoController.text,
                                );
                                final newUserId =
                                    await registerEmployee(dto.toJson());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Usuario registrado exitosamente'),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                Navigator.of(context).pop(newUserId);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              elevation: 5,
                              shadowColor: Colors.deepPurple
                                  .withAlpha((0.3 * 255).toInt()),
                            ),
                            child: const Text(
                              'Registrar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
