
import 'package:cabofind/paginas_listas/list__rest_cafe.dart';
import 'package:cabofind/paginas_listas/list__rest_ita.dart';
import 'package:cabofind/paginas_listas/list__rest_mariscos.dart';
import 'package:cabofind/paginas_listas/list__rest_mex.dart';
import 'package:cabofind/paginas_listas/list__rest_oriental.dart';
import 'package:cabofind/paginas_listas/list__rest_rapida.dart';
import 'package:cabofind/paginas_listas/list__rest_snacks.dart';
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

    new ListaMexicanos(),
    new ListaItalianos(),
    new ListaOriental(),
    new ListaMariscos(),
    new ListaRapida(),
    new ListaCafe(),
    new ListaSnacks(),
    /*new Lista_Manejador_esp(manejador: new Lista_manejador(cat,27)),
    new Lista_Manejador_esp(manejador: new Lista_manejador(cat,26)),
    new Lista_Manejador_esp(manejador: new Lista_manejador(cat,30)),
    new Lista_Manejador_esp(manejador: new Lista_manejador(cat,28)),
    new Lista_Manejador_esp(manejador: new Lista_manejador(cat,29)),
    new Lista_Manejador_esp(manejador: new Lista_manejador(cat,31)),
    new Lista_Manejador_esp(manejador: new Lista_manejador(cat,32)),*/



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
