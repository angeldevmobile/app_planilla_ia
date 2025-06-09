import 'dart:async';
import 'dart:convert';
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
    debugPrint('GET: ${uri.toString()}');

    final response = await http.get(uri);
    debugPrint('Status Code: ${response.statusCode}');
    debugPrint('Body: ${response.body}');

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('No se pudo obtener el usuario');
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
