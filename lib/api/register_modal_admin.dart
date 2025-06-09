import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int?> registerEmployee(Map<String, dynamic> formData) async {
  final url = Uri.parse('http://localhost:8085/api/register-employee-add');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(formData),
  );

  if (response.statusCode == 200) {
    try {
      final data = jsonDecode(response.body);
      return data['id']; // <-- Retorna el ID recibido del backend
    } catch (e) {
      // Si no es JSON, simplemente retorna null o maneja el caso según tu lógica
      print('Respuesta no es JSON: ${response.body}');
      return null;
    }
  } else {
    print('Error al registrar empleado: ${response.body}');
    return null;
  }
}
