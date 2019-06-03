import 'package:mixercon_assistance/Modelos/modelo_usuario.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_base.dart';

class ControladorSesion implements BlocBase {

  BehaviorSubject<Usuario> _controladorUsuario = BehaviorSubject<Usuario>();
  Function(Usuario) get pushUsuario => _controladorUsuario.sink.add;
  Stream<Usuario> get streamUsuario => _controladorUsuario;

  validarFormatoDatos(){}

  validarEmpleadoRegistrado(){}

  @override
  void dispose() {
    // TODO: implement dispose
  }

}