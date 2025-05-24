import 'package:flutter/material.dart';
import '../../../asistencia_screen_employee/asistencia_screen.dart';
import '../../../boletas_screen_employee/boletas_screen.dart';
import '../../../datos_screen_employee/datos_screen.dart';
import '../../../justificacion_screen_employee/justificacion_screen.dart';
import '../../../vacaciones_screen_employee/vacaciones_screen.dart';
import '../sidebar/sidebar_vitalis.dart';
import '../welcome_dash/home_content.dart';
import 'components/top_bar.dart';

class VitalisMainLayout extends StatefulWidget {
  const VitalisMainLayout({super.key});

  @override
  State<VitalisMainLayout> createState() => _VitalisMainLayoutState();
}

class _VitalisMainLayoutState extends State<VitalisMainLayout> {
  bool isSidebarOpen = true;
  int selectedIndex = 0;

  final List<Widget> screens = [
    HomeContent(userName: 'Diana'),
    DatosScreen(userName: 'Diana'),
    BoletasScreen(),
    AsistenciaScreen(),
    JustificacionScreen(),
    VacacionesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isSidebarOpen ? 250 : 70,
            child: VitalisSidebar(
              isCollapsed: !isSidebarOpen,
              onToggle: () {
                setState(() {
                  isSidebarOpen = !isSidebarOpen;
                });
              },
              selectedIndex: selectedIndex,
              onItemTap: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),
          Expanded(
            child: Column(
              children: [
                TopBar(
                  isSidebarOpen: isSidebarOpen,
                  onToggle: () {
                    setState(() {
                      isSidebarOpen = !isSidebarOpen;
                    });
                  },
                ),
                Expanded(
                  child: screens[selectedIndex],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
