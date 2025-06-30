class AsistenciaMensual {
  final int mes;
  final int anio;
  final int totalAsistencias;

  AsistenciaMensual({
    required this.mes,
    required this.anio,
    required this.totalAsistencias,
  });

  factory AsistenciaMensual.fromJson(Map<String, dynamic> json) {
    return AsistenciaMensual(
      mes: json['mes'],
      anio: json['anio'],
      totalAsistencias: json['totalAsistencias'],
    );
  }
}
