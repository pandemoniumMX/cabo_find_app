import 'package:cabofind/utilidades/classes.dart';
import 'package:cabofind/utilidades/maps_actividades.dart';
import 'package:cabofind/utilidades/maps_compras.dart';
import 'package:cabofind/utilidades/maps_educacion.dart';
import 'package:cabofind/utilidades/maps_fiesta.dart';
import 'package:cabofind/utilidades/maps_restaurantes.dart';
import 'package:cabofind/utilidades/maps_salud.dart';
import 'package:cabofind/utilidades/maps_servicios.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'list_manejador.dart';

class Maps extends StatefulWidget {


  @override
_Restaurantes createState() => new _Restaurantes();
}

class _Restaurantes extends State<Maps> {
  int id=0;
  int cat =63;//educacion
 
@override
int _page = 0;
  PageController _c;
  @override
  void initState(){
    _c =  new PageController(
      initialPage: _page,      
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
      title: new Text('Mapas'),
    ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _page,
        backgroundColor: Colors.black,
        fixedColor: Color(0xff01969a),
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        //unselectedIconTheme: Colors.grey,

        onTap: (index){
          this._c.animateToPage(index,duration: const Duration(milliseconds: 100),curve: Curves.bounceIn ); 
        },
        items: <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.utensils,),title: Text("Restaurantes")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.cocktail,),title: Text("Fiesta")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.biking,),title: Text("Actividades")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.shoppingBag,),title: Text("Compras")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.conciergeBell,),title: Text("Servicios")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.heartbeat,),title: Text("Salud")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.school,),title: Text("Educación")),

      ],

      ),
      body: new PageView(
        physics: const NeverScrollableScrollPhysics(),
        
        controller: _c,
        onPageChanged: (newPage){
          setState((){
            this._page=newPage;
          });
        },
        children: <Widget>[
    new Maps_restaurantes(),
    new Maps_fiesta(),
    new Maps_actividades(),
    new Maps_compras(),
    new Maps_servicios(),
    new Maps_salud(),
    new Maps_educacion(),
        ],
      ),
    );
  }
}