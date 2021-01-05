import 'dart:convert';

import 'package:cabofind/main_esp.dart';
import 'package:cabofind/paginas/usuario.dart';
import 'package:cabofind/paginas_ing/reservacion.dart';
import 'package:cabofind/paginas_ing/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../main_ing.dart';

class Login_ing extends StatefulWidget {
  @override
  _Compras createState() => new _Compras();
}

class _Compras extends State<Login_ing> {
  bool isLoggedIn = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
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
    print(checkValue);
    print(_status);
    print(_mail);

    // if (prefs.getString(_idioma) ?? 'stringValue' == "espanol")
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
              ? Usuario_ing(usuarios: new Users("testing@gmail.com"))
              : Login2();
        }
        return Login2(); // noop, this builder is called again when the future completes
      },
    ));
  }
}

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
                } else if (boolAsString == null) {
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
                              "Profile",
                              style: TextStyle(
                                  fontSize: 20,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Mail:",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Flexible(
                                  child: Text(
                                    snapshot.data["USU_CORREO"],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ]),
                          SizedBox(height: 15.0),

                          ///config
                          Row(children: <Widget>[
                            Text(
                              "Settings",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Notifications:",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
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
                                  activeColor: Colors.black,
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
                                    new Text('Log Out',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white)),
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

class Login2 extends StatefulWidget {
  @override
  _Compras2 createState() => new _Compras2();
}

class _Compras2 extends State<Login2> {
  bool isLoggedIn = false;
     final _formKey = GlobalKey<FormState>();
 TextEditingController comment = TextEditingController();
  TextEditingController txt_celular = TextEditingController();
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
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  void initState() {
    //sesionLog(context);
    super.initState();
    this.getCiudad();
  }
  baneadoLogin() {
    Fluttertoast.showToast(
      msg: "Can't login",
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  Future<String> signInWithApple() async {

    final SharedPreferences login = await SharedPreferences.getInstance();
    String tokenfirebase;
    tokenfirebase = login.getString("stringToken");

    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,


      ],
    );
    final oAuthProvider = OAuthProvider(providerId: 'apple.com');
    final credential = oAuthProvider.getCredential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,

    );
    String nombre = appleIdCredential.givenName;
    String apellido = appleIdCredential.familyName;
    String id = appleIdCredential.userIdentifier;
    String email = appleIdCredential.email;


    final response = await http.get(
        Uri.encodeFull(
            'http://cabofind.com.mx/app_php/APIs/esp/insert_usuarios.php?NOMBRE=${nombre} ${apellido}&CORREO=${email}&NOT=true&IDIOMA=ESP&IDF=${id}&TOKEN=${tokenfirebase}'),
        headers: {"Accept": "application/json"});
    final perfil = json.decode(response.body);

    final val = perfil['USU_ESTATUS'];

    if (val == 'A') {
      login.setString('stringLogin', "True");
      login.setString('stringMail', email);
      login.setString('stringID', id);

      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new MyHomePages()));
    } else {
      baneadoLogin();
    }

  }

  addLoginFB(FacebookLoginResult result) async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    final token = result.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,picture,email&access_token=${token}');
    final profile = json.decode(graphResponse.body);
    print(
      profile['email'],
    );
    print(
      profile['last_name'],
    );
//final pictures= profile[ 'picture']["data"]["url"];
    final id = profile['id'];
    final name = profile['name'];
    final correofb = profile['email'];
    final nombresfb = profile['first_name'];
    final apellidosfb = profile['last_name'];
    final imagenfb = profile['picture']["data"]["url"];

    String tokenfirebase;
    tokenfirebase = login.getString("stringToken");
    final response = await http.get(
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
              builder: (BuildContext context) => new MyHomePages()));
    } else {
      baneadoLogin();
    }
  }


  addlogin() async {
    final SharedPreferences login = await SharedPreferences.getInstance();

    final correog = "tesging2";

    login.setString('stringLogin', "True");
    login.setString('stringMail', "testing@gmail.com");

    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new MyHomePages_ing()));
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
              height: 50.0,
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
              "Login",
              style: TextStyle(
                  fontSize: 30,
                  color: Color(0xff192227),
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 25,
            ),
           /* InkWell(
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
            ),*/
            RaisedButton(
                  onPressed: (){
                signInWithFacebook();
                    },  
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
                  color: Color(0xff139CF8),  
                  child: new Row (
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Icon(FontAwesomeIcons.facebookSquare, color: Colors.white,),
                                            new Text(' Sign in with Facebook  ', style: TextStyle(fontSize: 20, color: Colors.white)),

                                          ],
                                        )
                ),
                RaisedButton(
                  onPressed: (){
                    signInWithApple();
                    },  
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
                  color: Colors.black,  
                  child: new Row (
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Icon(FontAwesomeIcons.apple, color: Colors.white,),
                                            new Text(' Sign in with Apple  ', style: TextStyle(fontSize: 20, color: Colors.white)),

                                          ],
                                        )
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
                      " Privacy policies",
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



