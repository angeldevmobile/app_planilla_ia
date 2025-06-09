import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/contacto_emergencia_model.dart';

class ContactoService {
  static const String baseUrl = 'http://localhost:8085/api/contacto-emergencia';

  Future<List<ContactoEmergenciaModel>> getContactosPorUsuario(
      int idUsuario) async {
    final url = '$baseUrl/$idUsuario';
    final response = await http.get(Uri.parse(url));

    print('GET: $url');
    print('Status Code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => ContactoEmergenciaModel.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener contacto de emergencia');
    }
  }
}
