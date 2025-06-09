class BoletaModel {
  final int id;
  final String mes;
  final int anio;
  final DateTime fecha;
  final String rutaArchivo;

  BoletaModel({
    required this.id,
    required this.mes,
    required this.anio,
    required this.fecha,
    required this.rutaArchivo,
  });

  factory BoletaModel.fromJson(Map<String, dynamic> json) {
    return BoletaModel(
      id: json['id_boleta'],
      mes: json['nombre_mes'],
      anio: json['periodo_anio'],
      fecha: DateTime.parse(json['fecha_generacion']),
      rutaArchivo: json['ruta_archivo'],
    );
  }
}
