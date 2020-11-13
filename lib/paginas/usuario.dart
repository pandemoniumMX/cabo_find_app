import 'dart:convert';

import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Usuario extends StatefulWidget {
  final Users usuarios;

  Usuario({Key key, @required this.usuarios}) : super(key: key);
  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {
  void initState() {
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();
  int _value = 1;
  TextEditingController comment = TextEditingController();
  Future<String> ayudamail() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    var response1 = await http.get(
        Uri.encodeFull(
            'http://cabofind.com.mx/app_php/sendmails/helpmail.php?IDF=${_mail2}&VALUE=${_value}&COM=${comment.text}'),
        headers: {"Accept": "application/json"});

    return "Success!";
  }
  Future<Map> _loadUser() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    //_mail = "testing@gmail.com";
    print(_mail2);
    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/list_usuarios_api.php?IDF=$_mail2");
    //http.Response response = await http.get("http://cabofind.com.mx/app_php/APIs/esp/list_usuarios_api.php");
    return json.decode(response.body);
  }

  Future<Map> _cerrarsesion() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
//login.setString('stringLogin', "False");
    login.clear();
//login.setString('stringLogin', "True");
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) => new Myapp1()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            //`true` if you want Flutter to automatically add Back Button when needed,
            //or `false` if you want to force your own back button every where
            title: Text('Cuenta'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new Myapp1())),
            )),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.black,
                    Colors.white,
                  ])),
          child: FutureBuilder(
              future: _loadUser(),
              builder: (context, snapshot) {
                //String boolAsString = snapshot.data["USU_NOTIFICACIONES"];
                //bool isSwitched = boolAsString == 'true';
                // bool isSwitched = snapshot.data["USU_NOTIFICACIONES"];
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      setState(() {
                        _cerrarsesion();
                      });
                      return Center(
                          child: Text(
                            "Error :(",
                            style: TextStyle(color: Colors.black, fontSize: 25.0),
                            textAlign: TextAlign.center,
                          ));
                    } else {
                      return ListView(
                        children: <Widget>[
                          Center(
                            child: Column(children: <Widget>[
                              Row(children: <Widget>[
                                Text(
                                  "Perfil",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),

                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Nombre:",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Text(
                                      snapshot.data["USU_NOMBRE"],
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    )
                                  ]),
                              SizedBox(height: 15.0),

                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Correo:",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Text(
                                      snapshot.data["USU_CORREO"],
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ]),
                              SizedBox(height: 15.0),

                              ///config
                              Row(children: <Widget>[
                                Text(
                                  "Configuración",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),

                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Notificaciones:",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    /*Switch(
                                      value: isSwitched,
                                      onChanged: (value) {
                                        setState(() {
                                          isSwitched = value;
                                          print(isSwitched);
                                        });
                                      },
                                      activeTrackColor: Colors.lightGreenAccent,
                                      activeColor: Color(0xff773E42),
                                    ),*/
                                  ]),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  RaisedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // return object of type Dialog
                                            return StatefulBuilder(builder:
                                                (BuildContext context,
                                                StateSetter setState) {
                                              return AlertDialog(
                                                title: new Text("Solicitar ayuda"),
                                                content: Form(
                                                  key: _formKey,
                                                  child: Container(
                                                    height: 200,
                                                    child: Column(children: [
                                                      DropdownButton(
                                                          onTap: () {
                                                            setState(() {});
                                                          },
                                                          isExpanded: true,
                                                          value: _value,
                                                          items: [
                                                            DropdownMenuItem(
                                                              child: Text(
                                                                  "Problema con mi cuenta"),
                                                              value: 1,
                                                            ),
                                                            DropdownMenuItem(
                                                              child: Text(
                                                                  "Problema con mis puntos"),
                                                              value: 2,
                                                            ),
                                                            DropdownMenuItem(
                                                                child: Text(
                                                                    "Reportar bugs/problemas de la app"),
                                                                value: 3),
                                                            DropdownMenuItem(
                                                                child: Text(
                                                                    "Formar parte de CABOFIND"),
                                                                value: 4),
                                                          ],
                                                          onChanged: (valuex) {
                                                            setState(() {
                                                              _value = valuex;
                                                            });
                                                          }),
                                                      TextFormField(
                                                        controller: comment,
                                                        enabled: true,
                                                        maxLines: 5,
                                                        autofocus: false,
                                                        style:
                                                        TextStyle(fontSize: 15),
                                                        decoration: InputDecoration(
                                                            focusColor:
                                                            Color(0xffD3D7D6),
                                                            hoverColor:
                                                            Color(0xffD3D7D6),
                                                            hintText:
                                                            'Escribir más detalles'),
                                                        validator: (value) {
                                                          if (value.isEmpty) {
                                                            return 'Este campo no puede estar vacío';
                                                          } else if (value.length <=
                                                              9) {
                                                            return 'Requiere 10 dígitos';
                                                          }
                                                          return null;
                                                        },
                                                      )
                                                    ]),
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  // usually buttons at the bottom of the dialog
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                    children: <Widget>[
                                                      new FlatButton(
                                                        child: new Text("Cancelar"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      new FlatButton(
                                                        child: new Text("Envíar",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff60032D))),
                                                        onPressed: () {
                                                          if (_formKey.currentState
                                                              .validate()) {
                                                            ayudamail();

                                                            Navigator.of(context)
                                                                .pop();
                                                            //comment.clear();
                                                          }
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
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(40.0)),
                                      color: Colors.blue[300],
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text('Ayuda ',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                          new Icon(
                                            FontAwesomeIcons.questionCircle,
                                            color: Colors.white,
                                          )
                                        ],
                                      )),
                                  RaisedButton(
                                      onPressed: () {
                                        _cerrarsesion();
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(40.0)),
                                      color: Colors.red,
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text('Cerrar sesión',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                          new Icon(
                                            FontAwesomeIcons.signOutAlt,
                                            color: Colors.white,
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ]),
                          ),
                        ],
                      );
                    }
                }
              }),
        ));
  }
}