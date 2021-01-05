import 'dart:convert';

import 'package:cabofind/main_ing.dart';
import 'package:cabofind/paginas_ing/misfavoritos.dart';
import 'package:cabofind/paginas_ing/mispromos.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
 TextEditingController comment = TextEditingController();
  TextEditingController txt_celular = TextEditingController();
  List ciudad;
  String _ciudades;
  int _value = 1;
  int _idioma = 1;
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

  Future<String> getCiudad() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getString('stringLenguage');
    prefs.getString('stringCity');
    String _city = prefs.getString('stringCity');
    String _idi = prefs.getString('stringLenguage');
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx//app_php/consultas_negocios/esp/ciudades.php"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      ciudad = json.decode(response.body);
      _ciudades = _city;
      _idioma = int.parse(_idi);
    });
    for (var u in ciudad) {
      // userStatus.add(false);
    }
    return "Success!";
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

  Future<String> updateCelular() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/update_cel.php?IDF=$_mail2&CEL=${txt_celular.text}"),
        headers: {"Accept": "application/json"});
  }

  saveIdioma(String idioma) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stringLenguage', idioma);
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) => new Myapp1()));
  }

  saveCity(String ciudad) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stringCity', ciudad);
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) => new Myapp1()));
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

  void initState() {
    super.initState();
    this.getCiudad();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white60, Colors.white60])),
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
                } else if (1 == null) {
                  return Center(
                      child: Text(
                        "Error :(",
                        style: TextStyle(color: Colors.black, fontSize: 25.0),
                        textAlign: TextAlign.center,
                      ));
                } else {
                  return ListView(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(children: <Widget>[
                          Container(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                snapshot.data["USU_FOTO"] != null
                                    ? Container(
                                        width: 150.0,
                                        height: 150.0,
                                        decoration: new BoxDecoration(
                                          color: const Color(0xff7c94b6),
                                          image: new DecorationImage(
                                            image: NetworkImage(
                                              snapshot.data["USU_FOTO"],
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(100.0)),
                                          border: new Border.all(
                                            color: Colors.white,
                                            width: 2.0,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 150.0,
                                        height: 160.0,
                                        decoration: new BoxDecoration(
                                          color: Colors.white,
                                          image: new DecorationImage(
                                            image: ExactAssetImage(
                                                'assets/noprofile.png'),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(100.0)),
                                          border: new Border.all(
                                            color: Colors.white,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Text(
                            snapshot.data["USU_NOMBRE"],
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff192227),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          

                          SizedBox(height: 15.0),
                          InkWell(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.heart),
                                  Text(
                                    " My favorites",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Color(0xff192227),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Mis_favoritos_ing()));
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          InkWell(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.calendarAlt),
                                  Text(
                                    " My reservations",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Color(0xff192227),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Mis_reservaciones_ing()));
                            },
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          InkWell(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.envelope),
                                  Flexible(
                                    child: Text(
                                      ' ' + snapshot.data["USU_CORREO"],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xff192227),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]),
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          InkWell(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.mobileAlt),
                                  Flexible(
                                    child: Text(
                                      snapshot.data["USU_CELULAR"] != null
                                          ? ' ' +
                                              snapshot.data["USU_CELULAR"] +
                                              ' '
                                          : ' Write phone ',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xff192227),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Icon(FontAwesomeIcons.cog),
                                ]),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return AlertDialog(
                                      title: new Text("Phone number"),
                                      content: Form(
                                        key: _formKey,
                                        child: Container(
                                          height: 70,
                                          child: Column(children: [
                                            TextFormField(
                                              controller: txt_celular,
                                              enabled: true,
                                              maxLines: 1,
                                              autofocus: true,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                WhitelistingTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              style: TextStyle(fontSize: 15),
                                              decoration: InputDecoration(
                                                  focusColor: Color(0xffD3D7D6),
                                                  hoverColor: Color(0xffD3D7D6),
                                                  hintText:
                                                      'Write cell phone to 10 digits'),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'This field can not be empty';
                                                } else if (value.length <= 9) {
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
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            new FlatButton(
                                              child: new Text("Cancel"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            new FlatButton(
                                              child: new Text("Save",
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff60032D))),
                                              onPressed: () {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  setState(() {
                                                    updateCelular();
                                                  });

                                                  Navigator.of(context).pop();
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
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          ///config
                          Text(
                            "Settings",
                            style: TextStyle(
                                fontSize: 30,
                                color: Color(0xff192227),
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.mapMarkerAlt),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      hint: Text('Select city'),
                                      items: ciudad.map((item) {
                                        return new DropdownMenuItem(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                new Text(
                                                  item['CIU_NOMBRE'],
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Color(0xff192227),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ]),
                                          value: item['idciudades'].toString(),
                                        );
                                      }).toList(),
                                      onTap: null,
                                      onChanged: (newVal) {
                                        setState(() {
                                          _ciudades = newVal;
                                          saveCity(newVal);
                                        });
                                      },

                                      value: _ciudades,

                                      // isExpanded: true,
                                    ),
                                  ),
                                ]),
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.globeAmericas),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isExpanded: false,
                                      items: [
                                        DropdownMenuItem(
                                          child: Row(children: [
                                            Text(
                                              " Español",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Color(0xff192227),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ]),
                                          value: 1,
                                        ),
                                        DropdownMenuItem(
                                          child: Row(children: [
                                            Text(
                                              " English",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Color(0xff192227),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ]),
                                          value: 2,
                                        ),
                                      ],
                                      onChanged: (nadax) {
                                        setState(() {
                                          _idioma = nadax;
                                          saveIdioma(nadax.toString());
                                        });
                                      },
                                      value: _idioma,
                                    ),
                                  ),
                                ]),
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          /*Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Notificaciones:",
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xff192227)),
                                ),
                                 Switch(
                                    value: isSwitched,
                                    onChanged: (value) {
                                      setState(() {
                                        isSwitched = value;
                                        print(isSwitched);
                                      });
                                    },
                                    activeTrackColor: Color(0xff192227),
                                    activeColor: Colors.black),
                              ]),*/

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.questionCircle),
                                      Text(
                                        " Help",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Color(0xff192227),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter setState) {
                                        return AlertDialog(
                                          title: new Text("Request help"),
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
                                                              "roblem with bugs"),
                                                          value: 3),
                                                      DropdownMenuItem(
                                                          child: Text(
                                                              "Join in CABOFIND"),
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
                                                          'Escribir detalles'),
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
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                new FlatButton(
                                                  child: new Text("Cancel"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
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
                              ),
                              InkWell(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.signOutAlt),
                                      Text(
                                        " Log out",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Color(0xff192227),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                                onTap: () {
                                  _cerrarsesion();
                                },
                              ),
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
