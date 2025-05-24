import 'package:flutter/material.dart';

import '../../../data/boleta_repository.dart';
import '../../../models/boleta_model.dart';
import 'components/boletas_table.dart';

class BoletasScreen extends StatefulWidget {
  const BoletasScreen({super.key});

  @override
  State<BoletasScreen> createState() => _BoletasScreenState();
}

class _BoletasScreenState extends State<BoletasScreen> {
  final BoletaRepository _repository = BoletaRepository();
  late List<Boleta> _boletas;
  @override
  void initState() {
    super.initState();
    _boletas = _repository.getBoletas();
  }

  Future<void> _updateBoleta(Boleta updateBoleta) async {
    await _repository.updateBoleta(updateBoleta);
    setState(() {
      final index = _boletas.indexWhere((b) => b.no == updateBoleta.no);
      if (index != -1) {
        _boletas[index] = updateBoleta;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BoletasTable(
      boletas: _boletas,
      onBoletaUpdated: _updateBoleta,
    );
  }
}
