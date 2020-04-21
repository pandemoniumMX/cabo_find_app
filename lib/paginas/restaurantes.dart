

import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'list_manejador.dart';

class Restaurantes extends StatefulWidget {


  @override
_Restaurantes createState() => new _Restaurantes();
}

class _Restaurantes extends State<Restaurantes> {
  int id=0;
  int cat =60;//restaurantes
  int sub1 =26;//ita
  int sub2 =27;//mex
  int sub3 =28;//mariscos
  int sub4 =29;//fast
  int sub5 =30;//oriental
  int sub6 =31;//otros
  int sub7 =32;//snacks
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
      title: new Text('Restaurantes'),
    ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _page,
        backgroundColor: Colors.black,
        fixedColor: Color(0xff01969a),
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        //unselectedIconTheme: Colors.grey,

        onTap: (index){
          this._c.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
        },
        items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.pepperHot,),title: Text("Mexicano")),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.pizzaSlice,),title: Text("Italiano")),
        BottomNavigationBarItem(icon: Icon(Icons.favorite,),title: Text("Oriental")),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.fish,),title: Text("Mariscos")),
        BottomNavigationBarItem(icon: Icon(Icons.fastfood,),title: Text("Rápida")),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.utensils,),title: Text("Otros")),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.iceCream,),title: Text("Snack")),

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
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat,27)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat,26)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat,30)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat,28)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat,29)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat,31)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat,32))
        ],
      ),
    );
  }
}
