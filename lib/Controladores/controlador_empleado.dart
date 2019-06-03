import 'package:mixercon_assistance/Modelos/modelo_dia.dart';
import 'package:mixercon_assistance/Modelos/modelo_horario.dart';
import 'package:mixercon_assistance/Modelos/modelo_marca.dart';
import 'package:mixercon_assistance/Modelos/modelo_sede.dart';
import 'package:mixercon_assistance/Modelos/modelo_usuario.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_base.dart';

class EmpleadoBloc implements BlocBase{

  BehaviorSubject<Usuario> _controladorUsuario = BehaviorSubject<Usuario>();
  Function(Usuario) get pushUsuario => _controladorUsuario.sink.add;
  Stream<Usuario> get streamUsuario => _controladorUsuario;

  BehaviorSubject<Sede> _controladorSede = BehaviorSubject<Sede>();
  Function(Sede) get pushSede => _controladorSede.sink.add;
  Stream<Sede> get streamSede => _controladorSede;

  BehaviorSubject<Horario> _controladorHorario = BehaviorSubject<Horario>();
  Function(Horario) get pushHorario => _controladorHorario.sink.add;
  Stream<Horario> get streamHorario => _controladorHorario;

  BehaviorSubject<List<Dia>> _controladorDias = BehaviorSubject<List<Dia>>();
  Function(List<Dia>) get pushDias => _controladorDias.sink.add;
  Stream<List<Dia>> get streamDias => _controladorDias;

  BehaviorSubject<Marca> _controladorMarca = BehaviorSubject<Marca>();
  Function(Marca) get pushMarca => _controladorMarca.sink.add;
  Stream<Marca> get streamMarca => _controladorMarca;

  BehaviorSubject<List<Marca>> _controladorMarcas = BehaviorSubject<List<Marca>>();
  Function(List<Marca>) get pushMarcas => _controladorMarcas.sink.add;
  Stream<List<Marca>> get streamMarcas => _controladorMarcas;

  BehaviorSubject<String> _controladorMensaje = BehaviorSubject<String>();
  Function(String) get pushMensaje => _controladorMensaje.sink.add;
  Stream<String> get streamMensaje => _controladorMensaje;

  obtenerListMarcas(){}

  obtenerHorario(){

  }

  obtenerMarca() {}

  obtenerEmpleado() {}

//  obtenerDatosPrueba(){
//    Dia _dia = Dia();
//
//    _dia.getFromDBbyId(1);
//  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controladorUsuario.close();
    _controladorSede.close();
    _controladorDias.close();
    _controladorMarca.close();
    _controladorMarcas.close();
    _controladorMensaje.close();
  }

}

EmpleadoBloc empleadoBloc = EmpleadoBloc();