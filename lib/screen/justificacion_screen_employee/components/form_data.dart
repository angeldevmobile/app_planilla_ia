import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/ausencia_model.dart';
import '../../../models/user_model.dart';
import '../../../api/ausencia_service.dart';
import '../../../api/permiso_service.dart';

class JustificationForm extends StatefulWidget {
  final UserModel user;
  final String? nombreArchivoRespaldo;
  final void Function(String fileName) onFileUploaded;

  const JustificationForm({
    super.key,
    required this.user,
    required this.nombreArchivoRespaldo,
    required this.onFileUploaded,
  });

  @override
  State<JustificationForm> createState() => _JustificationFormState();
}

class _JustificationFormState extends State<JustificationForm> {
  String? _selectedJustificationType;
  AusenciaModel? _selectedAusencia;
  final TextEditingController _detailController = TextEditingController();
  List<AusenciaModel> _ausencias = [];

  final List<String> _justificationTypes = [
    'Justificación por Falta',
    'Enfermedad',
    'Problemas familiares',
    'Problemas de transporte',
    'Compromiso laboral',
    'Otro motivo'
  ];

  @override
  void initState() {
    super.initState();
    _cargarAusenciasNoJustificadas();
  }

  Future<void> _cargarAusenciasNoJustificadas() async {
    try {
      final ausencias = await AusenciaService()
          .obtenerAusenciasNoJustificadas(widget.user.id_usuario);

      setState(() {
        _ausencias = ausencias;
      });
    } catch (e) {
      print('Error al cargar ausencias no justificadas: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar ausencias: $e')),
      );
    }
  }

  Future<void> _enviarJustificacion() async {
    if (_selectedAusencia == null ||
        _selectedJustificationType == null ||
        _detailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complete todos los campos')),
      );
      return;
    }

    try {
      // Construye el permiso como lo espera tu backend
      final permiso = {
        "idUsuario": widget.user.id_usuario,
        "fecha": _selectedAusencia!.fecha, // Asegúrate que sea yyyy-MM-dd
        "tipoPermiso": _selectedJustificationType!,
        "conGoce": true, // o según tu lógica
        "aprobado": false, // o según tu lógica
        "documentoRespaldo": widget.nombreArchivoRespaldo,
        "observaciones": _detailController.text,
      };

      await PermisosService().crearPermiso(permiso);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Justificación registrada exitosamente')),
      );
      setState(() {
        _selectedAusencia = null;
        _selectedJustificationType = null;
        _detailController.clear();
      });
      _cargarAusenciasNoJustificadas();
    } catch (e) {
      print('Error al enviar justificación: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error inesperado: $e')),
      );
    }
  }

  @override
  void dispose() {
    _detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F6FA),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: const Color(0x11000000),
                blurRadius: 6,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Solicitudes de Justificación y Permisos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 24),
              const Text('Tipo de solicitud',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedJustificationType,
                items: _justificationTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: const Text('Seleccione el tipo de justificación'),
                onChanged: (value) {
                  setState(() {
                    _selectedJustificationType = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text('Fecha de Falta',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<AusenciaModel>(
                value: _selectedAusencia,
                items: _ausencias.map((AusenciaModel a) {
                  return DropdownMenuItem<AusenciaModel>(
                    value: a,
                    child: Text(DateFormat('dd/MM/yyyy')
                        .format(DateTime.parse(a.fecha))),
                  );
                }).toList(),
                hint: const Text('Seleccione una fecha'),
                onChanged: (value) {
                  setState(() {
                    _selectedAusencia = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text('Justificación Detallada:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _detailController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Describa el motivo de su justificación...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              // Ya NO pongas UploadDocument aquí, solo muestra el archivo seleccionado
              if (widget.nombreArchivoRespaldo != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                      'Archivo seleccionado: ${widget.nombreArchivoRespaldo}'),
                ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _enviarJustificacion,
                  child: const Text('Enviar Solicitud'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
