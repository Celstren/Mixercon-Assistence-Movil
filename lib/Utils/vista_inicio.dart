import 'package:flutter/material.dart';
import 'package:mixercon_assistance/Controladores/controlador_empleado.dart';
import 'package:mixercon_assistance/Controladores/controlador_sesion.dart';
import 'package:mixercon_assistance/Modelos/modelo_usuario.dart';
import 'package:mixercon_assistance/Utils/screen_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';

class VistaInicio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VistaInicioState();
}

class VistaInicioState extends State<VistaInicio> {
  @override
  void initState() {
    // TODO: implement initState
    controladorSesion.obtenerEmpleado();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    // TODO: implement build
    return Container(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(vertical: hp(3)),
            elevation: 10.0,
            child: Container(
              width: wp(100),
              height: hp(20),
              color: Colors.yellow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: StreamBuilder<Usuario>(
                        stream: controladorSesion.streamUsuario,
                        builder: (context, usuarioSnapshot) {
                          String nombre = usuarioSnapshot.hasData && usuarioSnapshot.data != null? usuarioSnapshot.data.nombre : "";
                          return AutoSizeText(
                            "Bienvenido $nombre!",
                            style: TextStyle(fontSize: wp(10)),
                            maxLines: 1,
                          );
                        }),
                  ),
                  Container(
                    child: AutoSizeText(
                      "Inicio de jornada:",
                      style: TextStyle(fontSize: wp(5)),
                    ),
                  ),
                  Container(
                    child: AutoSizeText(
                      "Fin de jornada:",
                      style: TextStyle(fontSize: wp(5)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
