import 'dart:convert';

import 'package:cabofind/main_esp.dart';
import 'package:cabofind/paginas/misfavoritos.dart';
import 'package:cabofind/paginas/mispromos.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Perfil",
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
                                  "Nombre:",
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
                                  "Correo:",
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xff773E42)),
                                ),
                                Flexible(
                                                                  child: Text(
                                    snapshot.data["USU_CORREO"],
                                    style: TextStyle(
                                        fontSize: 15, color: Color(0xff773E42)),overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]),
                          SizedBox(height: 15.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Mis favoritos",
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
                                            Mis_favoritos()));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0)),
                              color: Color(0xffED393A),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Ver mis negocios guardados',
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
                                  "Mis promos ",
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
                                            Mis_promos()));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0)),
                              color: Color(0xffF4A32C),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text('Ver mis promos guardadas ',
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
                                  "Mis Reservaciones ",
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
                                            Mis_reservaciones()));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0)),
                              color: Colors.black,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text('Ver mis reservaciones ',
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
                              "Más opciones",
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


class Login2 extends StatefulWidget {
  @override
  _Compras2 createState() => new _Compras2();
}

final _formKey = GlobalKey<FormState>();
int _value = 1;
TextEditingController comment = TextEditingController();

class _Compras2 extends State<Login2> {
  bool isLoggedIn = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  void initState() {
    //sesionLog(context);
    super.initState();
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
              MaterialPageRoute(builder: (context) => Myapp1()),
            );

      
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

    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) => new MyHomePages()));
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
String imageUrl;*/

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
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Colors.white,
            Colors.white,
          ])),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Column(
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
                  height: 50.0,
                ),
                Text(
                  "Crea tu cuenta",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Para más beneficios",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                RaisedButton(
                    onPressed: () {
                      signInWithFacebook();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    color: Color(0xff4267b2),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Icon(
                          FontAwesomeIcons.facebookSquare,
                          color: Colors.white,
                        ),
                        new Text(' Sesión con Facebook',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),

                      ],
                    )),
                
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
                                            new Text(' Iniciar sesion con Apple  ', style: TextStyle(fontSize: 20, color: Colors.white)),

                                          ],
                                        )
                ), /*
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
                RaisedButton(
                    onPressed: () {
                      _launchURL();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    color: Colors.white,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Icon(
                          FontAwesomeIcons.userSecret,
                          color: Colors.black,
                        ),
                        new Text(' Políticas de privacidad   ',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),

                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
