import 'package:flutter/material.dart';

import 'components/form_data.dart';
import 'components/table_history.dart';
import 'components/upload_document.dart';
import 'components/welcome_justification.dart';
import '../../../../models/user_model.dart';

class JustificacionScreen extends StatefulWidget {
  final UserModel user;
  const JustificacionScreen({super.key, required this.user});

  @override
  State<JustificacionScreen> createState() => _JustificacionScreenState();
}

class _JustificacionScreenState extends State<JustificacionScreen> {
  String? _nombreArchivoRespaldo;

  void _onFileUploaded(String fileName) {
    setState(() {
      _nombreArchivoRespaldo = fileName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WelcomeJustification(userName: widget.user.nombres),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          // Pasa el archivo y el callback al formulario
                          JustificationForm(
                            user: widget.user,
                            nombreArchivoRespaldo: _nombreArchivoRespaldo,
                            onFileUploaded: _onFileUploaded,
                          ),
                          const SizedBox(width: 90),
                          // Solo deja este UploadDocument externo
                          UploadDocument(
                            onFileUploaded: _onFileUploaded,
                          ),
                        ],
                      ),
                      HistoryTable(user: widget.user),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
