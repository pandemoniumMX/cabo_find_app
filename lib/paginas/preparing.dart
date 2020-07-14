import 'dart:convert';
import 'package:cabofind/paginas/list_manejador_rec_obtenidas.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'dados.dart';
import 'list_manejador_recompensas.dart';
import 'package:cabofind/paginas/direccion.dart';

class Preparing extends StatefulWidget {
  @override
  _Compras createState() => new _Compras();
}

class _Compras extends State<Preparing> {
  //bool isLoggedIn = false;
  //final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  void initState() {
    //sesionLog();
    super.initState();
  }

  Future<bool> sesionLog() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    _status = login.getString("stringLogin") ?? '';
    _mail = login.getString("stringMail") ?? '';
    bool checkValue = login.containsKey('value');
    return checkValue = login.containsKey('stringLogin');

    // if (prefs.getString(_idioma) ?? 'stringValue' == "espanol")
    if (_status == "True") {
      print("Sesión ya iniciada");
    } else {
      print("Sesión no iniciada");
    }
    http.Response response = await http.get("http://api.openrates.io/latest");
    return json.decode(response.body);
  }

  Future<bool> _check2() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringMail");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/check_pedidos.php?CORREO=$_mail2");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: FutureBuilder(
            future: _check2(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasData) {
                    return snapshot.data ? Carritox() : Login2();
                  }
                  return Carritox();
              }
            }));
  }
}

class Carritox extends StatefulWidget {
  Carritox({Key key}) : super(key: key);
  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<Carritox> {
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
                        elevation: 1.0,
                        child: new Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(children: <Widget>[
                                    Text(data[index]["PED_CANTIDAD"] + 'X',
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                          color: Colors.green,
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
                              /*Row(
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
                              ),*/
                              data[index]["PED_NOTA"] != null
                                  ? Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 20),
                                              padding: EdgeInsets.all(10),
                                              child: Text('Nota(s): ',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.black,
                                                  )),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 30),
                                              padding: EdgeInsets.all(10),
                                              child: Flexible(
                                                child: Text(
                                                    data[index]["PED_NOTA"],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: 15.0,
                                                      color: Colors.black54,
                                                    )),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  : SizedBox(),
                              Container(
                                margin: EdgeInsets.only(right: 210),
                                padding: EdgeInsets.all(10),
                                child:
                                    Text(data[index]["MENU_EXTRA_TIPO"] + ':',
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        )),
                              ),
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

                                        if (idp == idx2) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 30),
                                                padding: EdgeInsets.all(10),
                                                child: Text(
                                                  ext[a]["EXT_NOMBRE"],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black54),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 15),
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
                                        //Text('');
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
      bottomNavigationBar: Container(
        height: 50,
        child: RaisedButton(
          onPressed: () {},
          color: Colors.green,
          textColor: Colors.white,
          child: Text(
            'Confirmar orden',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Regresar'),
        backgroundColor: Colors.green,
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
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new Mi_direccion()));
            },
            child: Row(
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
                Text(
                  'Agrega tu dirección',
                  style: TextStyle(color: Colors.red),
                ),
                Icon(FontAwesomeIcons.chevronRight),
              ],
            ),
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
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.all(1),
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
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}

class Login2 extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Login2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Color(0xff01969a),
            Colors.white,
          ])),
      child: Container(
        child: ListView(
          shrinkWrap: false,
          //addAutomaticKeepAlives: true,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    "assets/splash.png",
                    fit: BoxFit.fill,
                    width: 150.0,
                    height: 150.0,
                  )),
            ),
            //SizedBox(height: 100.0,),
            //SizedBox(height: 25.0,),
            Center(
                child: Text(
              "Crea tu cuenta",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
            Center(
                child: Text(
              "Para obtener recompensas!",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
            Center(
                child: SizedBox(
              height: 25.0,
            )),
            Center(
                child: Flexible(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "assets/fire2.png",
                          fit: BoxFit.fill,
                          width: 80.0,
                          height: 80.0,
                        )))),
          ],
        ),
      ),
    );
  }
}
