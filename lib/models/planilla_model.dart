class Planilla {
  final int periodoMes;
  final int periodoAnio;
  final int usuarioId;
  final double? sueldoBruto;
  final double? bonificaciones;

  Planilla({
    required this.periodoMes,
    required this.periodoAnio,
    required this.usuarioId,
    this.sueldoBruto,
    this.bonificaciones,
  });

  Map<String, dynamic> toJson() {
    return {
      'periodo_mes': periodoMes,
      'periodo_anio': periodoAnio,
      'usuario': {'id_usuario': usuarioId},
      if (sueldoBruto != null) 'sueldoBruto': sueldoBruto,
      if (bonificaciones != null) 'bonificaciones': bonificaciones,
    };
  }
}