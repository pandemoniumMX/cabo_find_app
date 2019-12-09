
import 'package:cabofind/paginas_listas_ing/list__edu_abierta.dart';
import 'package:cabofind/paginas_listas_ing/list__edu_cursos.dart';
import 'package:cabofind/paginas_listas_ing/list__edu_guarderias.dart';
import 'package:cabofind/paginas_listas_ing/list__edu_infantil.dart';
import 'package:cabofind/paginas_listas_ing/list__edu_universidades.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Educacion_ing extends StatefulWidget {
@override
_Compras_ing createState() => new _Compras_ing();
}

class _Compras_ing extends State<Educacion_ing> {
  int id=0;

  @override
Widget build(BuildContext context) {
  final tabpages=<Widget>[
    //llamar classes siempre despues de un <Widget>
    //lo que se declare aqui, sera el contenido de los botones de navigacion al fondo
    new ListaGuarderias_ing(),
    new ListaInfantil_ing(),
    new ListaUniversidades_ing(),
    new ListaCursos_ing(),
    new ListaAbierta_ing(),



  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.baby,),title: Text("Day care")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.child,),title: Text("Childish")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userGraduate,),title: Text("Universities")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.bookOpen,),title: Text("Courses")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.school,),title: Text("Open")),


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
      title: new Text('Education'),
    ),
  );
}
}