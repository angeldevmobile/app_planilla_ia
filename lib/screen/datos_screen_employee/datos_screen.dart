import 'package:flutter/material.dart';

import '../home_employee_screen/widgets/welcome_dash/components/welcome_section.dart';
import 'components/inform_aditional.dart';
import 'components/inform_basic.dart';
import 'components/inform_contact.dart';
import 'components/login_details.dart';
import '../../../../models/user_model.dart';
import '../../../api/api_service.dart';

class DatosScreen extends StatefulWidget {
  final UserModel user;

  const DatosScreen({super.key, required this.user});

  @override
  State<DatosScreen> createState() => _DatosScreenState();
}

class _DatosScreenState extends State<DatosScreen> {
  late Future<UserModel> _futureUser;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    _futureUser = ApiService().getUserByIdLogeo(widget.user.idLogeo);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: _futureUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar los datos'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No se encontraron datos'));
        }

        final user = snapshot.data!;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // OLUMNA IZQUIERDA
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WelcomeSection(userName: user.nombres),
                      const SizedBox(height: 20),
                      BasicInfoForm(user: user),
                      const SizedBox(height: 20),
                      EmergencyContactCard(idUsuario: user.id_usuario),
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                // COLUMNA DERECHA
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      LoginDetailsSection(user: user),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      AdditionalInfoCard(user: user),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
