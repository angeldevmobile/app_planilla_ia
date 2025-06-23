import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/asistencia_model.dart';

class AsistenciaService {
  final String baseUrl = 'http://localhost:8085/api/asistencia';

  Future<bool> registrarAsistencia(AsistenciaModel asistencia) async {
    final url = Uri.parse(baseUrl);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(asistencia.toCreateJson()),
    );

    if (response.statusCode == 200) {
      print('Asistencia registrada con éxito');
      return true;
    } else {
      print(
          'Error en registrarAsistencia: ${response.statusCode}: ${response.body}');
      throw Exception(
          'Error al registrar asistencia (status ${response.statusCode}): ${response.body}');
    }
  }

  Future<AsistenciaModel?> obtenerAsistenciaDeHoy(int idUsuario) async {
    try {
      final fechaHoy = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final response = await http.get(
        Uri.parse(
            'http://localhost:8085/api/asistencia/$idUsuario?fecha=$fechaHoy'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return AsistenciaModel.fromJson(jsonData);
      } else {
        print('Error al obtener asistencia: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error en obtenerAsistenciaDeHoy: $e');
      return null;
    }
  }

  Future<bool> actualizarSalida(int idUsuario, String horaSalida) async {
    final fechaHoy = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final uri = Uri.parse(
      'http://localhost:8085/api/asistencia/salida/$idUsuario'
      '?horaSalida=$horaSalida&fecha=$fechaHoy',
    );

    final response = await http.put(uri);

    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint(
          "Error al actualizar salida: ${response.statusCode}: ${response.body}");
      return false;
    }
  }

  Future<List<AsistenciaModel>> obtenerAsistenciasUsuario(int idUsuario) async {
    final uri =
        Uri.parse('http://localhost:8085/api/asistencia/todos/$idUsuario');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => AsistenciaModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener asistencias del usuario');
    }
  }
}
