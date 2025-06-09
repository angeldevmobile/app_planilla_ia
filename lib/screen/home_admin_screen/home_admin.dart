import 'package:flutter/material.dart';

import '../../api/admin_user_details.dart';
import '../../api/planilla_service.dart';
import '../../models/user_model.dart';
import '../employees_screen_admin/employee_screen.dart';
import '../payroll_screen_admin/payroll_screen.dart';
import '../settings_screen_admin/settings_screen.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/employee_list_admin.dart';
import 'widgets/payroll_trend.dart';
import 'widgets/payroll_widget_table.dart';
import 'widgets/sidebar_admin.dart';

class HomeAdminScreen extends StatefulWidget {
  final UserModel userData;
  const HomeAdminScreen({super.key, required this.userData});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  bool _isSearchFocused = false;
  final FocusNode _searchFocusNode = FocusNode();
  String _selectedPage = 'Dashboard';

  late Future<List<Map<String, String>>> _futureEmployeeData;
  late Future<double> _futureTotalNomina;
  late Future<double> _futurePromedioNomina;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
    _futureEmployeeData = UserService().fetchUsuarios();
    _futureTotalNomina = PlanillaService().fetchTotalNominaMensual();
    _futurePromedioNomina = PlanillaService().fetchPromedioNominaMensual();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  Widget _getMainContent() {
    switch (_selectedPage) {
      case 'Employees':
        return const EmployeeDirectory();
      case 'Payroll':
        return PayrollScreen(
          searchFocusNode: _searchFocusNode,
          isSearchFocused: _isSearchFocused,
        );
      case 'Settings':
        return const AdminClinicSettingsHorizontal();
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with search bar, notifications, and avatar
            Row(
              children: [
                const Text(
                  'Panel de Nómina',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                // Search bar
                Expanded(
                  flex: 2,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(_isSearchFocused ? 20.0 : 30.0),
                      border: Border.all(
                        color: _isSearchFocused
                            ? Theme.of(context).primaryColor
                            : Colors.blue,
                        width: _isSearchFocused ? 1.5 : 1.0,
                      ),
                      boxShadow: _isSearchFocused
                          ? [
                              BoxShadow(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withAlpha((0.1 * 255).toInt()),
                                blurRadius: 10,
                                spreadRadius: 2,
                              )
                            ]
                          : null,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      focusNode: _searchFocusNode,
                      decoration: const InputDecoration(
                        hintText: 'Buscar empleado, nómina...',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      style: const TextStyle(color: Colors.black87),
                      cursorColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Notifications icon
                IconButton(
                  icon: Badge(
                    smallSize: 8,
                    child: const Icon(Icons.notifications_outlined),
                  ),
                  onPressed: () {
                    // Acción para notificaciones
                  },
                ),
                const SizedBox(width: 16),
                // Avatar with dropdown
                GestureDetector(
                  onTap: () {
                    // Mostrar menú de usuario
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/user_avatar.png'),
                    radius: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Aquí está su resumen de nómina.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),

            // Stats cards
            Row(
              children: [
                Expanded(
                  child: FutureBuilder<List<Map<String, String>>>(
                    future: _futureEmployeeData,
                    builder: (context, snapshot) {
                      String value = '...';
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        value = '...';
                      } else if (snapshot.hasData) {
                        value = snapshot.data!.length.toString();
                      } else if (snapshot.hasError) {
                        value = 'Err';
                      }
                      return DashboardCard(
                        title: 'Total empleados',
                        value: value,
                        change: '3% vs last month',
                        icon: Icons.people,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FutureBuilder<double>(
                    future: _futureTotalNomina,
                    builder: (context, snapshot) {
                      String value = '...';
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        value = '...';
                      } else if (snapshot.hasData) {
                        value = '\$${snapshot.data!.toStringAsFixed(2)}';
                      } else if (snapshot.hasError) {
                        value = 'Err';
                      }
                      return DashboardCard(
                        title: 'Nómina mensual',
                        value: value,
                        change: '2.5% vs last month',
                        icon: Icons.attach_money,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FutureBuilder<double>(
                    future: _futurePromedioNomina,
                    builder: (context, snapshot) {
                      String value = '...';
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        value = '...';
                      } else if (snapshot.hasData) {
                        value = '\$${snapshot.data!.toStringAsFixed(2)}';
                      } else if (snapshot.hasError) {
                        value = 'Err';
                      }
                      return DashboardCard(
                        title: 'Salario promedio',
                        value: value,
                        change: '5% vs last month',
                        icon: Icons.bar_chart,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: DashboardCard(
                    title: 'Próxima nómina',
                    value: 'June 30, 2025',
                    change: '3% vs last month',
                    icon: Icons.calendar_today,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Trends and Recent Payroll
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Tendencias de nómina',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      PayrollTrendChart(),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
              ],
            ),
            const SizedBox(height: 32),

            // Recent Payroll and Employees side by side
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Nómina reciente',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      RecentPayrollTable(),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Empleados',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const EmployeeList(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedPage: _selectedPage,
            onMenuSelected: (page) {
              setState(() {
                _selectedPage = page;
              });
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: _getMainContent(),
            ),
          ),
        ],
      ),
    );
  }
}
