// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  int usuarioId;
  String nombre;
  int estado;
  String sector;
  String contrasena;
  String area;
  int codigoEmpleado;
  int horarioId;
  int sedeId;

  Usuario({
    this.usuarioId,
    this.nombre,
    this.estado,
    this.sector,
    this.contrasena,
    this.area,
    this.codigoEmpleado,
    this.horarioId,
    this.sedeId,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => new Usuario(
    usuarioId: json["UsuarioID"],
    nombre: json["Nombre"],
    estado: json["Estado"],
    sector: json["Sector"],
    contrasena: json["Contrasena"],
    area: json["Area"],
    codigoEmpleado: json["Codigo_Empleado"],
    horarioId: json["HorarioID"],
    sedeId: json["SedeID"],
  );

  Map<String, dynamic> toJson() => {
    "UsuarioID": usuarioId,
    "Nombre": nombre,
    "Estado": estado,
    "Sector": sector,
    "Contrasena": contrasena,
    "Area": area,
    "Codigo_Empleado": codigoEmpleado,
    "HorarioID": horarioId,
    "SedeID": sedeId,
  };

  Usuario getFromDBbyId(int usuarioId){
    Usuario usuario = Usuario();
    return usuario;
  }

  List<Usuario> getFromDBAll(){
    List<Usuario> usuarios = List<Usuario>();
    return usuarios;
  }

  int updateUsuarioToDB(){
    return 0;
  }

  int deleteUsuarioToDB(){
    return 0;
  }
}
