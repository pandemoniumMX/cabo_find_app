
import 'package:cabofind/paginas_listas_ing/list_sal_emergencia.dart';
import 'package:cabofind/paginas_listas_ing/list_sal_especialidades.dart';
import 'package:cabofind/paginas_listas_ing/list_sal_farmacias.dart';
import 'package:cabofind/paginas_listas_ing/list_sal_gimnasios.dart';
import 'package:cabofind/paginas_listas_ing/list_sal_hospitales.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Salud_ing extends StatefulWidget {
@override
_Salud_ing createState() => new _Salud_ing();
}

class _Salud_ing extends State<Salud_ing> {
  int id=0;

  @override
Widget build(BuildContext context) {
  final tabpages=<Widget>[
    new ListaHospitales_ing(),
    new ListaEspecialidades_ing(),
    new ListaFarmacias_ing(),
    new ListaGimnasios_ing(),
    new ListaEmergencia_ing(),
  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.hospital,),title: Text("Hospitals")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.hospitalSymbol,),title: Text("Specialties")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.pills,),title: Text("Pharmacy")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.dumbbell,),title: Text("Gym")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.ambulance,),title: Text("Emergency")),


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
      title: new Text('Healht'),
    ),
  );
}
}