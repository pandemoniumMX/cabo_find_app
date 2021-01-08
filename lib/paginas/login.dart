import 'dart:convert';
import 'package:cabofind/main_esp.dart';
import 'package:cabofind/paginas/misfavoritos.dart';
import 'package:cabofind/paginas/mispromos.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import 'mis_reservaciones.dart';

class Login extends StatefulWidget {
  @override
  _Compras createState() => new _Compras();
}

class _Compras extends State<Login> {
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
        body: FutureBuilder(
      future: sesionLog(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data
              ? Usuario(usuarios: new Users("testing@gmail.com"))
              : Login2();
        }
        return Login2(); // noop, this builder is called again when the future completes
      },
    ));
  }
}

class Usuario extends StatefulWidget {
  final Users usuarios;

  Usuario({Key key, @required this.usuarios, Publicacion publicacion})
      : super(key: key);
  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {
  List ciudad;
  String _ciudades;
  int _value = 1;
  int _idioma = 1;

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

  final _formKey = GlobalKey<FormState>();

  TextEditingController comment = TextEditingController();
  TextEditingController txt_celular = TextEditingController();
  correo() async {
    final url =
        "mailto:cabofind@cabofind.com.mx?subject=Más informacion de la plataforma Cabofind";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<Map> _loadUser() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/list_usuarios_api.php?IDF=$_mail2");
    return json.decode(response.body);
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
    print('ciudad' + _city);
    print('idioma' + _idi);
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

  Future<String> updateCelular() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/update_cel.php?IDF=$_mail2&CEL=${txt_celular.text}"),
        headers: {"Accept": "application/json"});
  }

  Future<Map> _getPuntos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('stringLenguage');
    prefs.getString('stringCity');
    String _city = prefs.getString('stringCity');
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/get_puntos.php?IDF=$_mail2&CITY=$_city");
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

  void initState() {
    super.initState();
    this.getCiudad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*
      appBar: AppBar(

        automaticallyImplyLeading: true,
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.black,
        

        //`true` if you want Flutter to automatically add Back Button when needed,
        //or `false` if you want to force your own back button every where
        title:  Text("Perfil",style: TextStyle(fontSize:40, color: Colors.white,fontWeight: FontWeight.bold ),)
        
      ),*/

        //configuraion de perfil
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
                          Text(
                            'Puntos de consumidor',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          FutureBuilder(
                              future: _getPuntos(),
                              // ignore: missing_return
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                  case ConnectionState.waiting:
                                    return Center(
                                        child: CircularProgressIndicator());
                                  default:
                                    if (snapshot.hasError) {
                                      return Text(
                                        ' 0 PUNTOS',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      );
                                    } else if (snapshot.hasData) {
                                      return snapshot.data['Total'] != null
                                          ? Text(
                                              ' ' + snapshot.data['Total'],
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              ' 0 PUNTOS',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            );
                                    } else {}
                                }
                              }),

                          SizedBox(height: 15.0),
                          InkWell(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.heart),
                                  Text(
                                    " Mis favoritos",
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
                                          Mis_favoritos()));
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
                                    " Mis reservaciones",
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
                                          Mis_reservaciones()));
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
                                          : ' Ingresar celular ',
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
                                      title: new Text("Número de celular"),
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
                                                      'Escribir celular a 10 dígitos'),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Este campo no puede estar vacío';
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
                                              child: new Text("Cancelar"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            new FlatButton(
                                              child: new Text("Guardar",
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
                            "Preferencias",
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
                                      hint: Text('Seleccionar ciudad'),
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
                                        " Ayuda",
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
                                                  child: new Text("Cancelar"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
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
                              ),
                              InkWell(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.signOutAlt),
                                      Text(
                                        " Cerrar sesión",
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

class Login2 extends StatefulWidget {
  @override
  _Compras2 createState() => new _Compras2();
}

class _Compras2 extends State<Login2> {
  List ciudad;
  String _ciudades;
  int _idioma = 1;

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

  bool isLoggedIn = false;
  void initState() {
    //sesionLog(context);
    super.initState();
    this.getCiudad();
  }

  baneadoLogin() {
    Fluttertoast.showToast(
      msg: "No puedes iniciar sesión",
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  addLoginFB(FacebookLoginResult result) async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    final token = result.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,picture,email&access_token=${token}');
    final profile = json.decode(graphResponse.body);

    final id = profile['id'];
    final correofb = profile['email'];
    final nombresfb = profile['first_name'];
    final apellidosfb = profile['last_name'];
    final imagenfb = profile['picture']["data"]["url"];

    String tokenfirebase;
    tokenfirebase = login.getString("stringToken");
    var response = await http.get(
        Uri.encodeFull(
            'http://cabofind.com.mx/app_php/APIs/esp/insert_usuarios.php?NOMBRE=${nombresfb} ${apellidosfb}&CORREO=${correofb}&FOTO=${imagenfb}&NOT=true&IDIOMA=ESP&IDF=${id}&TOKEN=${tokenfirebase}'),
        headers: {"Accept": "application/json"});
    final perfil = json.decode(response.body);

    final val = perfil['USU_ESTATUS'];

    if (val == 'A') {
      login.setString('stringLogin', "True");
      login.setString('stringMail', correofb);
      login.setString('stringID', id);

      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new Myapp1()));
    } else {
      baneadoLogin();
    }
  }

  addlogin() async {
    final SharedPreferences login = await SharedPreferences.getInstance();

    final correog = "tesging2";

    login.setString('stringLogin', "True");
    login.setString('stringMail', "testing@gmail.com");
    login.setString('stringID', '54321');

    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new MyHomePages()));
  }

  borrarsesion() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    //login.setString('stringLogin', "False");
    //login.remove("stringLogin");
    //login.remove("stringMail");
    login.clear();
  }

  void signInWithFacebook() async {
    var login = FacebookLogin();
    var result = await login.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.error:
        print("Surgio un error");
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelado por el usuario");
        break;
      case FacebookLoginStatus.loggedIn:
        onLoginStatusChange(true);

        addLoginFB(result);
    }
  }

  /*
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String name;
String email;
String imageUrl;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
//final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;
//final FirebaseUser user = await _auth.signInWithCredential(credential).user;
  // Checking if email and name is null
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;

  // Only taking the first part of the name, i.e., First Name
  if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
  }

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  //return 'signInWithGoogle succeeded: $user';
  addLoginG(user,name,email, imageUrl);

  
}  */
  void onLoginStatusChange(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  _launchURL() async {
    const url = 'http://controly.com.mx/politicas.html';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "assets/cabofind.png",
                  fit: BoxFit.fill,
                  width: 150.0,
                  height: 150.0,
                )),
            SizedBox(
              height: 25.0,
            ),
            Text(
              "Inicio de sesión",
              style: TextStyle(
                  fontSize: 30,
                  color: Color(0xff192227),
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 25,
            ),
            InkWell(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.facebookSquare,
                      color: Color(0xff139CF8),
                    ),
                    Text(
                      " Sesión con Facebook",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color(0xff192227),
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
              onTap: () {
                signInWithFacebook();
              },
            ),

            /*
            RaisedButton(
                  onPressed: (){signInWithGoogle();},  
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
                  color: Colors.white,  
                  child: new Row (
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text('Sesión con Google   ', style: TextStyle(fontSize: 20, color: Colors.red)), 
                                            new Icon(FontAwesomeIcons.google, color: Colors.red,)
                                          ],
                                        )
                ), 
                RaisedButton(
                    onPressed: () {
                      addlogin();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    color: Colors.white,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text('Sesión local   ',
                            style: TextStyle(fontSize: 20, color: Colors.red)),
                        new Icon(
                          FontAwesomeIcons.google,
                          color: Colors.red,
                        )
                      ],
                    )),*/
            SizedBox(
              height: 25,
            ),
            Text(
              "Preferencias",
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.mapMarkerAlt),
                    DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text('Seleccionar ciudad'),
                        items: ciudad.map((item) {
                          return new DropdownMenuItem(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(
                                    item['CIU_NOMBRE'],
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Color(0xff192227),
                                        fontWeight: FontWeight.bold),
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
            InkWell(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        onChanged: (valuexs) {
                          setState(() {
                            _idioma = valuexs;
                            saveIdioma(valuexs.toString());
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
            InkWell(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.userSecret),
                    Text(
                      " Políticas de privacidad",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color(0xff192227),
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
              onTap: () {
                _launchURL();
              },
            ),
          ],
        )
      ],
    ));
  }
}
