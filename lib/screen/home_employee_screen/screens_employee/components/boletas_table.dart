import 'package:app_planilla_ia/api/boleta_service.dart';
import 'package:app_planilla_ia/models/boleta_model1.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IssuedBoletasTable extends StatefulWidget {
  final int idUsuario;
  const IssuedBoletasTable({super.key, required this.idUsuario});

  @override
  State<IssuedBoletasTable> createState() => _IssuedBoletasTableState();
}

class _IssuedBoletasTableState extends State<IssuedBoletasTable> {
  late Future<List<BoletaModel>> _futureBoletas;

  @override
  void initState() {
    super.initState();
    _futureBoletas = BoletaService().getBoletasPorUsuario(widget.idUsuario);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BoletaModel>>(
      future: _futureBoletas,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final boletas = snapshot.data!;
        return Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Boletas Emitidas",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      _buildHeader(),
                      const Divider(height: 1),
                      ...boletas.map((boleta) => _buildRow(boleta)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.lightBlue.shade50,
      child: Row(
        children: [
          _HeaderCell("No", flex: 1),
          _HeaderCell("MES", flex: 2),
          _HeaderCell("AÑO", flex: 2),
          _HeaderCell("Fecha de pago", flex: 3),
          _HeaderCell("Estado", flex: 2),
          _HeaderCell("Descargar", flex: 2),
        ],
      ),
    );
  }

  Widget _buildRow(BoletaModel boleta) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Row(
        children: [
          _DataCell(boleta.id.toString(), flex: 1),
          _DataCell(boleta.mes, flex: 2),
          _DataCell(boleta.anio.toString(), flex: 2),
          _DataCell(boleta.fecha.toString(), flex: 3),
          _DataCell("Completado", flex: 2),
          Expanded(
            flex: 2,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.download_rounded),
                onPressed: () {
                  _descargarArchivo(boleta.rutaArchivo);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _descargarArchivo(String ruta) async {
    final uri = Uri.parse(ruta);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir el archivo: $ruta')),
      );
    }
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  final int flex;
  const _HeaderCell(this.text, {required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;
  final int flex;
  const _DataCell(this.text, {required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(text, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
