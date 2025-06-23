class AsistenciaModel {
  final int idAsistencia;
  final int id_usuario;
  final String fecha;
  final String hora_entrada;
  final String? hora_salida;
  final double horasExtra;

  AsistenciaModel({
    required this.idAsistencia,
    required this.id_usuario,
    required this.fecha,
    required this.hora_entrada,
    this.hora_salida,
    required this.horasExtra,
  });

  factory AsistenciaModel.fromJson(Map<String, dynamic> json) {
    return AsistenciaModel(
      idAsistencia: json['idAsistencia'] ?? 0,
      id_usuario: json['id_usuario'] ?? 0,
      fecha: json['fecha'] ?? '',
      hora_entrada: json['hora_entrada'] ?? '',
      hora_salida: json['hora_salida'],
      horasExtra: (json['horasExtra'] != null)
          ? (json['horasExtra'] as num).toDouble()
          : 0.0,
    );
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'id_usuario': id_usuario,
      'fecha': fecha,
      'hora_entrada': hora_entrada,
      'hora_salida': hora_salida,
      'horasExtra': horasExtra,
    };
  }
}
