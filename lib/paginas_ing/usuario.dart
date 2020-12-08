import 'dart:convert';

import 'package:cabofind/main_ing.dart';
import 'package:cabofind/paginas_ing/misfavoritos.dart';
import 'package:cabofind/paginas_ing/mispromos.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import 'mis_reservaciones.dart';

class Usuario_ing extends StatefulWidget {
  final Users usuarios;

  Usuario_ing({Key key, @required this.usuarios}) : super(key: key);
  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario_ing> {

  final _formKey = GlobalKey<FormState>();
  int _value = 1;
  TextEditingController comment = TextEditingController();
  correo() async {
    final url =
        "mailto:cabofind@cabofind.com.mx?subject=Más informacion de la plataforma Cabofind";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
            builder: (BuildContext context) => new Myapp1()));
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
            Colors.white,
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
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                } else {
                  return ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          
                          children: <Widget>[
                          Row(
                            
                            children: <Widget>[
                            
                            Text(
                              "Profile",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff773E42),
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Name:",
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xff773E42)),
                                ),
                                Text(
                                  snapshot.data["USU_NOMBRE"],
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xff773E42),
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
                                      fontSize: 15, color: Color(0xff773E42)),
                                ),
                                Text(
                                  snapshot.data["USU_CORREO"],
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xff773E42)),
                                ),
                              ]),
                          SizedBox(height: 15.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "My favorites ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff773E42),
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                          RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Mis_favoritos_ing()));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0)),
                              color: Color(0xffED393A),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'See my favorites places',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                  new Icon(
                                    FontAwesomeIcons.solidHeart,
                                    color: Colors.white,
                                  )
                                ],
                              )),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "My deals ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff773E42),
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),

                          RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Mis_promos_ing()));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0)),
                              color: Color(0xffF4A32C),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text('See my deals ',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white)),
                                  new Icon(
                                    FontAwesomeIcons.fire,
                                    color: Colors.white,
                                  )
                                ],
                              )),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "My reservations ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff773E42),
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),

                          RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Mis_reservaciones_ing()));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0)),
                              color: Colors.black,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text('See my reservations ',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white)),
                                  new Icon(
                                    FontAwesomeIcons.calendarAlt,
                                    color: Colors.white,
                                  )
                                ],
                              )),

                          ///config
                          Row(children: <Widget>[
                            Text(
                              "More options",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff773E42),
                                  fontWeight: FontWeight.bold),
                            ),
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
                                            title: new Text("Ask for help"),
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
                                                              "Problem with my account"),
                                                          value: 1,
                                                        ),
                                                        DropdownMenuItem(
                                                          child: Text(
                                                              "Problem with my points"),
                                                          value: 2,
                                                        ),
                                                        DropdownMenuItem(
                                                            child: Text(
                                                                "Report bugs / app problems"),
                                                            value: 3),
                                                        DropdownMenuItem(
                                                            child: Text(
                                                                "Become part of CABOFIND"),
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
                                                            'Write more details'),
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'This field can not be blank';
                                                      } else if (value.length <=
                                                          9) {
                                                        return 'Requires 10 digits';
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
                                                    child: new Text("Cancel"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  new FlatButton(
                                                    child: new Text("Send",
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
                                      new Text('Help ',
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
                                      new Text('Logout',
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
