import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/vacacion_model.dart';

class VacacionService {
  final String baseUrl = 'http://localhost:8085/api/vacaciones';

  Future<bool> registrarVacacion(VacacionModel model) async {
    final url = Uri.parse('$baseUrl/registrar');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(model.toJson()),
      );

      debugPrint('Estado del servidor: ${response.statusCode}');
      debugPrint('Respuesta del servidor: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else {
        // Aquí se imprime el error detallado si el backend lo devuelve
        debugPrint('Error al registrar vacaciones: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Error de conexión al registrar vacaciones: $e');
      return false;
    }
  }

  Future<List<VacacionModel>> obtenerTodasLasSolicitudes() async {
    final url = Uri.parse('http://localhost:8085/api/admin/vacaciones/todas');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((e) => VacacionModel.fromJson(e)).toList();
      } else {
        debugPrint('Error al obtener solicitudes: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      debugPrint('Excepción al obtener solicitudes: $e');
      return [];
    }
  }

  Future<bool> revisarSolicitud(int idVacacion, String aprobado,
      {String? observaciones}) async {
    final url = Uri.parse(
      'http://localhost:8085/api/admin/vacaciones/revisar/$idVacacion'
      '?aprobado=$aprobado${observaciones != null ? '&observaciones=$observaciones' : ''}',
    );
    try {
      final response = await http.put(url);
      debugPrint('Estado del servidor: ${response.statusCode}');
      debugPrint('Respuesta del servidor: ${response.body}');
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Error al revisar solicitud: $e');
      return false;
    }
  }

  Future<List<VacacionModel>> obtenerVacacionesPorUsuario(int idUsuario) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/usuario/$idUsuario'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((e) => VacacionModel.fromJson(e)).toList();
      } else {
        print('Error al obtener vacaciones: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Excepción al obtener vacaciones: $e');
      return [];
    }
  }
}
