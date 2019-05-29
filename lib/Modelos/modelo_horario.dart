// To parse this JSON data, do
//
//     final horario = horarioFromJson(jsonString);

import 'dart:convert';

Horario horarioFromJson(String str) => Horario.fromJson(json.decode(str));

String horarioToJson(Horario data) => json.encode(data.toJson());

class Horario {
  int horarioId;
  DateTime fechaInicio;
  DateTime fechaFin;
  int usuarioId;

  Horario({
    this.horarioId,
    this.fechaInicio,
    this.fechaFin,
    this.usuarioId,
  });

  factory Horario.fromJson(Map<String, dynamic> json) => new Horario(
    horarioId: json["HorarioID"],
    fechaInicio: json["Fecha_Inicio"],
    fechaFin: json["Fecha_Fin"],
    usuarioId: json["UsuarioID"],
  );

  Map<String, dynamic> toJson() => {
    "HorarioID": horarioId,
    "Fecha_Inicio": fechaInicio,
    "Fecha_Fin": fechaFin,
    "UsuarioID": usuarioId,
  };

  Horario getFromDBbyId(int horarioId){
    Horario horario = Horario();
    return horario;
  }

  Horario getFromDBbyUsuarioId(int usuarioId){
    Horario horario = Horario();
    return horario;
  }

  List<Horario> getFromDBAll(){
    List<Horario> horarios = List<Horario>();
    return horarios;
  }

  int updateHorarioToDB(){
    return 0;
  }

  int deleteHorarioToDB(){
    return 0;
  }
}
