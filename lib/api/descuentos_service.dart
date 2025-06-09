import 'dart:convert';
import 'package:http/http.dart' as http;

class PlanillaService {
  Future<void> generarPlanilla(int idUsuario, Map<String, dynamic> planilla) async {
    final url = Uri.parse('http://localhost:8085/api/planillas/generar/$idUsuario');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(planilla),
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Error al generar la planilla');
    }
  }
}