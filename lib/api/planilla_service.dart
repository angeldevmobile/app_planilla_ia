import 'dart:convert';
import 'package:http/http.dart' as http;

class PlanillaService {
  final String baseUrl;

  PlanillaService({required this.baseUrl});

  Future<double> fetchTotalNominaMensual() async {
    final response =
        await http.get(Uri.parse('$baseUrl/api/planillas/total-mensual'));
    if (response.statusCode == 200) {
      return double.parse(response.body.trim());
    } else {
      throw Exception('Error al obtener el total de nómina mensual');
    }
  }

  Future<double> fetchPromedioNominaMensual() async {
    final response =
        await http.get(Uri.parse('$baseUrl/api/planillas/promedio-mensual'));
    if (response.statusCode == 200) {
      return double.parse(response.body.trim());
    } else {
      throw Exception('Error al obtener el salario promedio mensual');
    }
  }

  Future<String> generarPlanillaPDF(String idPlanilla) async {
    final url =
        Uri.parse('$baseUrl/api/planillas/boleta/$idPlanilla/generar-pdf');
    final response = await http.post(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al generar el PDF');
    }
  }

  Future<void> generarPlanilla(
      int idUsuario, Map<String, dynamic> planillaJson) async {
    final url = Uri.parse('$baseUrl/api/planillas/generar/$idUsuario');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(planillaJson),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al generar la planilla');
    }
  }

  // Nuevo método para obtener empleados con su última planilla
  Future<List<Map<String, dynamic>>> fetchEmpleadosConUltimaPlanilla() async {
    final url = Uri.parse('$baseUrl/api/planillas/empleados-con-planilla');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Error al cargar empleados con planilla');
    }
  }
}
