
import 'package:cabofind/paginas_listas/list__com_joyerias.dart';
import 'package:cabofind/paginas_listas/list__com_moda.dart';
import 'package:cabofind/paginas_listas/list__com_regalos.dart';
import 'package:cabofind/paginas_listas/list__com_tiendas.dart';
import 'package:cabofind/paginas_listas/list__edu_abierta.dart';
import 'package:cabofind/paginas_listas/list__edu_cursos.dart';
import 'package:cabofind/paginas_listas/list__edu_guarderias.dart';
import 'package:cabofind/paginas_listas/list__edu_infantil.dart';
import 'package:cabofind/paginas_listas/list__edu_universidades.dart';
import 'package:cabofind/paginas_listas/list_serv_prov.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Educacion extends StatefulWidget {
@override
_Compras createState() => new _Compras();
}

class _Compras extends State<Educacion> {
  int id=0;
@override
Widget build(BuildContext context) {
  final tabpages=<Widget>[
    new ListaGuarderias(),
    new ListaInfantil(),
    new ListaUniversidades(),
    new ListaCursos(),
    new ListaAbierta(),

  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.baby,),title: Text("Guarderías")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.child,),title: Text("Infantil")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userGraduate,),title: Text("Universidades")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.bookOpen,),title: Text("Cursos")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.school,),title: Text("Abierta")),


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
      title: new Text('Educación'),
    ),
  );
}
}