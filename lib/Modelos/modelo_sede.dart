// To parse this JSON data, do
//
//     final sede = sedeFromJson(jsonString);

import 'dart:convert';

Sede sedeFromJson(String str) => Sede.fromJson(json.decode(str));

String sedeToJson(Sede data) => json.encode(data.toJson());

class Sede {
  int sedeId;
  String nombre;
  double latitud;
  double longitud;

  Sede({
    this.sedeId,
    this.nombre,
    this.latitud,
    this.longitud,
  });

  factory Sede.fromJson(Map<String, dynamic> json) => new Sede(
    sedeId: json["SedeID"],
    nombre: json["Nombre"],
    latitud: json["Latitud"].toDouble(),
    longitud: json["Longitud"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "SedeID": sedeId,
    "Nombre": nombre,
    "Latitud": latitud,
    "Longitud": longitud,
  };

  Sede getFromDBbyId(int sedeId){
    Sede sede = Sede();
    return sede;
  }

  List<Sede> getFromDBAll(){
    List<Sede> sedes = List<Sede>();
    return sedes;
  }

  int updateSedeToDB(){
    return 0;
  }

  int deleteSedeToDB(){
    return 0;
  }
}
