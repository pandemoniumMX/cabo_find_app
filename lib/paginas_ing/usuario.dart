import 'dart:convert';

import 'package:cabofind/main_ing.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Usuario_ing extends StatefulWidget {
  final Users usuarios;

  Usuario_ing({Key key, @required this.usuarios}) : super(key: key);
  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario_ing> {
  void initState() {
    super.initState();
  }

  Future<Map> _loadUser() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
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
    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new MyApp_ing()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Color(0xff01969a),
            Colors.white,
          ])),
      child: FutureBuilder(
          future: _loadUser(),
          builder: (context, snapshot) {
            String boolAsString = snapshot.data["USU_NOTIFICACIONES"];
            bool isSwitched = boolAsString == 'true';
            // bool isSwitched = snapshot.data["USU_NOTIFICACIONES"];
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "Error :(",
                    style: TextStyle(color: Color(0xff01969a), fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                } else {
                  return ListView(
                    children: <Widget>[
                      Center(
                        child: Column(children: <Widget>[
                          Row(children: <Widget>[
                            Text(
                              "Profile",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Name:",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                                Text(
                                  snapshot.data["USU_NOMBRE"],
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                )
                              ]),
                          SizedBox(height: 15.0),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Email:",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                                Text(
                                  snapshot.data["USU_CORREO"],
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                              ]),
                          SizedBox(height: 15.0),

                          ///config
                          Row(children: <Widget>[
                            Text(
                              "Settings",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Push notifications:",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                                Switch(
                                  value: isSwitched,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched = value;
                                      print(isSwitched);
                                    });
                                  },
                                  activeTrackColor: Colors.lightGreenAccent,
                                  activeColor: Colors.green,
                                ),
                              ]),

                          Center(
                            child: RaisedButton(
                                onPressed: () {
                                  _cerrarsesion();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0)),
                                color: Colors.red,
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text('Sign out',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
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
