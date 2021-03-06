import 'dart:convert';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas/recompensa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'login.dart';

class Mis_promos_manejador extends StatefulWidget {
  final Publicacion publicacion;

  Mis_promos_manejador({Key key, @required this.publicacion}) : super(key: key);
  @override
  _Compras createState() => new _Compras();
}

class _Compras extends State<Mis_promos_manejador> {
  bool isLoggedIn = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  void initState() {
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
    print(checkValue);
    print(_status);
    print(_mail);

    if (_status == "True") {
      print("Sesión ya iniciada");
    } else {
      print("Sesión no iniciada");
    }
    http.Response response = await http.get("http://api.openrates.io/latest");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Regresar'),
        ),
        body: FutureBuilder(
          future: sesionLog(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              String id_n = widget.publicacion.id_n;
              String id_p = widget.publicacion.id_p;
              return snapshot.data
                  ? Usuario(
                      usuarios: new Users("testing@gmail.com"),
                      publicacion: new Publicacion(id_n, id_p),
                    )
                  : Login2(publicacion: new Publicacion(id_n, id_p));
            }
            String id_n = widget.publicacion.id_n;
            String id_p = widget.publicacion.id_p;
            Login2(
                publicacion: new Publicacion(id_n,
                    id_p)); // noop, this builder is called again when the future completes
          },
        ));
  }
}

class Usuario extends StatefulWidget {
  final Publicacion publicacion;
  final Users usuarios;

  Usuario({Key key, @required this.publicacion, this.usuarios})
      : super(key: key);
  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {
  List data;

  void initState() {
    super.initState();
    this._loadUser();
    print('puta');
  }

  Future<Map> _loadUser() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    print(_mail2);

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_recompensas_usuario.php?IDF=$_mail2&ID=${widget.publicacion.id_p}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });
  }

  void showError() {
    Fluttertoast.showToast(
        msg: "No tienes puntos :(",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Color(0xff192227),
        textColor: Colors.white,
        timeInSecForIos: 1);
  }

  @override
  Widget build(BuildContext context) {
    Widget estructura = ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        //String id_n = data[index]["ID_PUBLICACION"];
        return new ListTile(
          title: new Card(
            elevation: 5.0,
            child: new Container(
              child: Column(
                children: <Widget>[
                  //Text("Texto",
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FadeInImage(
                        image: NetworkImage(data[index]["REC_FOTO"]),
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width * .20,
                        height: MediaQuery.of(context).size.height * .10,
                        placeholder:
                            AssetImage('android/assets/images/loading.gif'),
                        fadeInDuration: Duration(milliseconds: 200),
                      ),
                      Flexible(
                        child: Text(data[index]["REC_TITULO"],
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black,
                            )),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              new Text(
                                data[index]["REC_META"],
                                style: TextStyle(fontSize: 20),
                              ),
                              new Text(
                                'Puntos',
                                style: TextStyle(fontSize: 10),
                              ),
                              new Text(
                                'necesarios',
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            String id_re = data[index]["ID_RECOMPENSA"];
            String id_n = data[index]["negocios_ID_NEGOCIO"];
            String puntos = data[index]["PUN_TOTAL"];
            String _mail = widget.usuarios.correo;

            puntos == null
                ? showError()
                : Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Recompensa_detalle(
                              publicacion: new Publicacion2(id_re, id_n, _mail),
                            )));
          },
        );
      },
    );
    return Scaffold(
      body: ListView(
        //shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        addAutomaticKeepAlives: true,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.black,
                Colors.black,
                //Colors.white,
              ])),
              child: Row(children: [
                Text(
                  "Puntos obtenidos: ",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                data[0]["PUN_TOTAL"] == null
                    ? Text(
                        '0 ',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    : Text(
                        data[0]["PUN_TOTAL"],
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
              ])),
          estructura,
        ],
      ),
    );
  }
}

class Login2 extends StatefulWidget {
  final Publicacion publicacion;

  Login2({Key key, @required this.publicacion}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<Login2> {
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_recompensas_usuario_none.php?ID=${widget.publicacion.id_p}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> _checklogin() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    _status = login.getString("stringLogin") ?? '';
    _mail = login.getString("stringMail") ?? '';
    print(_status);
    print(_mail);
    //String id = data[0]["ID_NEGOCIO"];

    if (_status == "True") {
    } else {
      //CircularProgressIndicator(value: 5.0,);

      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (BuildContext context) => Login()));
    }
  }

  @override
  void initState() {
    super.initState();

    this.getData();
  }

  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        //String id_n = data[index]["ID_PUBLICACION"];
        return new ListTile(
          title: new Card(
            elevation: 5.0,
            child: new Container(
              child: Column(
                children: <Widget>[
                  //Text("Texto",
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FadeInImage(
                        image: NetworkImage(data[index]["REC_FOTO"]),
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width * .20,
                        height: MediaQuery.of(context).size.height * .10,
                        placeholder:
                            AssetImage('android/assets/images/loading.gif'),
                        fadeInDuration: Duration(milliseconds: 200),
                      ),
                      Flexible(
                        child: Text(data[index]["REC_TITULO"],
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black,
                            )),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              new Text(
                                data[index]["REC_META"],
                                style: TextStyle(fontSize: 20),
                              ),
                              new Text(
                                'Puntos',
                                style: TextStyle(fontSize: 10),
                              ),
                              new Text(
                                'necesarios',
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            _checklogin();
          },
        );
      },
    );
  }
}
