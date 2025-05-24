import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class UploadDocument extends StatelessWidget {
  const UploadDocument({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DottedBorder(
        color: Colors.grey,
        strokeWidth: 2,
        dashPattern: [6, 3],
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        child: Card(
          elevation: 4, // Nivel de sombra
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 300,
            height: 200,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_upload,
                  size: 50,
                  color: Colors.grey,
                ),
                SizedBox(height: 10),
                Text(
                  'Adjuntar Archivo',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 5),
                Text(
                  'Sube tus documentos aquí',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Acción para seleccionar archivos
                  },
                  child: Text('Seleccionar Archivo'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
