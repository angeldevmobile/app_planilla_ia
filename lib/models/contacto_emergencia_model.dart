class ContactoEmergenciaModel {
  final int idContacto;
  final String nombre_contacto;
  final String telefono_contacto;
  final String parentesco;
  final String direccion_contacto;
  final int idUsuario;

  ContactoEmergenciaModel({
    required this.idContacto,
    required this.nombre_contacto,
    required this.telefono_contacto,
    required this.direccion_contacto,
    required this.parentesco,
    required this.idUsuario,
  });

  factory ContactoEmergenciaModel.fromJson(Map<String, dynamic> json) {
    return ContactoEmergenciaModel(
      idContacto: json['idContacto'] ?? 0,
      nombre_contacto: json['nombreContacto'] ?? '',
      telefono_contacto: json['telefonoContacto'] ?? '',
      direccion_contacto: json['direccionContacto'] ?? '',
      parentesco: json['parentesco'] ?? '',
      idUsuario: json['idUsuario'] ?? 0,
    );
  }
}
