import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'list_manejador.dart';

class Educacion_ing extends StatefulWidget {
  @override
  _Restaurantes createState() => new _Restaurantes();
}

class _Restaurantes extends State<Educacion_ing> {
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
        title: new Text('Education'),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _page,
        backgroundColor: Colors.black,
        fixedColor: Colors.black,
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
              title: Text("Day care")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.child,
              ),
              title: Text("Childish")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.userGraduate,
              ),
              title: Text("Universities")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.bookOpen,
              ),
              title: Text("Courses")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.school,
              ),
              title: Text("Open")),
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
          new Lista_Manejador_ing(manejador: new Lista_manejador(cat, 62)),
          new Lista_Manejador_ing(manejador: new Lista_manejador(cat, 63)),
          new Lista_Manejador_ing(manejador: new Lista_manejador(cat, 64)),
          new Lista_Manejador_ing(manejador: new Lista_manejador(cat, 61)),
          new Lista_Manejador_ing(manejador: new Lista_manejador(cat, 60)),
        ],
      ),
    );
  }
}
