import 'dart:convert';
import 'package:http/http.dart' as http;

class PermisosService {
  Future<List<dynamic>> fetchPermisos() async {
    final response =
        await http.get(Uri.parse('http://localhost:8085/api/permisos'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return [];
    }
  }
}
