import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class ApiService {
  // Configuración dinámica de URL base
  static String get baseUrl {
    if (kIsWeb) {
      // Para navegador web
      return 'http://localhost:8080/api/auth';
    } else {
      // Para dispositivos móviles
      // return 'http://10.0.2.2:8080/api/auth'; // Para emulador Android
      return 'http://192.168.1.5:8080/api/auth'; // Para dispositivo físico (cambia la IP)
    }
  }

  static const int timeoutSeconds = 15;

  Future<UserModel> login(String username, String password) async {
    try {
      final uri = Uri.parse('$baseUrl/login');
      debugPrint('Intento de login: $username');

      final response = await http
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Access-Control-Allow-Origin': '*',
            },
            body: jsonEncode({
              'username': username,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 15));

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
        'Error de conexión con el servidor',
        'connection_error',
      );
    } catch (e) {
      debugPrint('Error inesperado: $e');
      throw _AuthException(
        'Error durante la autenticación',
        'authentication_error',
      );
    }
  }
}

class _AuthException implements Exception {
  final String message;
  final String code;

  _AuthException(this.message, this.code);

  @override
  String toString() => message;
}
