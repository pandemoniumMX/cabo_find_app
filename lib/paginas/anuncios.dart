import 'package:cabofind/paginas_ing/anuncios.dart';
import 'package:cabofind/paginas_listas/Lista_manejador_anuncios.dart';
import 'package:cabofind/paginas_listas/list__anun_electronica.dart';
import 'package:cabofind/paginas_listas/list__anun_empleo.dart';
import 'package:cabofind/paginas_listas/list__anun_inmuebles.dart';

import 'package:cabofind/utilidades/buscador_market.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Anuncios extends StatefulWidget {
  @override
  _Servicios createState() => new _Servicios();
}

class _Servicios extends State<Anuncios> {
  int id = 0;
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
        title: new Text('Marketplace'),
        actions: <Widget>[
          new InkResponse(
              onTap: () {
                //Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Anuncios_ing()));
              },
              child: new Center(
                //padding: const EdgeInsets.all(13.0),

                child: new Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: ExactAssetImage('assets/usaflag.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: new Text(
                    "     ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  ),
                ),
              )),
          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {
              //Use`Navigator` widget to push the second screen to out stack of screens
              Navigator.of(context).push(
                  MaterialPageRoute<Null>(builder: (BuildContext context) {
                return new Buscador_market();
              }));
            },
          ),
        ],
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
                FontAwesomeIcons.sign,
              ),
              title: Text("Inmuebles")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.laptop,
              ),
              title: Text("Tecnología")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.userCheck,
              ),
              title: Text("Bolsa de trabajo")),
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
          new Lista_manejador_anuncios(manejador: new Categoria(1)),
          new Lista_manejador_anuncios(manejador: new Categoria(2)),
          new Lista_manejador_anuncios(manejador: new Categoria(3)),
          new Lista_manejador_anuncios(manejador: new Categoria(4)),
        ],
      ),
    );
  }
}
