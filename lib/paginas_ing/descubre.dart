
import 'package:cabofind/paginas_listas_ing/list__des_acuaticas.dart';
import 'package:cabofind/paginas_listas_ing/list__des_aereas.dart';
import 'package:cabofind/paginas_listas_ing/list__des_cultura.dart';
import 'package:cabofind/paginas_listas_ing/list__des_eventos.dart';
import 'package:cabofind/paginas_listas_ing/list__des_playas.dart';
import 'package:cabofind/paginas_listas_ing/list__des_terrestres.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Descubre_ing extends StatefulWidget {

@override
_Descubre_ing createState() => new _Descubre_ing();
}

class _Descubre_ing extends State<Descubre_ing> {
  int id=0;

  @override
Widget build(BuildContext context) {
  final tabpages=<Widget>[

    new ListaAcuaticas_ing(),
    new ListaTerrestres_ing(),
    new ListaAereas_ing(),
    //new ListaEventos_ing(),
    new ListaCultura_ing(),
    new ListaPlayas_ing(),

  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.swimmer,),title: Text("Water")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.bicycle,),title: Text("Land")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.telegramPlane,),title: Text("Air")),
    //BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.theaterMasks,),title: Text("Events")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.bookmark,),title: Text("Culture")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.umbrellaBeach,),title: Text("Beaches")),



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
      title: new Text('¿What to do?'),
    ),
  );
}
}