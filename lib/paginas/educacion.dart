import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'list_manejador.dart';

class Educacion extends StatefulWidget {
  @override
  _Restaurantes createState() => new _Restaurantes();
}

class _Restaurantes extends State<Educacion> {
  int id = 0;
  int cat = 70; //educacion

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
        title: new Text('Educación'),
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
                FontAwesomeIcons.baby,
              ),
              title: Text("Guarderías")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.child,
              ),
              title: Text("Infantil")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.userGraduate,
              ),
              title: Text("Universidades")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.bookOpen,
              ),
              title: Text("Cursos")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.school,
              ),
              title: Text("Abierta")),
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
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 62)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 63)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 64)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 61)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 60)),
        ],
      ),
    );
  }
}
