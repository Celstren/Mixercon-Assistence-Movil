import 'package:flutter/material.dart';
import 'package:mixercon_assistance/Controladores/controlador_empleado.dart';
import 'package:mixercon_assistance/Utils/screen_utils.dart';

class VistaInicioSesion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VistaInicioSesionState();
}

class VistaInicioSesionState extends State<VistaInicioSesion> {

  String codigoEmpleado = "", contrasena = "";

  bool validarCodigo(String value) {
    Pattern pattern = "[0-9]";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  @override
  Widget build(BuildContext context) {

    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;

    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Spacer(),
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                child: Text('INICIAR SESIÓN', textAlign: TextAlign.center, style: TextStyle(fontSize: wp(10)),),
              ),
            ),
          ),
          Spacer(),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: wp(4)),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Código de empleado'),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: TextField(
                                onChanged: (value){
                                  setState(() {
                                    codigoEmpleado = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: "Ingresar código de empleado"
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Contraseña'),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: TextField(
                                onChanged: (value){
                                  setState(() {
                                    contrasena = value;
                                  });
                                },
                                decoration: InputDecoration(
                                    hintText: "Ingresar contraseña"
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: (){
                if (codigoEmpleado.trim().isNotEmpty && contrasena.trim().isNotEmpty){

                  showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          children: <Widget>[
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      });

                  if (validarCodigo(codigoEmpleado.trim())){
                    controladorEmpleado.obtenerEmpleadoLogin(codigoEmpleado, contrasena, context);
                  }else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            children: <Widget>[
                              Center(
                                child: Text('Codigo no válido\nEn caso no recordar consultar con su administrador', textAlign: TextAlign.center,),
                              ),
                            ],
                          );
                        });
                  }
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          children: <Widget>[
                            Center(
                              child: Text('Falta completar campos obligatorios', textAlign: TextAlign.center,),
                            ),
                          ],
                        );
                      });
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: wp(4)),
                color: Colors.blue,
                child: Center(
                  child: Text('INGRESAR', textAlign: TextAlign.center, style: TextStyle(fontSize: wp(10), color: Colors.white),),
                ),
              ),
            ),
          ),
          Spacer(),
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                child: Text('OLVIDÉ MI CONTRASEÑA', textAlign: TextAlign.center, style: TextStyle(fontSize: wp(4), color: Colors.blue),),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
