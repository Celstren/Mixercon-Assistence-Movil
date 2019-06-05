import 'package:flutter/material.dart';
import 'package:mixercon_assistance/Controladores/controlador_empleado.dart';
import 'package:mixercon_assistance/Modelos/modelo_dia.dart';
import 'package:mixercon_assistance/Modelos/modelo_usuario.dart';
import 'package:mixercon_assistance/Utils/screen_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:mixercon_assistance/Utils/validators.dart' as Validators;

class VistaInicio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VistaInicioState();
}

class VistaInicioState extends State<VistaInicio> {
  @override
  void initState() {
    // TODO: implement initState
    controladorEmpleado.obtenerEmpleado();
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
                        stream: controladorEmpleado.streamUsuario,
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
                    child: StreamBuilder<List<Dia>>(
                      stream: controladorEmpleado.streamDias,
                        builder: (context, diaSnapshot){
                      String inicio = "";

                      if (diaSnapshot.hasData && diaSnapshot.data.length > 0){
                        diaSnapshot.data.forEach((d){
                          if (Validators.validateSameDays(d.fechaActual, DateTime.now())){
                            inicio = DateFormat('kk:mm').format(d.horaIngreso);
                          }
                        });
                      }

                      return AutoSizeText(
                        "Inicio de jornada: $inicio",
                        style: TextStyle(fontSize: wp(5)),
                      );
                    }),
                  ),
                  Container(
                    child: StreamBuilder<List<Dia>>(
                        stream: controladorEmpleado.streamDias,
                        builder: (context, diaSnapshot){
                          String fin = "";

                          if (diaSnapshot.hasData && diaSnapshot.data.length > 0){
                            diaSnapshot.data.forEach((d){
                              if (Validators.validateSameDays(d.fechaActual, DateTime.now()) || Validators.validateSameDays(d.horaSalida, DateTime.now())){
                                fin = DateFormat('kk:mm').format(d.horaSalida);
                              }
                            });
                          }

                          return AutoSizeText(
                            "Fin de jornada: $fin",
                            style: TextStyle(fontSize: wp(5)),
                          );
                        }),
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
