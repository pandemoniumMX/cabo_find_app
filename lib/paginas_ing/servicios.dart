
import 'package:cabofind/paginas_listas_ing/list_serv_auto.dart';
import 'package:cabofind/paginas_listas_ing/list_serv_bancos.dart';
import 'package:cabofind/paginas_listas_ing/list_serv_mascotas.dart';
import 'package:cabofind/paginas_listas_ing/list_serv_prof.dart';
import 'package:cabofind/paginas_listas_ing/list_serv_trans.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Servicios_ing extends StatefulWidget {
@override
_Servicios_ing createState() => new _Servicios_ing();
}

class _Servicios_ing extends State<Servicios_ing> {
  int id=0;

  @override
Widget build(BuildContext context) {
  final tabpages=<Widget>[
    new ListaAutomotriz_ing(),
    new ListaBancos_ing(),
    new ListaProfesionales_ing(),
    new ListaTransporte_ing(),
    new ListaMascotas_ing(),
  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.car,),title: Text("Car service")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.piggyBank,),title: Text("Banks")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userTie,),title: Text("Professionals")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.taxi,),title: Text("Transport")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.dog,),title: Text("Pets")),



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
      title: new Text('Services'),
    ),
  );
}
}