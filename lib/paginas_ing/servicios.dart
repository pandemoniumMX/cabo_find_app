import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'list_manejador.dart';

class Servicios_ing extends StatefulWidget {
  @override
  _Restaurantes createState() => new _Restaurantes();
}

class _Restaurantes extends State<Servicios_ing> {
  int id = 0;
  int cat = 59; //educacion

  @override
  int _page = 0;
  PageController _c;
  @override
  void initState() {
    _c = new PageController(
      initialPage: _page,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Services'),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _page,
        backgroundColor: Color(0xff192227),
        fixedColor: Color(0xff192227),
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: false,
        //unselectedIconTheme: Colors.grey,

        onTap: (index) {
          this._c.animateToPage(index,
              duration: const Duration(milliseconds: 10),
              curve: Curves.easeInOut);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.car,
              ),
              title: Text("Cars")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.piggyBank,
              ),
              title: Text("Banks")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.userTie,
              ),
              title: Text("Professionals")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.taxi,
              ),
              title: Text("Transport")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.dog,
              ),
              title: Text("Pets")),
        ],
      ),
      body: new PageView(
        controller: _c,
        onPageChanged: (newPage) {
          setState(() {
            this._page = newPage;
          });
        },
        children: <Widget>[
          new Lista_Manejador_ing(manejador: new Lista_manejador(cat, 38)),
          new Lista_Manejador_ing(manejador: new Lista_manejador(cat, 50)),
          new Lista_Manejador_ing(manejador: new Lista_manejador(cat, 39)),
          new Lista_Manejador_ing(manejador: new Lista_manejador(cat, 25)),
          new Lista_Manejador_ing(manejador: new Lista_manejador(cat, 51)),
        ],
      ),
    );
  }
}
