// To parse this JSON data, do
//
//     final marca = marcaFromJson(jsonString);

import 'dart:convert';

Marca marcaFromJson(String str) => Marca.fromJson(json.decode(str));

String marcaToJson(Marca data) => json.encode(data.toJson());

class Marca {
  int marcaId;
  int usuarioId;
  int tipoMarca;
  DateTime horaMarca;
  String respuesta;
  int minutosDiferencia;
  double latitud;
  double longitud;

  Marca({
    this.marcaId,
    this.usuarioId,
    this.tipoMarca,
    this.horaMarca,
    this.respuesta,
    this.minutosDiferencia,
    this.latitud,
    this.longitud,
  });

  factory Marca.fromJson(Map<String, dynamic> json) => new Marca(
    marcaId: json["MarcaID"],
    usuarioId: json["UsuarioID"],
    tipoMarca: json["Tipo_Marca"],
    horaMarca: json["Hora_Marca"],
    respuesta: json["Respuesta"],
    minutosDiferencia: json["Minutos_Diferencia"],
    latitud: json["Latitud"].toDouble(),
    longitud: json["Longitud"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "MarcaID": marcaId,
    "UsuarioID": usuarioId,
    "Tipo_Marca": tipoMarca,
    "Hora_Marca": horaMarca,
    "Respuesta": respuesta,
    "Minutos_Diferencia": minutosDiferencia,
    "Latitud": latitud,
    "Longitud": longitud,
  };

  Marca getFromDBbyId(int marcaId){
    Marca marca = Marca();
    return marca;
  }

  Marca getFromDBbyUsuarioId(int usuarioId){
    Marca marca = Marca();
    return marca;
  }

  List<Marca> getFromDBAll(){
    List<Marca> marcas = List<Marca>();
    return marcas;
  }

  int updateMarcaToDB(){
    return 0;
  }

  int deleteMarcaToDB(){
    return 0;
  }
}
