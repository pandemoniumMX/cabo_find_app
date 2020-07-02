import 'package:cabofind/paginas/list_manejador_menus.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:cabofind/utilidades/estilo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Menu_comidas extends StatefulWidget {
  final Users manejador;

  Menu_comidas({Key key, @required this.manejador}) : super(key: key);
  @override
  _Menu_comidasState createState() => _Menu_comidasState();
}

class _Menu_comidasState extends State<Menu_comidas> {
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
        title: new Text('Regresar'),
        actions: <Widget>[
          new InkResponse(
              onTap: () {
                //_makeStripePayment();
              },
              child: Stack(
                children: <Widget>[
                  /*Positioned(
                      
                                right: 2.0,
                                bottom: 30,
                                child: new Text('22',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0, color: Colors.redAccent)),
                              ),*/

                  new Center(
                    child: new Row(children: <Widget>[
                      new Icon(FontAwesomeIcons.shoppingCart),
                      Text(
                        "  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ]),
                  ),
                  Positioned(
                    height: 20,
                    width: 20,
                    right: 3.0,
                    bottom: 28,
                    child: new FloatingActionButton(
                      child: new Text('1',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                              color: Colors.white)),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              )),
        ],
      ),
      /*bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _page,
        backgroundColor: Colors.black,
        fixedColor: Color(0xff01969a),
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: false,
        //unselectedIconTheme: Colors.grey,

        onTap: (index){
          this._c.animateToPage(index,duration: const Duration(milliseconds: 10),curve: Curves.easeInOut);
        },
        items: <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.car,),title: Text("Cars")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.piggyBank,),title: Text("Banks")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userTie,),title: Text("Professionals")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.taxi,),title: Text("Transport")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.dog,),title: Text("Pets")),
      ],

      ),*/
      body: new PageView(
        controller: _c,
        onPageChanged: (newPage) {
          setState(() {
            this._page = newPage;
          });
        },
        children: <Widget>[
          new Menu_manejador(
              manejador: new Users(widget.manejador.correo)), //idnegocio
          //  Boton_sig()
        ],
      ),
    );
  }
}

class Boton_sig extends StatelessWidget {
  const Boton_sig({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 350,
          top: 200,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Column(children: [
              BezierContainer(),
              new Row(
                children: <Widget>[
                  new Icon(
                    FontAwesomeIcons.arrowAltCircleRight,
                    color: Colors.black,
                  ),
                  new Text(' Siguiente',
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                ],
              )
            ]),
          ),
        ),
        Positioned(
            left: 410,
            top: 360,
            child: Column(
              children: <Widget>[
                new Icon(
                  FontAwesomeIcons.arrowAltCircleRight,
                  color: Colors.white,
                ),
                new Text(' Siguiente',
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              ],
            )),
      ],
    );
  }
}
