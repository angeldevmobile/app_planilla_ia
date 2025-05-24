class Boleta {
  final String no;
  final String mes;
  final String ano;
  final String fechaPago;
  final String estado;
  final bool completado;

  Boleta({
    required this.no,
    required this.mes,
    required this.ano,
    required this.fechaPago,
    required this.estado,
    required this.completado,
  });

  // Método para crear una copia con cambios (útil para actualizar estados)
  Boleta copyWith({
    String? no,
    String? mes,
    String? ano,
    String? fechaPago,
    String? estado,
    bool? completado,
  }) {
    return Boleta(
      no: no ?? this.no,
      mes: mes ?? this.mes,
      ano: ano ?? this.ano,
      fechaPago: fechaPago ?? this.fechaPago,
      estado: estado ?? this.estado,
      completado: completado ?? this.completado,
    );
  }
}
