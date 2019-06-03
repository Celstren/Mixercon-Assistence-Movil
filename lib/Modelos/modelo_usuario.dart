// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

final String URLBase = "https://telonetavo.000webhostapp.com/Conexion/Metodos_Usuario/";

class Usuario {
  int usuarioId;
  String nombre;
  String estado;
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
    usuarioId: int.parse(json["UsuarioID"]),
    nombre: json["Nombre"],
    estado: json["Estado"],
    sector: json["Sector"],
    contrasena: json["Contrasena"],
    area: json["Area"],
    codigoEmpleado: int.parse(json["Codigo_Empleado"]),
    horarioId: int.parse(json["HorarioID"]),
    sedeId: int.parse(json["SedeID"]),
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

  Future<Usuario> getFromDBbyId(int usuarioId) async {
    Usuario usuario = Usuario();

    final response =
    await http.get(URLBase + 'Obtener_Usuario.php?Codigo=$usuarioId');
    if (response.statusCode == 200){
      final data = json.decode(response.body);
      usuario = Usuario.fromJson(data["resultado"][0]);
      print(usuario.nombre);
    } else {
      throw Exception('Fallo al conseguir datos de la base de datos');
    }

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
