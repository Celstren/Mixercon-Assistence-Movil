import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mixercon_assistance/Controladores/controlador_empleado.dart';
import 'package:mixercon_assistance/Modelos/modelo_dia.dart';
import 'package:mixercon_assistance/Modelos/modelo_usuario.dart';
import 'package:mixercon_assistance/Utils/screen_utils.dart';

class VistaGestionEmpleado extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VistaGestionEmpleadoState();

}

class VistaGestionEmpleadoState extends State<VistaGestionEmpleado>{
  @override
  Widget build(BuildContext context) {

    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;

    // TODO: implement build

    Widget _construirDatosPersonales(String _nombre, String _sector, String _area, int _codigoEmpleado){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: wp(2)),
        padding: EdgeInsets.symmetric(horizontal: wp(2), vertical: hp(4)),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey[400],
              offset: Offset(0.0, 5.0),
              blurRadius: 5.0,
            )
          ]
        ),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: hp(2)),
                child: Text('Datos Personales', style: TextStyle(fontSize: wp(6)),),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Nombre', style: TextStyle(fontSize: wp(5)),),
                  Text(_nombre, style: TextStyle(fontSize: wp(5)),),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Sector', style: TextStyle(fontSize: wp(5)),),
                  Text(_sector, style: TextStyle(fontSize: wp(5)),),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Area', style: TextStyle(fontSize: wp(5)),),
                  Text(_area, style: TextStyle(fontSize: wp(5)),),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Código Empleado', style: TextStyle(fontSize: wp(5)),),
                  Text('$_codigoEmpleado', style: TextStyle(fontSize: wp(5)),),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _construirHorarios(){
      return StreamBuilder<List<Dia>>(
        stream: controladorEmpleado.streamDias,
        builder: (context, diasSnapshot){

          String Dia = "";

          return Container(
            margin: EdgeInsets.symmetric(horizontal: wp(2), vertical: hp(4)),
            padding: EdgeInsets.symmetric(horizontal: wp(2), vertical: hp(4)),
            decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(0.0, 5.0),
                    blurRadius: 5.0,
                  )
                ]
            ),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: hp(2)),
                    child: Text('Horario Asignado', style: TextStyle(fontSize: wp(6)),),
                  ),
                ),
                diasSnapshot.hasData? Container(
                  height: hp(16) * diasSnapshot.data.length,
                  child: ListView.builder(itemBuilder: (context, index){

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: hp(1)),
                      padding: EdgeInsets.symmetric(horizontal: wp(2)),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      height: hp(14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(diasSnapshot.data[index].nombre, style: TextStyle(fontSize: wp(5), color: Colors.white),),
                          Text(DateFormat('kk:mm').format(diasSnapshot.data[index].horaIngreso), style: TextStyle(fontSize: wp(5), color: Colors.white),),
                          Text(DateFormat('kk:mm').format(diasSnapshot.data[index].horaSalida), style: TextStyle(fontSize: wp(5), color: Colors.white),),
                        ],
                      ),
                    );
                  }, itemCount: diasSnapshot.data.length, physics: NeverScrollableScrollPhysics(),),
                ):Container(),
              ],
            ),
          );
        },
      );
    }

    return ListView(
      children: <Widget>[
        StreamBuilder<Usuario>(
          stream: controladorEmpleado.streamUsuario,
          builder: (context, empleadoSnapshot){

            String _nombre = "", _sector = "", _area = "";
            int _codigoEmpleado = 0;

            if (empleadoSnapshot.hasData){
              _nombre = empleadoSnapshot.data.nombre;
              _sector = empleadoSnapshot.data.sector;
              _area = empleadoSnapshot.data.area;
              _codigoEmpleado = empleadoSnapshot.data.codigoEmpleado;
            }

            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Text('PERFIL', style: TextStyle(fontSize: wp(10),),),
                      margin: EdgeInsets.symmetric(vertical: hp(4)),
                    ),
                  ),
                  _construirDatosPersonales(_nombre, _sector, _area, _codigoEmpleado),
                  _construirHorarios(),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

}