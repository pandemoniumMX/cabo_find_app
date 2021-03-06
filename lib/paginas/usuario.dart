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
                                      activeColor: Color(0xff192227),
                                    ),*/
                                  ]),

                              Center(
                                child: RaisedButton(
                                    onPressed: () {
                                      _cerrarsesion();
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0)),
                                    color: Colors.black,
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    )),
                              )
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
