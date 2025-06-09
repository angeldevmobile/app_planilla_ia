import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  Future<List<Map<String, String>>> fetchUsuarios() async {
    final url = Uri.parse('http://localhost:8085/api/empleados');
    final response = await http.get(url);

    print('Status code: ${response.statusCode}'); 
    print('Response body: ${response.body}'); 

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      print('jsonList: $jsonList'); 
      return jsonList.cast<Map<String, dynamic>>().map((json) {
        return {
          'nombres': (json['nombres'] ?? '').toString(),
          'apellidos': (json['apellidos'] ?? '').toString(),
          'correo': (json['correo'] ?? '').toString(),
          'cargo': (json['cargo'] ?? '').toString(),
          'rol': (json['rol'] ?? '').toString(),
          'estado': (json['estado'] ?? '').toString(),
        };
      }).toList();
    } else {
      throw Exception('Error al cargar usuarios');
    }
  }
}
