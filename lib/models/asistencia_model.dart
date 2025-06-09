class AsistenciaModel {
  final int id_usuario;
  final String fecha;
  final String hora_entrada;
  final String? hora_salida;

  AsistenciaModel({
    required this.id_usuario,
    required this.fecha,
    required this.hora_entrada,
    this.hora_salida,
  });

  factory AsistenciaModel.fromJson(Map<String, dynamic> json) {
    return AsistenciaModel(
      id_usuario: json['id_usuario'],
      fecha: json['fecha'],
      hora_entrada: json['hora_entrada'],
      hora_salida: json['hora_salida'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_usuario': id_usuario,
      'fecha': fecha,
      'hora_entrada': hora_entrada,
      'hora_salida': hora_salida,
    };
  }
}
