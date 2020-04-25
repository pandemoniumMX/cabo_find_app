

import 'package:cabofind/utilidades/maps_actividades.dart';
import 'package:cabofind/utilidades/maps_compras.dart';
import 'package:cabofind/utilidades/maps_educacion.dart';
import 'package:cabofind/utilidades/maps_fiesta.dart';
import 'package:cabofind/utilidades/maps_restaurantes.dart';
import 'package:cabofind/utilidades/maps_salud.dart';
import 'package:cabofind/utilidades/maps_servicios.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Maps extends StatefulWidget {
@override
_Compras createState() => new _Compras();
}

class _Compras extends State<Maps> {
  int id=0;
@override
Widget build(BuildContext context) {
  final tabpages=<Widget>[
    new Maps_restaurantes(),
    new Maps_fiesta(),
    new Maps_actividades(),
    new Maps_compras(),
    new Maps_servicios(),
    new Maps_salud(),
    new Maps_educacion()

  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.utensils,),title: Text("Restaurantes")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.cocktail,),title: Text("Fiesta")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.biking,),title: Text("Actividades")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.shoppingBag,),title: Text("Compras")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.conciergeBell,),title: Text("Servicios")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.heartbeat,),title: Text("Salud")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.school,),title: Text("Educación")),


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
      title: new Text('Mapas'),
    ),
  );
}
}