import 'dart:convert';
import 'package:cabofind/paginas/domicilio.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';

class Lista_terminado extends StatefulWidget {
  final Costos carrito;
  Lista_terminado({Key key, @required this.carrito}) : super(key: key);
  @override
  _Pedidos_nuevosState createState() => _Pedidos_nuevosState();
}

class _Pedidos_nuevosState extends State<Lista_terminado> {
  var currentSelectedValue;
  static const deviceTypes = ["⭐", "⭐⭐", "⭐⭐⭐", "⭐⭐⭐⭐", "⭐⭐⭐⭐⭐"];

  int _value = 1;
  List data;
  List ext;
  List carrito;
  DateFormat dateFormat;
  final _formKey = GlobalKey<FormState>();

  Future<String> _cargarPedido() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _idn = "";
    _idn = login.getString("stringNEG");

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/pedidos_terminado_api.php?IDN=${widget.carrito.costo}&IDC=${widget.carrito.paquete}"),
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

  Future<String> _confirmarCalificacion(
      String menu, String idp, int drop) async {
    print('VALORES CALIFICACION*******************');
    print(menu);
    print(idp);

    print(drop);
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/insert_calificacion_pedido.php?IDP=${idp}&MENU=${menu}&IDF=$_mail2&CAL=${drop}");
  }

  void initState() {
    super.initState();
    this._cargarPedido();
    this._cargarExtra();
    dateFormat = DateFormat.yMMMMd('es').add_Hm();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void showCalificacion() {
      Fluttertoast.showToast(
        msg: "Platillo calificado correctamente",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Color(0xff192227),
        textColor: Colors.white,
      );
    }

    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new Domicilio(
                    numeropagina: Categoria(2), numtab: Categoria(2))));
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
                        numeropagina: Categoria(2), numtab: Categoria(2)))),
          ),
          backgroundColor: Color(0xff192227),
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
                  String idm = data[index]["menu_ID_MENU"];

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
                                            padding: EdgeInsets.all(0),
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
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // return object of type Dialog
                                    return StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return AlertDialog(
                                        title: new Text(
                                            "Calificación de platillo"),
                                        content: DropdownButton(
                                            onTap: () {
                                              setState(() {});
                                            },
                                            isExpanded: true,
                                            value: _value,
                                            items: [
                                              DropdownMenuItem(
                                                child: Text("⭐"),
                                                value: 1,
                                              ),
                                              DropdownMenuItem(
                                                child: Text("⭐⭐"),
                                                value: 2,
                                              ),
                                              DropdownMenuItem(
                                                  child: Text("⭐⭐⭐"), value: 3),
                                              DropdownMenuItem(
                                                  child: Text("⭐⭐⭐⭐"),
                                                  value: 4),
                                              DropdownMenuItem(
                                                  child: Text("⭐⭐⭐⭐⭐"),
                                                  value: 5)
                                            ],
                                            onChanged: (valuex) {
                                              setState(() {
                                                _value = valuex;
                                              });
                                            }),
                                        actions: <Widget>[
                                          // usually buttons at the bottom of the dialog
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              new FlatButton(
                                                child: new Text("Cancelar"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              new FlatButton(
                                                child: new Text("Calificar",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff192227))),
                                                onPressed: () {
                                                  _confirmarCalificacion(
                                                      idm, idx, _value);
                                                  showCalificacion();
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    });
                                  },
                                );
                              },
                              color: Color(0xff192227),
                              textColor: Colors.white,
                              child: Text(
                                'Calificar platillo',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
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
