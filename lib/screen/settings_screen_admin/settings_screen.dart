import 'package:flutter/material.dart';

import '../../api/param_labor_service.dart';
import 'components/auditoria_screen.dart';
import 'components/backup_screen.dart';
import 'components/especialidades_screen.dart';
import 'components/horarios_screen.dart';
import 'components/integraciones_screen.dart';
import 'components/soporte_screen.dart';
import 'components/summary_card.dart';

class AdminClinicSettingsHorizontal extends StatefulWidget {
  const AdminClinicSettingsHorizontal({super.key});

  @override
  State<AdminClinicSettingsHorizontal> createState() =>
      _AdminClinicSettingsHorizontalState();
}

class _AdminClinicSettingsHorizontalState
    extends State<AdminClinicSettingsHorizontal> {
  String selectedSection = 'Configuración';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ParametroLaboral>>(
      future: ParametroLaboralService.fetchParametros(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final parametros = snapshot.data ?? [];

        String getValor(String clave) => parametros
            .firstWhere((e) => e.clave == clave,
                orElse: () => ParametroLaboral(id: 0, clave: '', valor: ''))
            .valor;

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Panel de Administración - Configuración de Clínica',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E384D),
                ),
              ),
              const SizedBox(height: 16),
              _buildHorizontalMenu(context),
              const SizedBox(height: 24),
              _buildSectionContent(getValor),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHorizontalMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildMenuButton('Configuración', Icons.settings,
                selected: selectedSection == 'Configuración', onPressed: () {
              setState(() => selectedSection = 'Configuración');
            }),
            _buildMenuButton('Especialidades', Icons.medical_services,
                selected: selectedSection == 'Especialidades', onPressed: () {
              setState(() => selectedSection = 'Especialidades');
            }),
            _buildMenuButton('Horarios', Icons.access_time,
                selected: selectedSection == 'Horarios', onPressed: () {
              setState(() => selectedSection = 'Horarios');
            }),
            _buildMenuButton('Integraciones', Icons.link,
                selected: selectedSection == 'Integraciones', onPressed: () {
              setState(() => selectedSection = 'Integraciones');
            }),
            _buildMenuButton('Backup', Icons.backup,
                selected: selectedSection == 'Backup', onPressed: () {
              setState(() => selectedSection = 'Backup');
            }),
            _buildMenuButton('Auditoría', Icons.assignment,
                selected: selectedSection == 'Auditoría', onPressed: () {
              setState(() => selectedSection = 'Auditoría');
            }),
            _buildMenuButton('Soporte', Icons.help,
                selected: selectedSection == 'Soporte', onPressed: () {
              setState(() => selectedSection = 'Soporte');
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(String title, IconData icon,
      {bool selected = false, VoidCallback? onPressed}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor:
              selected ? const Color(0xFF3366FF) : Colors.grey[700],
          backgroundColor: selected ? const Color(0xFFF0F5FF) : null,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionContent(String Function(String) getValor) {
    switch (selectedSection) {
      case 'Especialidades':
        return EspecialidadesScreen();
      case 'Horarios':
        return HorariosScreen();
      case 'Integraciones':
        return IntegracionesScreen();
      case 'Backup':
        return BackupScreen();
      case 'Auditoría':
        return AuditoriaScreen();
      case 'Soporte':
        return SoporteScreen();
      case 'Configuración':
      default:
        return SingleChildScrollView(
          child: Column(
            children: [
              const SummaryCard(),
              const SizedBox(height: 24),
              _buildMainSettingsSection(getValor),
              const SizedBox(height: 24),
              _buildAdvancedSettingsSection(),
            ],
          ),
        );
    }
  }

  Widget _buildMainSettingsSection(String Function(String) getValor) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Configuración Principal',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E384D),
                  )),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.save),
                label: Text('Guardar Cambios'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3366FF),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Información básica
          const Text(
            'Información de la Clínica',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E384D),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(
                width: 300,
                child: _buildAdminTextField(
                    label: 'Nombre de la Clínica',
                    value: getValor('Nombre Clinica')),
              ),
              SizedBox(
                width: 200,
                child:
                    _buildAdminTextField(label: 'RUC', value: getValor('RUC')),
              ),
              SizedBox(
                width: 400,
                child: _buildAdminTextField(
                    label: 'Dirección', value: getValor('Dirección')),
              ),
              SizedBox(
                width: 250,
                child: _buildAdminTextField(
                    label: 'Teléfono Principal', value: getValor('Telefono')),
              ),
              SizedBox(
                width: 350,
                child: _buildAdminTextField(
                    label: 'Correo Electrónico',
                    value: getValor('Correo electronico')),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Configuración de horario
          Text(
            'Horario de Atención',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E384D),
            ),
          ),
          SizedBox(height: 16),

          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildTimeRangeField(
                  day: 'Mañana',
                  start: getValor('Mañana').split(' a ').first,
                  end: getValor('Mañana').split(' a ').last),
              _buildTimeRangeField(
                  day: 'Tarde',
                  start: getValor('Tarde').split(' a ').first,
                  end: getValor('Tarde').split(' a ').last),
              _buildTimeRangeField(
                  day: 'Noche',
                  start: getValor('Noche').split(' a ').first,
                  end: getValor('Noche').split(' a ').last),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdminTextField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: value,
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeRangeField(
      {required String day, required String start, required String end}) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E384D),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildTimeInputField(value: start),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('a'),
              ),
              Expanded(
                child: _buildTimeInputField(value: end),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeInputField({required String value}) {
    return TextFormField(
      readOnly: true,
      initialValue: value,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.access_time, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      onTap: () {
        // Lógica para mostrar selector de hora
      },
    );
  }

  Widget _buildAdvancedSettingsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Configuración Avanzada',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E384D),
            ),
          ),
          const SizedBox(height: 24),

          // Configuración del sistema
          _buildAdvancedSettingCard(
            title: 'Preferencias del Sistema',
            icon: Icons.settings,
            children: [
              _buildAdvancedSettingSwitch('Modo mantenimiento', false),
              _buildAdvancedSettingSwitch('Registro de auditoría', true),
              _buildAdvancedSettingSwitch('Notificaciones por email', true),
              _buildAdvancedSettingSwitch('Backup automático', true),
            ],
          ),
          const SizedBox(height: 24),

          // Integraciones
          _buildAdvancedSettingCard(
            title: 'Integraciones',
            icon: Icons.link,
            children: [
              _buildIntegrationItem('Sistema de Pago', true),
              _buildIntegrationItem('Historial Clínico Electrónico', false),
              _buildIntegrationItem('Laboratorios Externos', true),
              _buildIntegrationItem('Sistema de Facturación', true),
            ],
          ),
          const SizedBox(height: 24),

          // Seguridad
          _buildAdvancedSettingCard(
            title: 'Seguridad',
            icon: Icons.security,
            children: [
              _buildSecurityItem('Autenticación en dos pasos', true),
              _buildSecurityItem('Política de contraseñas', true),
              _buildSecurityItem('IPs permitidas', false),
            ],
          ),
          const SizedBox(height: 24),

          // Acciones peligrosas
          Card(
            color: Colors.red[50],
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.red[200]!, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Zona de Acciones Peligrosas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Estas acciones afectarán a toda la clínica y no se pueden deshacer fácilmente.',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                        ),
                        child: const Text('Restablecer Configuración',
                            style: TextStyle(color: Colors.red)),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Eliminar Clínica'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedSettingCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF3366FF)),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E384D),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedSettingSwitch(String title, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Switch(
            value: value,
            onChanged: (newValue) {},
            activeColor: const Color(0xFF3366FF),
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationItem(String name, bool connected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                connected ? Icons.check_circle : Icons.error,
                color: connected ? Colors.green : Colors.orange,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(name),
            ],
          ),
          TextButton(
            onPressed: () {},
            child: Text(connected ? 'Configurar' : 'Conectar'),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityItem(String title, bool enabled) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Chip(
            label: Text(enabled ? 'Habilitado' : 'Deshabilitado'),
            backgroundColor: enabled ? Colors.green[50] : Colors.red[50],
            labelStyle: TextStyle(
              color: enabled ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
