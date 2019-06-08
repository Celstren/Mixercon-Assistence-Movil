import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mixercon_assistance/Controladores/controlador_empleado.dart';
import 'package:mixercon_assistance/Controladores/controlador_marcar_asistencia.dart';
import 'package:mixercon_assistance/Modelos/modelo_marca.dart';
import 'package:mixercon_assistance/Modelos/modelo_sede.dart';
import 'package:mixercon_assistance/Modelos/modelo_usuario.dart';
import 'package:mixercon_assistance/Utils/screen_utils.dart';

class VistaMarcarAsistencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VistaMarcarAsistenciaState();
}

class VistaMarcarAsistenciaState extends State<VistaMarcarAsistencia> {
  LocationData _startLocation;
  LocationData _currentLocation;

  StreamSubscription<LocationData> _locationSubscription;

  Location _locationService = new Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _initialCamera = CameraPosition(
    target: LatLng(0, 0),
    zoom: 4,
  );

  CameraPosition _currentCameraPosition;
  LatLng posicionEmpleado;

  GoogleMap googleMap;

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();

          _locationSubscription = _locationService
              .onLocationChanged()
              .listen((LocationData result) async {
            _currentCameraPosition = CameraPosition(
                target: LatLng(result.latitude, result.longitude), zoom: 16);
            posicionEmpleado = LatLng(result.latitude, result.longitude);
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(
                CameraUpdate.newCameraPosition(_currentCameraPosition));

            if (mounted) {
              setState(() {
                _currentLocation = result;
              });
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
      _startLocation = location;
    });
  }

  actualizarPosicionMapa(double _latitud, double _longitud) async {

    final GoogleMapController controller = await _controller.future;
    _currentCameraPosition = CameraPosition(target: LatLng(_latitud, _longitud), zoom: 16);
    controller
        .animateCamera(CameraUpdate.newCameraPosition(_currentCameraPosition));
  }

  realizarMarca(Usuario usuario) {
    Marca nuevaMarca = Marca();

    nuevaMarca.usuarioId = usuario.usuarioId;
    nuevaMarca.respuesta = "Prueba desde flutter";
    nuevaMarca.longitud =posicionEmpleado.longitude;
    nuevaMarca.latitud = posicionEmpleado.latitude;
    nuevaMarca.horaMarca = DateTime.now();
    nuevaMarca.minutosDiferencia = 30;
    nuevaMarca.tipoMarca = 1;

    controladorMarcarAsistencia.guardarMarca(nuevaMarca);

  }

  @override
  Widget build(BuildContext context) {
    googleMap = GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      initialCameraPosition: _initialCamera,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );

    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;

    // TODO: implement build
    return Stack(
      children: <Widget>[
        googleMap,
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: hp(10),
            margin: EdgeInsets.symmetric(vertical: hp(5), horizontal: wp(1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                StreamBuilder<Usuario>(
                  stream: controladorEmpleado.streamUsuario,
                  builder: (context, empleadoSnapshot){
                    return GestureDetector(
                      onTap: (){
                        if (empleadoSnapshot.hasData){
                          realizarMarca(empleadoSnapshot.data);
                        }
                      },
                      child: Container(
                        height: hp(10),
                        width: wp(70),
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(color: Colors.white, width: wp(.5))
                        ),
                        child: Center(
                          child: Text(empleadoSnapshot.hasData?'Marcar':'Cargando', style: TextStyle(fontSize: wp(8), color: Colors.white),),
                        ),
                      ),
                    );
                  },
                ),
                StreamBuilder<Sede>(
                  stream: controladorEmpleado.streamSede,
                  builder: (context, sedeSnapshot){
                    return GestureDetector(
                      onTap: () {
                        if (sedeSnapshot.hasData){
                          setState(() {
                            actualizarPosicionMapa(sedeSnapshot.data.latitud, sedeSnapshot.data.longitud);
                          });
                        }
                      },
                      child: Container(
                        height: hp(10),
                        width: wp(20),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: wp(.5))
                        ),
                        child: Center(
                          child: Text(
                            sedeSnapshot.hasData? 'Ir a sede' : 'Buscando...',
                            style: TextStyle(fontSize: wp(3), color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
