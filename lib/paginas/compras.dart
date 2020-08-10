import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'list_manejador.dart';

class Compras extends StatefulWidget {
  @override
  _Restaurantes createState() => new _Restaurantes();
}

class _Restaurantes extends State<Compras> {
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
      appBar: new AppBar(
        title: new Text('Compras'),
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
                FontAwesomeIcons.tshirt,
              ),
              title: Text("Moda")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.gift,
              ),
              title: Text("Regalos")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.gem,
              ),
              title: Text("Joyería")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.store,
              ),
              title: Text("Tiendas")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.boxOpen,
              ),
              title: Text("Proveedores")),
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
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 33)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 34)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 36)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 35)),
          new Lista_Manejador_esp(manejador: new Lista_manejador(cat, 65)),
        ],
      ),
    );
  }
}
