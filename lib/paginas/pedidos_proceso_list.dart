import 'dart:convert';
import 'package:cabofind/paginas/domicilio.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';

class Lista_enproceso extends StatefulWidget {
  final Costos carrito;
  Lista_enproceso({Key key, @required this.carrito}) : super(key: key);
  @override
  _Pedidos_nuevosState createState() => _Pedidos_nuevosState();
}

class _Pedidos_nuevosState extends State<Lista_enproceso> {
  List data;
  List ext;
  List carrito;
  DateFormat dateFormat;
  final _formKey = GlobalKey<FormState>();

  Future<String> _cargarPedido() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/pedidos_enviados_api.php?IDN=${widget.carrito.costo}&IDC=${widget.carrito.paquete}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });
  }

  Future<String> _cargarExtra() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_check_extras_api.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      ext = json.decode(response.body);
    });
  }

  void initState() {
    super.initState();
    this._cargarPedido();
    this._cargarExtra();
    dateFormat = DateFormat.yMMMMd('es').add_Hm();
    print(widget.carrito.costo);
    print(widget.carrito.paquete);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new Domicilio(
                    numeropagina: Categoria(2), numtab: Categoria(1))));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Regresar'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new Domicilio(
                        numeropagina: Categoria(2), numtab: Categoria(1)))),
          ),
          backgroundColor: Color(0xff60032D),
        ),
        body: ListView(
          children: <Widget>[
            ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int index) {
                  String idx = data[index]["ID_PEDIDOS"];
                  String idn = data[index]["ID_NEGOCIO"];

                  return new Card(
                    elevation: 1.0,
                    child: new Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(children: <Widget>[
                                Text(data[index]["PED_CANTIDAD"] + 'X',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: Color(0xff192227),
                                    )),
                              ]),
                              Text(data[index]["MENU_NOMBRE"],
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  )),
                              new Text(
                                '\$ ' + data[index]["PED_TOTAL"],
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 210),
                            padding: EdgeInsets.all(10),
                            child: data[index]["MENU_EXTRA_TIPO"] != null
                                ? Text(data[index]["MENU_EXTRA_TIPO"] + ':',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ))
                                : SizedBox(),
                          ),
                          idx == idx
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: ext == null ? 0 : ext.length,
                                  itemBuilder: (BuildContext contexts, int a) {
                                    String idp = ext[a]["pedidos_ID_PEDIDOS"];
                                    String idx2 = data[index]["ID_PEDIDOS"];

                                    if (idp == idx2) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 30),
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              ext[a]["EXT_NOMBRE"],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 15),
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              '\$' + ext[a]["EXT_PRECIO"],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54),
                                            ),
                                          )
                                        ],
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  })
                              : Text(''),
                          Container(
                            margin: EdgeInsets.only(left: 25),
                            padding: EdgeInsets.all(5),
                            child: data[index]["PED_NOTA"] != null
                                ? Text('Nota(s): ',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ))
                                : SizedBox(),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 25),
                            padding: EdgeInsets.all(5),
                            child: data[index]["PED_NOTA"] != null
                                ? Text(
                                    data[index]["PED_NOTA"],
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  )
                                : SizedBox(),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
