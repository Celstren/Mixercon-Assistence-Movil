import 'package:mixercon_assistance/Modelos/modelo_dia.dart' as ModeloDia;
import 'package:mixercon_assistance/Modelos/modelo_horario.dart' as ModeloHorario;
import 'package:mixercon_assistance/Modelos/modelo_marca.dart' as ModeloMarca;
import 'package:mixercon_assistance/Modelos/modelo_sede.dart' as ModeloSede;
import 'package:mixercon_assistance/Modelos/modelo_usuario.dart' as ModeloUsuario;
import 'package:rxdart/rxdart.dart';

import 'bloc_base.dart';

class EmpleadoBloc implements BlocBase{

  BehaviorSubject<ModeloUsuario.Usuario> _controladorUsuario = BehaviorSubject<ModeloUsuario.Usuario>();
  Function(ModeloUsuario.Usuario) get pushUsuario => _controladorUsuario.sink.add;
  Stream<ModeloUsuario.Usuario> get streamUsuario => _controladorUsuario;

  BehaviorSubject<List<ModeloUsuario.Usuario>> _controladorUsuarios = BehaviorSubject<List<ModeloUsuario.Usuario>>();
  Function(List<ModeloUsuario.Usuario>) get pushUsuarios => _controladorUsuarios.sink.add;
  Stream<List<ModeloUsuario.Usuario>> get streamUsuarios => _controladorUsuarios;

  BehaviorSubject<ModeloSede.Sede> _controladorSede = BehaviorSubject<ModeloSede.Sede>();
  Function(ModeloSede.Sede) get pushSede => _controladorSede.sink.add;
  Stream<ModeloSede.Sede> get streamSede => _controladorSede;

  BehaviorSubject<ModeloHorario.Horario> _controladorHorario = BehaviorSubject<ModeloHorario.Horario>();
  Function(ModeloHorario.Horario) get pushHorario => _controladorHorario.sink.add;
  Stream<ModeloHorario.Horario> get streamHorario => _controladorHorario;

  BehaviorSubject<List<ModeloDia.Dia>> _controladorDias = BehaviorSubject<List<ModeloDia.Dia>>();
  Function(List<ModeloDia.Dia>) get pushDias => _controladorDias.sink.add;
  Stream<List<ModeloDia.Dia>> get streamDias => _controladorDias;

  BehaviorSubject<ModeloMarca.Marca> _controladorMarca = BehaviorSubject<ModeloMarca.Marca>();
  Function(ModeloMarca.Marca) get pushMarca => _controladorMarca.sink.add;
  Stream<ModeloMarca.Marca> get streamMarca => _controladorMarca;

  BehaviorSubject<List<ModeloMarca.Marca>> _controladorMarcas = BehaviorSubject<List<ModeloMarca.Marca>>();
  Function(List<ModeloMarca.Marca>) get pushMarcas => _controladorMarcas.sink.add;
  Stream<List<ModeloMarca.Marca>> get streamMarcas => _controladorMarcas;

  BehaviorSubject<String> _controladorMensaje = BehaviorSubject<String>();
  Function(String) get pushMensaje => _controladorMensaje.sink.add;
  Stream<String> get streamMensaje => _controladorMensaje;

  obtenerListMarcas(){}

  obtenerDiasPorHorario(int horarioID) async {
    List<ModeloDia.Dia> dias = List<ModeloDia.Dia>();

    dias = await ModeloDia.getFromDBbyHorarioId(horarioID);

    if (dias.length > 0){
      pushDias(dias);
    }

  }

  obtenerHorario(int horarioID) async {
    ModeloHorario.Horario horario = ModeloHorario.Horario();

    horario = await ModeloHorario.getFromDBbyId(horarioID);

    if (horario.horarioId != null){
      obtenerDiasPorHorario(horario.horarioId);
      pushHorario(horario);
    }

  }

  obtenerMarca() {}

  obtenerEmpleado() async {
    ModeloUsuario.Usuario usuario = ModeloUsuario.Usuario();

    usuario = await ModeloUsuario.getFromDBbyId(71625040);

    if (usuario.usuarioId != null){
      obtenerHorario(usuario.horarioId);
      pushUsuario(usuario);
    }
  }

  obtenerEmpleados() async {
    List<ModeloUsuario.Usuario> usuarios = List<ModeloUsuario.Usuario>();

    usuarios = await ModeloUsuario.getFromDBAll();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controladorUsuario.close();
    _controladorSede.close();
    _controladorDias.close();
    _controladorMarca.close();
    _controladorMarcas.close();
    _controladorMensaje.close();
    _controladorUsuarios.close();
  }

}

EmpleadoBloc controladorEmpleado = EmpleadoBloc();