import 'dart:convert';
import 'package:cabofind/paginas/pedidos_historial.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main_esp.dart';
import 'list_manejador_menus.dart';
import 'menu.dart';

class Domicilio extends StatefulWidget {
  @override
  _DomicilioState createState() => _DomicilioState();
}

class _DomicilioState extends State<Domicilio> {
  DateTime now = DateTime.now();
  DateFormat dateFormat;
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
    dateFormat = new DateFormat.Hm();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new Myapp()));
      },
      child: Scaffold(
          bottomNavigationBar: FFNavigationBar(
            theme: FFNavigationBarTheme(
              barBackgroundColor: Colors.white,
              selectedItemBorderColor: Colors.white,
              selectedItemBackgroundColor: Color(0xff3E252B),
              selectedItemIconColor: Colors.white,
              selectedItemLabelColor: Colors.black,
            ),
            items: [
              FFNavigationBarItem(
                selectedBackgroundColor: Colors.green,
                iconData: FontAwesomeIcons.utensils,
                label: 'Inicio',
              ),
              FFNavigationBarItem(
                selectedBackgroundColor: Colors.green,
                iconData: FontAwesomeIcons.search,
                label: 'Buscar',
              ),
              FFNavigationBarItem(
                selectedBackgroundColor: Colors.green,
                iconData: FontAwesomeIcons.fileAlt,
                label: 'Pedidos',
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
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Myapp()));
                }),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Cabofood'),
                InkWell(
                    onTap: () {
                      setState(() {});
                    },
                    child: Icon(FontAwesomeIcons.syncAlt))
              ],
            ),
            backgroundColor: Color(0xff3E252B),
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
                  String hora = data[index]["HOR_APERTURA"];
                  String horaclose = data[index]["HOR_CIERRE"];
                  String formattedTime = DateFormat('h:mm a').format(now);
                  DateTime hora1 = dateFormat.parse(hora);
                  DateTime horacerrar = dateFormat.parse(horaclose);
                  DateTime hora2 =
                      new DateFormat("h:mm a").parse(formattedTime);

                  //DateTime apertura2 = new DateFormat("kk:mm:ss").parse(hora);
                  String apertura = DateFormat('h:mm a').format(hora1);
                  print(hora1);
                  print(formattedTime);
                  return hora1.isBefore(hora2) && horacerrar.isAfter(hora2)
                      ? new InkWell(
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
                                    image:
                                        NetworkImage(data[index]['GAL_FOTO']),
                                    fit: BoxFit.fill,
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                                    placeholder: AssetImage(
                                        'android/assets/images/loading.gif'),
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
                        )
                      : new InkWell(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    margin: EdgeInsets.all(5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: FadeInImage(
                                        image: NetworkImage(
                                            data[index]['GAL_FOTO']),
                                        fit: BoxFit.fill,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 150,
                                        // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                                        placeholder: AssetImage(
                                            'android/assets/images/loading.gif'),
                                        fadeInDuration:
                                            Duration(milliseconds: 200),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    //  margin: EdgeInsets.all(50),
                                    height: 50,
                                    width: 300,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.black26,
                                      ),
                                      color: Colors.black26,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Hora de apertura: ' +
                                            apertura.toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  )
                                ],
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
                  //  : SizedBox();
                },
              ),
              Center(
                child: Text(
                  'Proximamente :)',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              new Pedidos_historial()
              //new Mis_recompensas(),
              //new Mis_promos(),
              //new Mis_favoritos(),
              //new Login()
            ],
          )),
    );
  }
}
