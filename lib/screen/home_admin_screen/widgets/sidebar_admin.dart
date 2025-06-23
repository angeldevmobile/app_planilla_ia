import 'package:web/web.dart' as web;
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final void Function(String)? onMenuSelected;
  final String selectedPage;

  const Sidebar({super.key, this.onMenuSelected, required this.selectedPage});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool isCollapsed = false;
  String? nombres;
  String? correo;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    setState(() {
      nombres = web.window.localStorage['nombres'] ?? 'Usuario';
      correo = web.window.localStorage['correo'] ?? 'correo@example.com';
    });
  }

  Future<void> _logout(BuildContext context) async {
    web.window.localStorage.clear();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isCollapsed = !isCollapsed;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isCollapsed ? 70 : 320,
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Center(
                      child: isCollapsed
                          ? const Icon(Icons.local_hospital,
                              color: Colors.blue, size: 32)
                          : const Text(
                              'VITALIS CLÍNICA',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                              textAlign: TextAlign.center,
                            ),
                    ),
                    const SizedBox(height: 40),
                    _buildMenuItem(
                      Icons.dashboard,
                      'Dashboard',
                      isActive: widget.selectedPage == 'Dashboard',
                      onTap: () {
                        widget.onMenuSelected?.call('Dashboard');
                      },
                    ),
                    _buildMenuItem(
                      Icons.people,
                      'Employees',
                      isActive: widget.selectedPage == 'Employees',
                      onTap: () {
                        widget.onMenuSelected?.call('Employees');
                      },
                    ),
                    _buildMenuItem(
                      Icons.payment,
                      'Payroll',
                      isActive: widget.selectedPage == 'Payroll',
                      onTap: () {
                        widget.onMenuSelected?.call('Payroll');
                      },
                    ),
                    _buildMenuItem(
                      Icons.settings,
                      'Settings',
                      isActive: widget.selectedPage == 'Settings',
                      onTap: () {
                        widget.onMenuSelected?.call('Settings');
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const Divider(height: 20),
            isCollapsed
                ? IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () => _logout(context),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nombres ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              correo ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () {
                          web.window.localStorage.clear();
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title,
      {bool isActive = false, VoidCallback? onTap}) {
    if (isCollapsed) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: IconButton(
          icon: Icon(icon, color: isActive ? Colors.blue : Colors.grey),
          onPressed: onTap,
          tooltip: title,
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue[50] : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: Icon(icon, color: isActive ? Colors.blue : Colors.grey),
          title: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.blue : Colors.black,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          onTap: onTap,
        ),
      );
    }
  }
}
