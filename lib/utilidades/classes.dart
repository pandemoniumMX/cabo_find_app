import 'package:flutter/material.dart';
import 'package:json_store/json_store.dart';

class Dish {
  final String name;
  final IconData icon;
  final Color color;

  Dish({this.name, this.icon, this.color});
}

/*
class Cart {
  String _orden;
  String _costo;
  String _notas;
  Cart(this._orden, this._costo, this._notas);

  Cart.fromJson(Map<String, dynamic> parsedJson)
      : _orden = parsedJson['_orden'],
        _costo = parsedJson['_costo'],
        _notas = parsedJson['_nota'];
  Map<String, dynamic> toJson() => {
        '_orden': _orden,
        '_costo': _costo,
        '_nota': _notas,
      };
}*/
class Cart {
  String orden;
  String costo;
  String nota;
  Cart(this.orden, this.costo, this.nota);
  Cart.fromJson(Map<String, dynamic> json)
      : this.orden = json['orden'],
        this.costo = json['costo'],
        this.nota = json['nota'];

  Map<String, dynamic> toJson() => {
        'orden': orden,
        'costo': costo,
        'nota': nota,
      };
}

class Users {
  final String correo;

  Users(this.correo);
}

class Categoria {
  final int cat;

  Categoria(this.cat);
}

class Lista_manejador {
  final int id_cat;
  final int id_sub;
  Lista_manejador(this.id_cat, this.id_sub);
}

class Costos {
  final String paquete;
  final String costo;

  Costos(this.paquete, this.costo);
}

class Reserva {
  final String tipo_r;
  final String tipo_n;
  final String nombre;
  final String id;
  final String correo;

  Reserva(this.tipo_r, this.tipo_n, this.nombre, this.id, this.correo);
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

class Publicacion2 {
  final String id_r;
  final String id_n;
  final String mail;
  Publicacion2(this.id_r, this.id_n, this.mail);
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
