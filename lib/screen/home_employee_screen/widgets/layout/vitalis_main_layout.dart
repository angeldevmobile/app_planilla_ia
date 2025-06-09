import 'package:flutter/material.dart';
import '../../../asistencia_screen_employee/asistencia_screen.dart';
import '../../../boletas_screen_employee/boletas_screen.dart';
import '../../../datos_screen_employee/datos_screen.dart';
import '../../../justificacion_screen_employee/justificacion_screen.dart';
import '../../../vacations_screen_employee/vacaciones_screen.dart';
import '../sidebar/sidebar_vitalis.dart';
import '../welcome_dash/home_content.dart';
import 'components/top_bar.dart';
import '../../../../models/user_model.dart';

class VitalisMainLayout extends StatefulWidget {
  final UserModel user;

  const VitalisMainLayout({super.key, required this.user});

  @override
  State<VitalisMainLayout> createState() => _VitalisMainLayoutState();
}

class _VitalisMainLayoutState extends State<VitalisMainLayout> {
  bool isSidebarOpen = true;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeContent(user: widget.user), // Pasar nombre del usuario
      DatosScreen(user: widget.user),
      BoletasScreen(user: widget.user),
      AsistenciaScreen(user: widget.user),
      JustificacionScreen(user: widget.user),
      VacacionesScreen(user: widget.user),
    ];

    return Scaffold(
      body: Row(
        children: [
          if (isSidebarOpen)
            VitalisSidebar(
              isCollapsed: false,
              onToggle: () {
                setState(() {
                  isSidebarOpen = !isSidebarOpen;
                });
              },
              selectedIndex: selectedIndex,
              onItemTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
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
