
import 'package:cabofind/paginas_listas/list__des_acuaticas.dart';
import 'package:cabofind/paginas_listas/list__des_aereas.dart';
import 'package:cabofind/paginas_listas/list__des_cultura.dart';
import 'package:cabofind/paginas_listas/list__des_eventos.dart';
import 'package:cabofind/paginas_listas/list__des_playas.dart';
import 'package:cabofind/paginas_listas/list__des_terrestres.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Descubre extends StatefulWidget {
@override
_Descubre createState() => new _Descubre();
}

class _Descubre extends State<Descubre> {
  int id=0;
@override
Widget build(BuildContext context) {
  final tabpages=<Widget>[

    new ListaAcuaticas(),
    new ListaTerrestres(),
    new ListaAereas(),
    new ListaCultura(),
    new ListaPlayas(),



  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.swimmer,),title: Text("Acuáticas")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.bicycle,),title: Text("Terrestres")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.telegramPlane,),title: Text("Aéreas")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.bookmark,),title: Text("Cultura")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.umbrellaBeach,),title: Text("Playas")),



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
      title: new Text('Que hacer?'),
    ),
  );
}
}