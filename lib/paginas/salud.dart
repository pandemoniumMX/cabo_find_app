
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'list_manejador.dart';

class Salud extends StatefulWidget {


  @override
_Restaurantes createState() => new _Restaurantes();
}

class _Restaurantes extends State<Salud> {
  int id=0;
  int cat =69;//salud
 
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
      title: new Text('Salud'),
    ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _page,
        backgroundColor: Colors.black,
        fixedColor: Color(0xff01969a),
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: false,
        //unselectedIconTheme: Colors.grey,

        onTap: (index){
          this._c.animateToPage(index,duration: const Duration(milliseconds: 10),curve: Curves.easeInOut);
        },
        items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.hospital,),title: Text("Hospitales")),    
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.hospitalSymbol,),title: Text("Consultorios")),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.pills,),title: Text("Farmacias")),
        BottomNavigationBarItem(icon: Icon(Icons.face,),title: Text("Belleza")),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.dumbbell,),title: Text("Gimnasios")),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.ambulance,),title: Text("Emergencia")),

      ],

      ),
      body: new PageView(
        controller: _c,
        onPageChanged: (newPage){
          setState((){
            this._page=newPage;
          });
        },
        children: <Widget>[
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat,53)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat,55)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat,56)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat,59)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat,58)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat,57)),
        ],
      ),
    );
  }
}
