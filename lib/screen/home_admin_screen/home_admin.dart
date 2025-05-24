import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class HomeAdminScreen extends StatelessWidget {
  final UserModel userData;
  const HomeAdminScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home Screen Admin'),
      ),
    );
  }
}