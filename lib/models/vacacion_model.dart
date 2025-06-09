class VacacionModel {
  final int? idVacacion;
  final int idUsuario;
  final String fechaInicio;
  final String fechaFin;
  final int diasCalculados;
  final String? aprobado;
  final String fechaSolicitud;
  final String? observaciones;
  final String? documentoRespaldo;

  VacacionModel({
    this.idVacacion,
    required this.idUsuario,
    required this.fechaInicio,
    required this.fechaFin,
    required this.diasCalculados,
    this.aprobado,
    required this.fechaSolicitud,
    this.observaciones,
    this.documentoRespaldo,
  });
  Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "fecha_inicio": fechaInicio,
        "fecha_fin": fechaFin,
        "dias_calculados": diasCalculados,
        "fecha_solicitud": fechaSolicitud,
        "documento_respaldo": documentoRespaldo,
        "aprobado": aprobado,
        "observaciones": observaciones,
      };

  factory VacacionModel.fromJson(Map<String, dynamic> json) {
    return VacacionModel(
      idVacacion: json['id_vacacion'],
      idUsuario: json['id_usuario'],
      fechaInicio: json['fecha_inicio'],
      fechaFin: json['fecha_fin'],
      diasCalculados: json['dias_calculados'],
      aprobado: json['aprobado'],
      fechaSolicitud: json['fecha_solicitud'],
      observaciones: json['observaciones'],
      documentoRespaldo: json['documento_respaldo'],
    );
  }
}
