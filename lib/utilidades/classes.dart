import 'package:flutter/material.dart';

class Empresa {
  final String id_nm;
  final String nombre;
  final String cat;
  final String subs;
  final String logo;
  final String desc;
  final String maps;
  final String fb;
  final String inst;
  final String web;
  final String tel;
  final String mail;


  Empresa(this.id_nm,this.nombre,this.cat,this.subs,this.logo, this.desc,this.maps, this.fb,this.inst,this.web,this.tel, this.mail,);
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
  final String mail;

  Publicacion(this.id_n,this.id,this.nombre,this.cat,this.neg,this.subs,this.logo,this.titulo, this.det,this.fec,this.vid,this.tel,this.mail);
}