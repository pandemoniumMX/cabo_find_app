import 'package:flutter/material.dart';
class Costos {
  final String paquete; 
  final String costo; 

  Costos(this.paquete,this.costo);
}

class Reserva {
  final String tipo_r; 
  final String tipo_n; 
  final String nombre; 
  final String id; 
  final String correo; 

  Reserva(this.tipo_r,this.tipo_n,this.nombre,this.id,this.correo);
}

class Empresa {
  final String id_nm; 
  Empresa(this.id_nm);
}

class Publicacion {   
  final String id_n; 
  final String id_p;
  Publicacion(this.id_n, this.id_p);  
}

class Anuncios_clase {
  final String id_anun; 
  Anuncios_clase(this.id_anun);
}

class Categorias {
  final int id;
  final String position;
  final String company;
  final String description;

  Categorias({this.id, this.position, this.company, this.description});

  factory Categorias.fromJson(Map<String, dynamic> json) {
    return Categorias(
      id: json['id'],
      position: json['position'],
      company: json['company'],
      description: json['description'],
    );
  }
}


