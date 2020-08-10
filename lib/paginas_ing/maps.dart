
import 'package:cabofind/utilidades/maps_actividades.dart';
import 'package:cabofind/utilidades/maps_compras.dart';
import 'package:cabofind/utilidades/maps_fiesta.dart';
import 'package:cabofind/utilidades/maps_restaurantes.dart';
import 'package:cabofind/utilidades/maps_salud.dart';
import 'package:cabofind/utilidades/maps_servicios.dart';
import 'package:cabofind/utilidades_ing/maps_actividades.dart';
import 'package:cabofind/utilidades_ing/maps_compras.dart';
import 'package:cabofind/utilidades_ing/maps_fiesta.dart';
import 'package:cabofind/utilidades_ing/maps_restaurantes.dart';
import 'package:cabofind/utilidades_ing/maps_salud.dart';
import 'package:cabofind/utilidades_ing/maps_servicios.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Maps_ing extends StatefulWidget {
@override
_Compras createState() => new _Compras();
}

class _Compras extends State<Maps_ing> {
  int id=0;
@override
Widget build(BuildContext context) {
  final tabpages=<Widget>[
    new Maps_restaurantes_ing(),
    new Maps_fiesta_ing(),
    new Maps_actividades_ing(),
    new Maps_compras_ing(),
    new Maps_servicios_ing(),
    new Maps_salud_ing(),

  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.utensils,),title: Text("Restaurants")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.cocktail,),title: Text("Party")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.biking,),title: Text("Activities")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.shoppingBag,),title: Text("Shopping")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.conciergeBell,),title: Text("Services")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.heartbeat,),title: Text("Health")),


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
      title: new Text('Maps'),
    ),
  );
}
}