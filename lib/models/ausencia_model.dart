class AusenciaModel {
  final int? idAusencia;
  final int? idUsuario;
  final String fecha;
  final String motivo;
  final bool justificada;
  final String? observaciones;
  final String? documentoRespaldo;

  AusenciaModel({
    this.idAusencia,
    this.idUsuario,
    required this.fecha,
    required this.motivo,
    required this.justificada,
    this.observaciones,
    this.documentoRespaldo,
  });

  factory AusenciaModel.fromJson(Map<String, dynamic> json) {
    return AusenciaModel(
      idAusencia: json['id_ausencia'],
      idUsuario: json['id_usuario'] != null
          ? int.tryParse(json['id_usuario'].toString())
          : null,
      fecha: json['fecha'],
      motivo: json['motivo'] ?? '',
      justificada:
          json['justificada'].toString() == 'true', // ✅ conversión explícita
      observaciones: json['observaciones'],
      documentoRespaldo:
          json['documento_respaldo'], //  nombre correcto según backend
    );
  }
}
