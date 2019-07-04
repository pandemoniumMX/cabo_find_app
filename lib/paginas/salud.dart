
import 'package:cabofind/paginas_listas/list_sal_emergencia.dart';
import 'package:cabofind/paginas_listas/list_sal_especialidades.dart';
import 'package:cabofind/paginas_listas/list_sal_farmacias.dart';
import 'package:cabofind/paginas_listas/list_sal_gimnasios.dart';
import 'package:cabofind/paginas_listas/list_sal_hospitales.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Salud extends StatefulWidget {
@override
_Salud createState() => new _Salud();
}

class _Salud extends State<Salud> {
  int id=0;
@override
Widget build(BuildContext context) {
  final tabpages=<Widget>[
    new ListaHospitales(),
    new ListaEspecialidades(),
    new ListaFarmacias(),
    new ListaGimnasios(),
    new ListaEmergencia(),
  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.hospital,),title: Text("Hospitales")),    
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.hospitalSymbol,),title: Text("Especialidades")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.pills,),title: Text("Farmacias")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.dumbbell,),title: Text("Gimnasios")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.ambulance,),title: Text("Emergencia")),


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
      title: new Text('Salud'),
    ),
  );
}
}