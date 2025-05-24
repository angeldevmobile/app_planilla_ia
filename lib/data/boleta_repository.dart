import '../models/boleta_model.dart';

class BoletaRepository {
  List<Boleta> getBoletas() {
    //En una app real, esto vendría de una API o base de datos
    return [
      Boleta(
        no: '01',
        mes: 'ABRIL',
        ano: '2025',
        fechaPago: '12 Abr 2025',
        estado: 'Pendiente',
        completado: false,
      ),
      Boleta(
        no: '15',
        mes: 'ABRIL',
        ano: '2025',
        fechaPago: '29 May 2025',
        estado: 'Pendiente',
        completado: false,
      ),
      Boleta(
        no: '01',
        mes: 'MAYO',
        ano: '2025',
        fechaPago: '15 Jun 2025',
        estado: 'Pendiente',
        completado: false,
      ),
    ];
  }

  //Método para actualizar el estado de una boleta
  Future<void> updateBoleta(Boleta updateBoleta) async {
    //En una app real, esto vendría de una API o base de datos
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
