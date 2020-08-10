import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'list_manejador.dart';

class Vida_nocturna_ing extends StatefulWidget {
  @override
  _Restaurantes createState() => new _Restaurantes();
}

class _Restaurantes extends State<Vida_nocturna_ing> {
  int id = 0;
  int cat = 62; //educacion

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
        title: new Text('Nightlife'),
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
                FontAwesomeIcons.cocktail,
              ),
              title: Text("Clubs")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.beer,
              ),
              title: Text("Bars")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.footballBall,
              ),
              title: Text("Sportbar")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.guitar,
              ),
              title: Text("Rockbar")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.searchPlus,
              ),
              title: Text("More")),
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
          new Lista_Manejador_ing(manejador: new Lista_manejador(cat, 41)),
          new Lista_Manejador_ing(manejador: new Lista_manejador(cat, 40)),
          new Lista_Manejador_ing(manejador: new Lista_manejador(cat, 66)),
          new Lista_Manejador_ing(manejador: new Lista_manejador(cat, 43)),
          new Lista_Manejador_ing(manejador: new Lista_manejador(cat, 44)),
        ],
      ),
    );
  }
}
