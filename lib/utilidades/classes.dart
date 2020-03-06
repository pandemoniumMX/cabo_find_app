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

class Lista_manejador {
  final int id_cat;
  final int id_sub;  
  Lista_manejador(this.id_cat,this.id_sub);

}

class Note {
  String id_n;
  String title;
  String foto;
  String sub;

  String cat;
  String id;



  Note(this.title, this.foto,this.id_n,this.sub,this.cat,this.id);

  Note.fromJson(Map<String, dynamic> json) {
    id_n = json['NEG_ETIQUETAS_ING'];
    title = json['NEG_NOMBRE'];
    foto = json['GAL_FOTO'];
    sub = json['NEG_LUGAR'];
    cat = json['SUB_NOMBRE_ING'];
    id = json['ID_NEGOCIO'];

  }
}