import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Pedidos_historial extends StatefulWidget {
  @override
  _Pedidos_historialState createState() => _Pedidos_historialState();
}

class _Pedidos_historialState extends State<Pedidos_historial> {
  TabController controller;
  DateFormat dateFormat;
  List historial;
  List proximo;

  Future<Map> _loadPedidos() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringMail");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/list_pedidos_historial.php?CORREO=$_mail2");
    //print(widget.negocio.correo);
    return json.decode(response.body);
    //widget.negocio.correo
  }

  Future<String> _cargarHistorial() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringMail");

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_pedidos_historial_api.php?CORREO=$_mail2"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      historial = json.decode(response.body);
    });
  }

  Future<String> _cargarProximo() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringMail");

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_pedidos_proximo_api.php?CORREO=$_mail2"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      proximo = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    this._cargarHistorial();
    this._cargarProximo();
    dateFormat = DateFormat.yMMMMd('es').add_Hm(); //new DateFormat.yMMMd('es');
  }

  Widget build(BuildContext context) {
    final tab = new TabBar(tabs: <Tab>[
      new Tab(
        text: 'PEDIDOS PRÓXIMOS',
      ),
      new Tab(
        text: 'PEDIDOS ANTERIORES',
      ),
    ]);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: new PreferredSize(
            preferredSize: tab.preferredSize,
            child: new Card(
              elevation: 26.0,
              color: Color(0xffFF7864),
              child: tab,
            )),
        body: TabBarView(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: proximo == null ? 0 : proximo.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          imageUrl: proximo[index]["GAL_FOTO"],
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Icon(
                              FontAwesomeIcons.clock,
                              color: Colors.green,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.all(10),
                              child: Text(proximo[index]["CAR_ESTATUS"]))
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Fecha de pedido: ' +
                                dateFormat.format(DateTime.parse(
                                    proximo[index]["CAR_FECHA"])),
                            style: TextStyle(color: Colors.black54),
                          )),
                      Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'No. de pedido: ' + proximo[index]["ID_CARRITO"],
                            style: TextStyle(color: Colors.black54),
                          )),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Icon(
                              FontAwesomeIcons.moneyBill,
                              color: Colors.green,
                              size: 20,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'Total: MXN ' + proximo[index]["CAR_TOTAL"],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                      Divider(
                        thickness: 3,
                      )
                    ],
                  );
                }), //aqui termina pedidos proximos
            ListView(
              children: <Widget>[
                FutureBuilder(
                    future: _loadPedidos(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError) {
                            return Text('No tienes pedidos anteriores');
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount:
                                    historial == null ? 0 : historial.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 150,
                                          imageUrl: historial[index]
                                              ["GAL_FOTO"],
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Icon(
                                              FontAwesomeIcons.checkCircle,
                                              color: Colors.green,
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.all(10),
                                              child: Text(historial[index]
                                                  ["CAR_ESTATUS"]))
                                        ],
                                      ),
                                      Container(
                                          margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            'Fecha de entrega: ' +
                                                dateFormat.format(DateTime
                                                    .parse(historial[index][
                                                        "CAR_FECHA_ENTREGADO"])),
                                            style: TextStyle(
                                                color: Colors.black54),
                                          )),
                                      Container(
                                          margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            'No. de pedido: ' +
                                                historial[index]["ID_CARRITO"],
                                            style: TextStyle(
                                                color: Colors.black54),
                                          )),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Icon(
                                              FontAwesomeIcons.userCheck,
                                              color: Colors.green,
                                              size: 20,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(5),
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              'Entregado por: ' +
                                                  historial[index]
                                                      ["CAR_REPARTIDOR"],
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          )
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Icon(
                                              FontAwesomeIcons.moneyBill,
                                              color: Colors.green,
                                              size: 20,
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.all(5),
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                'Total: MXN ' +
                                                    historial[index]
                                                        ["CAR_TOTAL"],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                      Divider(
                                        thickness: 3,
                                      )
                                    ],
                                  );
                                });
                          }
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
