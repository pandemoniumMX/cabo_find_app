import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'list_manejador.dart';
import 'list_manejador_promociones.dart';

class Promociones_list extends StatefulWidget {
  @override
  _Restaurantes createState() => new _Restaurantes();
}

class _Restaurantes extends State<Promociones_list> {
  int id = 0;
  int cat = 61; //educacion

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
                FontAwesomeIcons.utensils,
              ),
              title: Text("Restaurantes")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.beer,
              ),
              title: Text("Bares")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.bicycle,
              ),
              title: Text("Actividades")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.tshirt,
              ),
              title: Text("Moda")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.heartbeat,
              ),
              title: Text("Bienestar")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.userTie,
              ),
              title: Text("Servicios")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.school,
              ),
              title: Text("Educación")),
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
          new Manejador_promociones(cat: new Categoria(60)),
          new Manejador_promociones(cat: new Categoria(62)),
          new Manejador_promociones(cat: new Categoria(63)),
          new Manejador_promociones(cat: new Categoria(61)),
          new Manejador_promociones(cat: new Categoria(69)),
          new Manejador_promociones(cat: new Categoria(59)),
          new Manejador_promociones(cat: new Categoria(70)),
        ],
      ),
    );
  }
}
