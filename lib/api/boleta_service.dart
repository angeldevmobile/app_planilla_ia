import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/boleta_model1.dart';

class BoletaService {
  Future<List<BoletaModel>> getBoletasPorUsuario(int idUsuario) async {
    final url = Uri.parse('http://localhost:8085/api/boletas/$idUsuario');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => BoletaModel.fromJson(json)).toList();
      } else {
        // Muestra información detallada del error
        throw Exception(
          'Error al cargar boletas.\n'
          'Código de estado: ${response.statusCode}\n'
          'Cuerpo: ${response.body}',
        );
      }
    } catch (e) {
      // Captura errores de red o de formato
      throw Exception('Excepción al hacer la petición: $e');
    }
  }
}
