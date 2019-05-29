// To parse this JSON data, do
//
//     final dia = diaFromJson(jsonString);

import 'dart:convert';

Dia diaFromJson(String str) => Dia.fromJson(json.decode(str));

String diaToJson(Dia data) => json.encode(data.toJson());

class Dia {
  int diaId;
  String nombre;
  DateTime fechaActual;
  DateTime horaIngreso;
  DateTime horaSalida;
  int minutosTolerancia;
  int horarioId;

  Dia({
    this.diaId,
    this.nombre,
    this.fechaActual,
    this.horaIngreso,
    this.horaSalida,
    this.minutosTolerancia,
    this.horarioId,
  });

  factory Dia.fromJson(Map<String, dynamic> json) => new Dia(
    diaId: json["DiaID"],
    nombre: json["Nombre"],
    fechaActual: json["Fecha_Actual"],
    horaIngreso: json["Hora_Ingreso"],
    horaSalida: json["Hora_Salida"],
    minutosTolerancia: json["Minutos_Tolerancia"],
    horarioId: json["HorarioID"],
  );

  Map<String, dynamic> toJson() => {
    "DiaID": diaId,
    "Nombre": nombre,
    "Fecha_Actual": fechaActual,
    "Hora_Ingreso": horaIngreso,
    "Hora_Salida": horaSalida,
    "Minutos_Tolerancia": minutosTolerancia,
    "HorarioID": horarioId,
  };

  Dia getFromDBbyId(int diaId){
    Dia dia = Dia();
    return dia;
  }

  Dia getFromDBbyHorarioId(int horarioId){
    Dia dia = Dia();
    return dia;
  }

  List<Dia> getFromDBAll(){
    List<Dia> dias = List<Dia>();
    return dias;
  }

  int updateDiaToDB(){
    return 0;
  }

  int modifyDiaToDB(){
    return 0;
  }
}
