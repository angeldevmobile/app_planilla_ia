class UserModel {
  final String nombres;
  final String apellidos;
  final String dni;
  final String telefono;
  final String correo;
  final String direccion;
  final String rol;
  final String idLogeo;

  UserModel({
    required this.nombres,
    required this.apellidos,
    required this.dni,
    required this.telefono,
    required this.correo,
    required this.direccion,
    required this.rol,
    required this.idLogeo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      dni: json['dni'],
      telefono: json['telefono'],
      correo: json['correo'],
      direccion: json['direccion'],
      rol: json['rol'],
      idLogeo: json['idLogeo'],
    );
  }
}
