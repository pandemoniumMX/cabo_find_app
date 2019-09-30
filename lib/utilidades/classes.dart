import 'package:flutter/material.dart';

class Empresa {
  final String id_nm; 
  Empresa(this.id_nm);



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
  final String tel;
  final String cor;
  

  Publicacion(this.id_n,this.id,this.nombre,this.neg,this.cat,this.subs,this.logo,this.titulo, this.det,this.fec,this.vid,this.tel,this.cor);
}