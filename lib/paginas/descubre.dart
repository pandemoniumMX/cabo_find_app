import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'list_manejador.dart';

class Descubre extends StatefulWidget {
  @override
  _Restaurantes createState() => new _Restaurantes();
}

class _Restaurantes extends State<Descubre> {
  int id = 0;
  int cat = 63; //educacion

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
        title: new Text('Actividades'),
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
                FontAwesomeIcons.swimmer,
              ),
              title: Text("Acuáticas")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.bicycle,
              ),
              title: Text("Terrestres")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.plane,
              ),
              title: Text("Aéreas")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.placeOfWorship,
              ),
              title: Text("Sitios")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.umbrellaBeach,
              ),
              title: Text("Playas")),
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
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 45)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 46)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 47)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 48)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 52)),
        ],
      ),
    );
  }
}
