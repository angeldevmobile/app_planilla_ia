import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/ausencia_model.dart';

class AusenciaService {
  final String baseUrl = 'http://localhost:8085/api/ausencias';

  // Obtener ausencias no justificadas por usuario
  Future<List<AusenciaModel>> obtenerAusenciasNoJustificadas(
      int idUsuario) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/no-justificadas/$idUsuario'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((e) => AusenciaModel.fromJson(e)).toList();
      } else {
        print('Error: Código ${response.statusCode}');
        print('URL: ${response.request?.url}');
        print('Body: ${response.body}');
        throw Exception('Error al obtener ausencias no justificadas');
      }
    } catch (e) {
      print('Excepción inesperada: $e');
      rethrow;
    }
  }

  Future<bool> justificarAusenciaPorFecha({
    required int idUsuario,
    required String fecha,
    required String motivo,
    required String observaciones,
    String? documentoRespaldo,
  }) async {
    final url =
        Uri.parse('http://localhost:8085/api/ausencias/$idUsuario/justificar');

    final Map<String, dynamic> body = {
      'fecha': fecha,
      'motivo': motivo,
      'observaciones': observaciones,
      if (documentoRespaldo != null) 'documentoRespaldo': documentoRespaldo,
    };

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('Ausencia justificada correctamente');
      return true;
    } else {
      print('Error al justificar ausencia: ${response.body}');
      return false;
    }
  }

  // Obtener TODAS las ausencias del usuario (justificadas y no justificadas)
  Future<List<AusenciaModel>> obtenerAusenciasPorUsuario(int idUsuario) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/usuario/$idUsuario'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((e) => AusenciaModel.fromJson(e)).toList();
      } else {
        print('Error al obtener todas las ausencias: ${response.statusCode}');
        print('URL: ${response.request?.url}');
        print('Body: ${response.body}');
        throw Exception('Error al obtener ausencias del usuario');
      }
    } catch (e) {
      print('Excepción inesperada: $e');
      rethrow;
    }
  }
}
