import 'dart:convert';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preparing extends StatefulWidget {
  Preparing({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Preparing> {
  List data;
  List ext;
  String id_extra;
  TextEditingController cupon = TextEditingController();

  Future<Map> _check() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringMail");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/check_pedidos.php?CORREO=$_mail2");
    return json.decode(response.body);
  }

  // ignore: missing_return
  Future<String> _cargarPedido() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringMail");

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_pedidos_api.php?CORREO=$_mail2"),
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

  @override
  void initState() {
    super.initState();
    this._cargarPedido();
    this._cargarExtra();
  }

  @override
  void dispose() {
    cupon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget estructura = FutureBuilder(
        future: _check(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                //  print(snapshot.hasError);
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                    'Aún no tienes puntoss',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: data == null ? 0 : data.length,
                    itemBuilder: (BuildContext context, int index) {
                      String idx = data[index]["ID_PEDIDOS"];
                      String unitario = data[index]["MENU_COSTO"];
                      String cantidad = data[index]["PED_CANTIDAD"];
                      var sum = int.parse(unitario) * int.parse(cantidad);
                      String sum2 = sum.toString();
                      print(idx);

                      return new Card(
                        elevation: 5.0,
                        child: new Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(children: <Widget>[
                                    Text(data[index]["PED_CANTIDAD"],
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        )),
                                  ]),
                                  Text(data[index]["MENU_NOMBRE"],
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      )),
                                  new Text(
                                    '\$ ' + data[index]["PED_TOTAL"],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                        'C/u \$' + data[index]["MENU_COSTO"],
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: TextStyle(
                                          //  fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        )),
                                  )
                                ],
                              ),
                              Text(' Notas: ' + data[index]["PED_NOTA"],
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  )),
                              idx == idx
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: ext == null ? 0 : ext.length,
                                      itemBuilder:
                                          (BuildContext contexts, int a) {
                                        String idp =
                                            ext[a]["pedidos_ID_PEDIDOS"];
                                        String idx2 = data[index]["ID_PEDIDOS"];

                                        return idp == idx2
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20),
                                                    padding: EdgeInsets.all(10),
                                                    child: Text(
                                                      ext[a]["EXT_NOMBRE"],
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 20),
                                                    padding: EdgeInsets.all(10),
                                                    child: Text(
                                                      '\$' +
                                                          ext[a]["EXT_PRECIO"],
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Text('');
                                      })

                                  /*  return Text(
                                                    ext[a]["EXT_NOMBRE"],
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  );*/
                                  : Text('')
                            ],
                          ),
                        ),
                      );
                    });
              }
          }
        });

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton(
          onPressed: () {},
          color: Color(0xff01969a),
          textColor: Colors.white,
          child: Text('Confirmar orden'),
        ),
      ),
      appBar: AppBar(
        title: Text('Regresar'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.all(10),
              child: Text(
                'Mi orden',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )),
          Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Row(children: <Widget>[
                Text(
                  'Estás ordenando en ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  data[0]["NEG_NOMBRE"],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ])),
          estructura,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Subtotal',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$ 170',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          Divider(
            thickness: 2,
          ),
          Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.all(10),
              child: Text(
                'Acerca de la orden',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Dirección',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )),
              Text('Ingresa tu dirección'),
              Icon(FontAwesomeIcons.chevronRight),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Comisión por entrega',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$ 50',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          Divider(
            thickness: 2,
          ),
          Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.all(10),
              child: Text(
                '¿Cupón de descuento?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: TextField(
                    controller: cupon,
                    enabled: true,
                    decoration: InputDecoration(
                        focusColor: Color(0xffD3D7D6),
                        hoverColor: Color(0xffD3D7D6),
                        hintText: 'Ingresa un cupon válido'),
                  )),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(10),
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Color(0xffD3D7D6))),
                      onPressed: () {},
                      child: Text('Check')))
            ],
          ),
          Container(
            //color: Color(0xffD3D7D6),
            margin: EdgeInsets.only(left: 50, right: 50),
            decoration: BoxDecoration(
              color: Color(0xffD3D7D6),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
              //  border: Border.all(width: 1, color: Color(0xffD3D7D6))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Total',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$ 220',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
