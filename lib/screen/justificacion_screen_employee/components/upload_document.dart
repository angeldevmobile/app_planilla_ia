import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../api/permiso_service.dart';

class UploadDocument extends StatelessWidget {
  final void Function(String fileName) onFileUploaded;
  const UploadDocument({super.key, required this.onFileUploaded});

  Future<void> _pickAndUploadFile(BuildContext context) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(withData: true);
    if (result != null) {
      String? uploadedFileName;
      if (kIsWeb) {
        uploadedFileName = await PermisosService().uploadFile(
          bytes: result.files.single.bytes,
          fileName: result.files.single.name,
        );
      } else {
        uploadedFileName = await PermisosService().uploadFile(
          path: result.files.single.path,
          fileName: result.files.single.name,
        );
      }
      if (uploadedFileName != null) {
        onFileUploaded(uploadedFileName); // Notifica al formulario
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Archivo subido correctamente')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al subir archivo')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al subir archivo')),
      );
    }
  }

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
          elevation: 4,
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
                  onPressed: () => _pickAndUploadFile(context),
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
