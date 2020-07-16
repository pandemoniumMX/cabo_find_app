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

  @override
  void initState() {
    super.initState();

    dateFormat = new DateFormat.yMMMd('es');
  }

  Widget build(BuildContext context) {
    final tab = new TabBar(tabs: <Tab>[
      new Tab(
        text: 'PEDIDOS ANTERIORES',
      ),
      new Tab(
        text: 'PEDIDOS PRÓXIMOS',
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
                            return Text('Error');
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    imageUrl: snapshot.data["GAL_FOTO"],
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
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
                                        FontAwesomeIcons.checkCircle,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.all(10),
                                        child:
                                            Text(snapshot.data["CAR_ESTATUS"]))
                                  ],
                                ),
                                Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      'Fecha de entrega: ' +
                                          dateFormat.format(DateTime.parse(
                                              snapshot.data[
                                                  "CAR_FECHA_ENTREGADO"])),
                                      style: TextStyle(color: Colors.black54),
                                    )),
                                Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      'No. de pedido: ' +
                                          snapshot.data["ID_CARRITO"],
                                      style: TextStyle(color: Colors.black54),
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
                                            snapshot.data["CAR_REPARTIDOR"],
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
                                              snapshot.data["CAR_TOTAL"],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                                Divider(
                                  thickness: 3,
                                )
                              ],
                            );
                          }
                      }
                    })
              ],
            ), //Termina pedidos anteriores
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}
