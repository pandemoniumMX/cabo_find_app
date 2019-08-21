
import 'package:cabofind/paginas_listas/list_serv_auto.dart';
import 'package:cabofind/paginas_listas/list_serv_bancos.dart';
import 'package:cabofind/paginas_listas/list_serv_prof.dart';
import 'package:cabofind/paginas_listas/list_serv_trans.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Servicios extends StatefulWidget {
@override
_Servicios createState() => new _Servicios();
}

class _Servicios extends State<Servicios> {
  int id=0;

  @override
Widget build(BuildContext context) {
  final tabpages=<Widget>[

    new ListaAutomotriz(),
    new ListaBancos(),
    new ListaProfesionales(),
    new ListaTransporte(),


  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.car,),title: Text("Automotriz")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.piggyBank,),title: Text("Bancos")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userTie,),title: Text("Profesionales")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.taxi,),title: Text("Transporte")),


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
      title: new Text('Servicios'),
    ),
  );
}
}