import 'package:flutter/material.dart';
import '../../api/admin_user_details.dart';
import '../../api/planilla_service.dart';
import '../../models/planilla_model.dart';
import 'components/employee_list.dart';
import 'components/employee_table.dart';
import 'components/employee_top_app_bar.dart';
import 'modal/add_employee_dialog.dart';

class EmployeeDirectory extends StatefulWidget {
  const EmployeeDirectory({super.key});

  @override
  State<EmployeeDirectory> createState() => _EmployeeDirectoryState();
}

class _EmployeeDirectoryState extends State<EmployeeDirectory> {
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;

  late Future<List<Map<String, String>>> _futureEmployeeData;

  // Variables para la planilla
  int periodoMesSeleccionado = DateTime.now().month;
  int periodoAnioSeleccionado = DateTime.now().year;
  int? idUsuario;
  double? sueldoBruto;
  double? bonificaciones;

  // Instancia de PlanillaService con el baseUrl correcto
  final PlanillaService planillaService =
      PlanillaService(baseUrl: 'http://localhost:8085');

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
    _futureEmployeeData = UserService().fetchUsuarios();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> generarPlanilla() async {
    print('Función generarPlanilla llamada');
    try {
      // Obtener el último usuario registrado
      final employeeData = await _futureEmployeeData;
      if (employeeData.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No hay empleados registrados')),
        );
        return;
      }

      final lastEmployee = employeeData.last;
      final idUsuario =
          int.parse(lastEmployee['id_usuario']!); // ID del usuario

      final planilla = Planilla(
        periodoMes: periodoMesSeleccionado,
        periodoAnio: periodoAnioSeleccionado,
        usuarioId: idUsuario,
        sueldoBruto: sueldoBruto ?? 0.0,
        bonificaciones: bonificaciones ?? 0.0,
      );

      await planillaService.generarPlanilla(idUsuario, planilla.toJson());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Planilla generada y descuentos aplicados')),
      );
    } catch (e) {
      print('Error al generar la planilla: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EmployeeTopAppBar(
                searchFocusNode: _searchFocusNode,
                isSearchFocused: _isSearchFocused,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      print('Botón "Agregar Empleado" presionado');
                      final result = await showDialog(
                        context: context,
                        builder: (context) => EmployeeRegistrationModal(),
                      );
                      if (result != null) {
                        setState(() {
                          idUsuario = result;
                          _futureEmployeeData = UserService().fetchUsuarios();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Registro exitoso')),
                        );
                      }
                    },
                    icon: const Icon(Icons.person_add),
                    label: const Text('Agregar Empleado'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      print('Botón "Aplicar descuento" presionado');
                      generarPlanilla();
                    },
                    icon: const Icon(Icons.discount, color: Colors.white),
                    label: const Text('Aplicar descuento'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Total empleados',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              FutureBuilder<List<Map<String, String>>>(
                future: _futureEmployeeData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No hay empleados registrados.');
                  }
                  final employeeData = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tu empresa tiene ${employeeData.length} empleados registrados en la compañía.',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth < 800) {
                            return EmployeeList(
                              employeeData: employeeData,
                              planillaService: planillaService,
                            );
                          } else {
                            return EmployeeTable(
                              employeeData: employeeData,
                              planillaService: planillaService,
                            );
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
