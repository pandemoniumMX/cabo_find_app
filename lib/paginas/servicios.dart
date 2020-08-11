import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'list_manejador.dart';

class Servicios extends StatefulWidget {
  @override
  _Restaurantes createState() => new _Restaurantes();
}

class _Restaurantes extends State<Servicios> {
  int id = 0;
  int cat = 59; //Servicios

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
        title: new Text('Servicios'),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _page,
        backgroundColor: Color(0xff773E42),
        fixedColor: Color(0xff773E42),
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
              title: Text("Autos")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.piggyBank,
              ),
              title: Text("Bancos")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.userTie,
              ),
              title: Text("Profesionales")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.taxi,
              ),
              title: Text("Transporte")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.dog,
              ),
              title: Text("Mascotas")),
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
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 38)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 50)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 39)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 25)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 51)),
        ],
      ),
    );
  }
}
