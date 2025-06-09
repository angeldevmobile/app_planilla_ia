import 'package:http/http.dart' as http;

class PlanillaService {
  Future<double> fetchTotalNominaMensual() async {
    final response = await http
        .get(Uri.parse('http://localhost:8085/api/planillas/total-mensual'));
    if (response.statusCode == 200) {
      return double.parse(response.body.trim());
    } else {
      throw Exception('Error al obtener el total de nómina mensual');
    }
  }

  Future<double> fetchPromedioNominaMensual() async {
    final response = await http
        .get(Uri.parse('http://localhost:8085/api/planillas/promedio-mensual'));
    if (response.statusCode == 200) {
      return double.parse(response.body.trim());
    } else {
      throw Exception('Error al obtener el salario promedio mensual');
    }
  }
}
