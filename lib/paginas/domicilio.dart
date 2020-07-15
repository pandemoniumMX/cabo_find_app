import 'dart:convert';
import 'package:cabofind/utilidades/classes.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'list_manejador_menus.dart';
import 'menu.dart';

class Domicilio extends StatefulWidget {
  @override
  _DomicilioState createState() => _DomicilioState();
}

class _DomicilioState extends State<Domicilio> {
  List data;
  int _page = 0;
  int selectedIndex = 0;
  PageController _c;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_domicilio_rest.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  void initState() {
    super.initState();
    this.getData();
    _c = new PageController(
      initialPage: _page,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: FFNavigationBar(
          theme: FFNavigationBarTheme(
            barBackgroundColor: Colors.white,
            selectedItemBorderColor: Colors.white,
            selectedItemBackgroundColor: Color(0xff01969a),
            selectedItemIconColor: Colors.white,
            selectedItemLabelColor: Colors.black,
          ),
          items: [
            FFNavigationBarItem(
              iconData: FontAwesomeIcons.utensils,
              label: 'Inicio',
            ),
            FFNavigationBarItem(
              iconData: FontAwesomeIcons.search,
              label: 'Buscar',
            ),
            FFNavigationBarItem(
              iconData: FontAwesomeIcons.shoppingCart,
              label: 'Carrito',
            ),
          ],
          selectedIndex: selectedIndex,
          onSelectTab: (index) {
            this._c.animateToPage(index,
                duration: const Duration(milliseconds: 10),
                curve: Curves.easeInOut);
          },
        ),
        appBar: AppBar(
          title: Text('Regresar'),
        ),
        body: new PageView(
          controller: _c,
          onPageChanged: (newPage) {
            setState(() {
              this._page = newPage;
              selectedIndex = newPage;
            });
          },
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                String id_n = data[index]["ID_NEGOCIO"];
                print(id_n);
                return new InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Menu_manejador(
                                    manejador: new Users(id_n))));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5.0),
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: FadeInImage(
                            image: NetworkImage(data[index]['GAL_FOTO']),
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                            placeholder:
                                AssetImage('android/assets/images/loading.gif'),
                            fadeInDuration: Duration(milliseconds: 200),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: new Text(data[index]['NEG_NOMBRE'],
                            style: new TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w900,
                              //  backgroundColor: Colors.black45
                            )),
                      ),
                      Divider()
                    ],
                  ),
                );
              },
            ),
            Container(
              child: Text('Puta'),
            ),
            Container(
              child: Text('Puta'),
            ),
            //new Mis_recompensas(),
            //new Mis_promos(),
            //new Mis_favoritos(),
            //new Login()
          ],
        ));
  }
}
