import 'dart:convert';
import 'package:http/http.dart' as http;

class ParametroLaboral {
  final int id;
  final String clave;
  final String valor;

  ParametroLaboral(
      {required this.id, required this.clave, required this.valor});

  factory ParametroLaboral.fromJson(Map<String, dynamic> json) {
    return ParametroLaboral(
      id: json['id'],
      clave: json['clave'],
      valor: json['valor'],
    );
  }
}

class ParametroLaboralService {
  static const String baseUrl =
      'http://localhost:8085/api/configuracion/parametros';

  static Future<List<ParametroLaboral>> fetchParametros() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => ParametroLaboral.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar parámetros');
    }
  }
}
