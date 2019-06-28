
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
@override
Widget build(BuildContext context) {
  final tabpages=<Widget>[

    new ListaMexicanos(),
    new ListaItalianos(),
    new ListaCafe(),
    new ListaOriental(),
    new ListaMariscos(),
    new ListaRapida(),
    new ListaSnacks(),



  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.pepperHot,),title: Text("Mexicano")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.pizzaSlice,),title: Text("Italiano")),
    BottomNavigationBarItem(icon: Icon(Icons.favorite,),title: Text("Oriental")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.fish,),title: Text("Marisco")),
    BottomNavigationBarItem(icon: Icon(Icons.fastfood,),title: Text("Rápida")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.coffee,),title: Text("Café")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.cookieBite,),title: Text("Snack")),


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
