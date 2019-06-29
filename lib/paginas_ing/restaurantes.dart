
import 'package:cabofind/paginas_listas_ing/list__rest_cafe.dart';
import 'package:cabofind/paginas_listas_ing/list__rest_ita.dart';
import 'package:cabofind/paginas_listas_ing/list__rest_mariscos.dart';
import 'package:cabofind/paginas_listas_ing/list__rest_mex.dart';
import 'package:cabofind/paginas_listas_ing/list__rest_oriental.dart';
import 'package:cabofind/paginas_listas_ing/list__rest_rapida.dart';
import 'package:cabofind/paginas_listas_ing/list__rest_snacks.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Restaurantes_ing extends StatefulWidget {
  int id=0;

  @override
  _Restaurantes_ing createState() => new _Restaurantes_ing();
}

class _Restaurantes_ing extends State<Restaurantes_ing> {
  int id=0;

  @override
Widget build(BuildContext context) {
  final tabpages=<Widget>[

    new ListaMexicanos_ing(),
    new ListaItalianos_ing(),
    new ListaOriental_ing(),
    new ListaMariscos_ing(),
    new ListaRapida_ing(),
    new ListaCafe_ing(),
    new ListaSnacks_ing(),
  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.pepperHot,),title: Text("Mexican")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.pizzaSlice,),title: Text("Italian")),
    BottomNavigationBarItem(icon: Icon(Icons.favorite,),title: Text("Oriental")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.fish,),title: Text("Seafood")),
    BottomNavigationBarItem(icon: Icon(Icons.fastfood,),title: Text("Fastfood")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.coffee,),title: Text("Coffe")),
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
title: new Text('Restaurants'),
),
);
}
}
