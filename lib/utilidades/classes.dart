import 'package:flutter/material.dart';

class Empresa {
  final String id;
  final String nombre;
  final String cat;
  final String subs;
  final String logo;
  final String etiquetas;
  final String desc;
  final String maps;

  Empresa(this.id,this.nombre,this.cat,this.subs,this.logo,this.etiquetas, this.desc,this.maps);
}

class Publicacion {
  final String id_n;
  final String id;
  final String nombre;
  final String neg;
  final String cat;
  final String subs;
  final String logo;
  final String titulo;
  final String det;
  final String fec;
  final String vid;
  

  Publicacion(this.id_n,this.id,this.nombre,this.cat,this.neg,this.subs,this.logo,this.titulo, this.det,this.fec,this.vid);
}