class DashboardStats {
  final String porcentajeAsistencia;
  final int vacaciones;
  final int ausencias;
  final int asistencias;

  DashboardStats({
    required this.porcentajeAsistencia,
    required this.vacaciones,
    required this.ausencias,
    required this.asistencias,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      porcentajeAsistencia: json['porcentajeAsistencia'].toString(),
      vacaciones: json['vacaciones'],
      ausencias: json['ausencias'],
      asistencias: json['asistencias'],
    );
  }
}
