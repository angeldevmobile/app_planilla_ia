class RegisterEmployeeDTO {
  final String nombres;
  final String apellidos;
  final String dni;
  final String telefono;
  final String correo;
  final String direccion;
  final String rol;
  final String cargo;
  final String estado;
  final String sexo;
  final String fechaNacimiento;
  final String turno;
  final String fechaIngreso;
  final int idTipoContrato;
  final String fechaInicioContrato;
  final String? fechaFinContrato;
  final double sueldoBruto;
  final String condicionesContrato;
  final int periodoMes;
  final int periodoAnio;
  final double bonificaciones;
  final String nombreContacto;
  final String telefonoContacto;
  final String parentescoContacto;
  final String direccionContacto;

  RegisterEmployeeDTO({
    required this.nombres,
    required this.apellidos,
    required this.dni,
    required this.telefono,
    required this.correo,
    required this.direccion,
    required this.rol,
    required this.cargo,
    required this.estado,
    required this.sexo,
    required this.fechaNacimiento,
    required this.turno,
    required this.fechaIngreso,
    required this.idTipoContrato,
    required this.fechaInicioContrato,
    required this.fechaFinContrato, // <-- Cambia aquí a String?
    required this.sueldoBruto,
    required this.condicionesContrato,
    required this.periodoMes,
    required this.periodoAnio,
    required this.bonificaciones,
    required this.nombreContacto,
    required this.telefonoContacto,
    required this.parentescoContacto,
    required this.direccionContacto,
  });

  Map<String, dynamic> toJson() => {
        "nombres": nombres,
        "apellidos": apellidos,
        "dni": dni,
        "telefono": telefono,
        "correo": correo,
        "direccion": direccion,
        "rol": rol,
        "cargo": cargo,
        "estado": estado,
        "sexo": sexo,
        "fecha_nacimiento": fechaNacimiento,
        "turno": turno,
        "fechaIngreso": fechaIngreso,
        "idTipoContrato": idTipoContrato,
        "fechaInicioContrato": fechaInicioContrato,
        "fechaFinContrato": fechaFinContrato ?? '', 
        "sueldoBruto": sueldoBruto,
        "condicionesContrato": condicionesContrato,
        "periodoMes": periodoMes,
        "periodoAnio": periodoAnio,
        "bonificaciones": bonificaciones,
        "nombreContacto": nombreContacto,
        "telefonoContacto": telefonoContacto,
        "parentescoContacto": parentescoContacto,
        "direccionContacto": direccionContacto,
      };
}
