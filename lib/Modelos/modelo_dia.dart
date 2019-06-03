// To parse this JSON data, do
//
//     final dia = diaFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

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
    print(fetchPost());

    return dia;
  }

  Future<Post> fetchPost() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/posts/1');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      Post _post = Post.fromJson(json.decode(response.body));
      print(_post.title);
      return _post;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
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

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}