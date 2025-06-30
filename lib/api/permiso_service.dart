import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

class PermisosService {
  Future<List<dynamic>> fetchPermisos() async {
    final response =
        await http.get(Uri.parse('http://localhost:8085/api/permisos'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return [];
    }
  }

  Future<void> crearPermiso(Map<String, dynamic> permiso) async {
    final response = await http.post(
      Uri.parse('http://localhost:8085/api/permisos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(permiso),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Permiso guardado correctamente');
    } else {
      print('Error al guardar permiso');
    }
  }

  Future<String?> uploadFile({
    String? path,
    List<int>? bytes,
    required String fileName,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost:8085/api/permisos/upload'),
    );
    if (kIsWeb) {
      request.files.add(
          http.MultipartFile.fromBytes('file', bytes!, filename: fileName));
    } else {
      request.files.add(await http.MultipartFile.fromPath('file', path!));
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      return respStr; // El backend retorna el nombre del archivo
    } else {
      return null;
    }
  }
}
