import 'package:mixercon_assistance/Modelos/modelo_marca.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_base.dart';

class MarcarAsistencia implements BlocBase {

  BehaviorSubject<Marca> _controladorMarca = BehaviorSubject<Marca>();
  Function(Marca) get pushMarca => _controladorMarca.sink.add;
  Stream<Marca> get streamMarca => _controladorMarca;

  BehaviorSubject<List<Marca>> _controladorMarcas = BehaviorSubject<List<Marca>>();
  Function(List<Marca>) get pushMarcas => _controladorMarcas.sink.add;
  Stream<List<Marca>> get streamMarcas => _controladorMarcas;

  validarMarca(){}

  guardarMarca(){}

  @override
  void dispose() {
    // TODO: implement dispose
    _controladorMarca.close();
    _controladorMarcas.close();
  }

}