import 'dart:async';
import 'dart:convert';
import 'package:app_planilla_ia/models/asistencia_dashboard_model.dart';
import 'package:app_planilla_ia/models/asistencia_mensual_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class ApiService {
  // Configuración dinámica de URL base
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:8085/api'; // OJO: sin "/auth"
    } else {
      return 'http://192.168.1.5:8085/api'; // Cambia IP si es necesario
    }
  }

  static const int timeoutSeconds = 15;

  Future<UserModel> login(String username, String password) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/login');
      debugPrint('Intento de login: $username');

      final response = await http
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Access-Control-Allow-Origin': '*',
            },
            body: jsonEncode({'username': username, 'password': password}),
          )
          .timeout(Duration(seconds: timeoutSeconds));

      debugPrint('Respuesta del servidor: ${response.statusCode}');
      debugPrint('Cuerpo de la respuesta: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return UserModel.fromJson(responseData);
      } else {
        final errorData = jsonDecode(response.body);
        throw _AuthException(
          errorData['message'] ?? 'Error de autenticación',
          'auth_error',
        );
      }
    } on TimeoutException {
      throw _AuthException('Tiempo de espera agotado', 'timeout');
    } on http.ClientException catch (e) {
      debugPrint('Error de conexión: $e');
      throw _AuthException(
          'Error de conexión con el servidor', 'connection_error');
    } catch (e) {
      debugPrint('Error inesperado: $e');
      throw _AuthException(
          'Error durante la autenticación', 'authentication_error');
    }
  }

  // Actualizar usuario (INCLUIDO EN LA CLASE)
  Future<bool> updateUser(
      String idLogeo, Map<String, dynamic> updatedData) async {
    final uri = Uri.parse('$baseUrl/users/$idLogeo');

    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedData),
    );

    debugPrint('Código respuesta PUT: ${response.statusCode}');
    debugPrint('Cuerpo respuesta: ${response.body}');

    return response.statusCode == 200;
  }

  Future<UserModel> getUserByIdLogeo(String idLogeo) async {
    final uri = Uri.parse('$baseUrl/users/$idLogeo');

    final response =
        await http.get(uri).timeout(Duration(seconds: timeoutSeconds));
    debugPrint('Respuesta getUserByIdLogeo: ${response.body}');

    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      jsonMap['id_usuario'] = jsonMap['idUsuario']; // <- solución clave
      return UserModel.fromJson(jsonMap);
    } else {
      throw Exception('Error al obtener usuario por idLogeo');
    }
  }

  Future<DashboardStats> fetchDashboardStats(int idUsuario) async {
    final response = await http.get(
      Uri.parse('$baseUrl/dashboard-stats/$idUsuario'),
    );

    if (response.statusCode == 200) {
      return DashboardStats.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener estadísticas');
    }
  }

  Future<List<AsistenciaMensual>> fetchAsistenciaMensual(int idUsuario) async {
    final response = await http.get(
      Uri.parse('$baseUrl/dashboard-stats/mensual/$idUsuario'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => AsistenciaMensual.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener datos mensuales');
    }
  }

  Future<Map<String, int>> fetchAusenciasPie(int idUsuario) async {
    final response = await http.get(
      Uri.parse('$baseUrl/dashboard-stats/ausencias-mes/$idUsuario'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'justificadas': data['justificadas'],
        'noJustificadas': data['noJustificadas'],
      };
    } else {
      throw Exception('Error al obtener ausencias para gráfico circular');
    }
  }
}

// Clase de excepción personalizada
class _AuthException implements Exception {
  final String message;
  final String code;

  _AuthException(this.message, this.code);

  @override
  String toString() => message;
}
