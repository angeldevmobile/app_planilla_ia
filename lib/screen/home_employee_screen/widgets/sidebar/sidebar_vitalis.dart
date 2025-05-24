import 'package:flutter/material.dart';

import 'components/sidebar_header.dart';

class VitalisSidebar extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback onToggle;
  final int selectedIndex;
  final ValueChanged<int> onItemTap;

  const VitalisSidebar({
    super.key,
    required this.isCollapsed,
    required this.onToggle,
    required this.selectedIndex,
    required this.onItemTap,
  });

  final List<_MenuItemData> menuItems = const [
    _MenuItemData(Icons.dashboard_outlined, 'Dashboard'),
    _MenuItemData(Icons.data_usage, 'Datos'),
    _MenuItemData(Icons.payment, 'Boletas de pago'),
    _MenuItemData(Icons.check_circle_outline, 'Registrar Asistencia'),
    _MenuItemData(Icons.note_alt_outlined, 'Justificación y Permisos'),
    _MenuItemData(Icons.beach_access, 'Vacaciones', hasBulb: true),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isCollapsed ? 80 : 250,
      child: Drawer(
        child: Container(
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SidebarHeader(isCollapsed: isCollapsed),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    return _buildMenuItem(
                      icon: item.icon,
                      label: item.label,
                      selected: selectedIndex == index,
                      hasBulb: item.hasBulb,
                      onTap: () {
                        onItemTap(index);
                      },
                    );
                  },
                ),
              ),
              if (!isCollapsed)
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextButton.icon(
                    onPressed: onToggle,
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text(
                      'Cerrar Sesion',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required bool selected,
    bool hasBulb = false,
    VoidCallback? onTap,
  }) {
    return Container(
      color: selected ? const Color(0xFFE3F2FD) : Colors.transparent,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: isCollapsed ? 12 : 24,
        ),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected ? Colors.blue : Colors.white,
            ),
            if (hasBulb && !isCollapsed)
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.lightbulb_outline,
                  color: Colors.amber,
                  size: 16,
                ),
              ),
          ],
        ),
        title: isCollapsed
            ? null
            : Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.blue : Colors.white,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
        selected: selected,
        onTap: onTap,
      ),
    );
  }
}

class _MenuItemData {
  final IconData icon;
  final String label;
  final bool hasBulb;

  const _MenuItemData(this.icon, this.label, {this.hasBulb = false});
}
