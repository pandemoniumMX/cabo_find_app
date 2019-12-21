
import 'package:cabofind/paginas_listas/list__rest_cafe.dart';
import 'package:cabofind/paginas_listas/list__rest_ita.dart';
import 'package:cabofind/paginas_listas/list__rest_mariscos.dart';
import 'package:cabofind/paginas_listas/list__rest_mex.dart';
import 'package:cabofind/paginas_listas/list__rest_oriental.dart';
import 'package:cabofind/paginas_listas/list__rest_rapida.dart';
import 'package:cabofind/paginas_listas/list__rest_snacks.dart';
import 'package:cabofind/paginas_listas/list_manejador.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Restaurantes extends StatefulWidget {


  @override
_Restaurantes createState() => new _Restaurantes();
}

class _Restaurantes extends State<Restaurantes> {
  int id=0;
  int cat =60;//restaurantes
  int sub1 =26;//ita
  int sub2 =27;//mex
  int sub3 =28;//mariscos
  int sub4 =29;//fast
  int sub5 =30;//oriental
  int sub6 =31;//otros
  int sub7 =32;//snacks

@override
Widget build(BuildContext context) {
  final tabpages=<Widget>[


    new Lista_Manejador_esp(manejador: new Lista_manejador(cat,sub2)),
    new Lista_Manejador_esp(manejador: new Lista_manejador(cat,sub1)),
    new Lista_Manejador_esp(manejador: new Lista_manejador(cat,sub5)),
    new Lista_Manejador_esp(manejador: new Lista_manejador(cat,sub3)),
    new Lista_Manejador_esp(manejador: new Lista_manejador(cat,sub4)),
    new Lista_Manejador_esp(manejador: new Lista_manejador(cat,sub6)),
    new Lista_Manejador_esp(manejador: new Lista_manejador(cat,sub7)),



  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.pepperHot,),title: Text("Mexicano")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.pizzaSlice,),title: Text("Italiano")),
    BottomNavigationBarItem(icon: Icon(Icons.favorite,),title: Text("Oriental")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.fish,),title: Text("Mariscos")),
    BottomNavigationBarItem(icon: Icon(Icons.fastfood,),title: Text("Rápida")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.utensils,),title: Text("Otros")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.iceCream,),title: Text("Snack")),


  ];


  final bnb=BottomNavigationBar(

    items: bnbi,
    currentIndex:id ,
    type: BottomNavigationBarType.fixed,
    onTap: (int value){
      setState(() {
        id=value;
      });
    },
  );

return new Scaffold(
  body: tabpages[id],
  bottomNavigationBar: bnb,
appBar: new AppBar(
title: new Text('Restaurantes'),
),
);
}
}
