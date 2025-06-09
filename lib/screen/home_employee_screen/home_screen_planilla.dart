import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import 'widgets/layout/vitalis_main_layout.dart';

class HomeEmployeeScreen extends StatelessWidget {
  final UserModel userData;
  const HomeEmployeeScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return VitalisMainLayout(user: userData);
  }
}
