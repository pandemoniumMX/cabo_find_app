import 'dart:convert';

import 'package:cabofind/main_esp.dart';
import 'package:cabofind/paginas/usuario.dart';
import 'package:cabofind/paginas_ing/usuario.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:cabofind/utilidades/classes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
            builder: (BuildContext context) => new MyApp_ing()));
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
                                  activeTrackColor: Color(0xff773E42),
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
              builder: (BuildContext context) => new Myapp()));
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
              builder: (BuildContext context) => new Myapp()));
    } else {
      baneadoLogin();
    }
  }

  addLoginG(FirebaseUser user, name, email, imageUrl) async {
    final SharedPreferences login = await SharedPreferences.getInstance();

    final correofb = user.email;
    final nombre = user.displayName;
    final foto = user.photoUrl;

    final names = name;
    final correo = email;
    final picture = imageUrl;

    login.setString('stringLogin', "True");
    login.setString('stringMail', correofb);

    var response = await http.get(
        Uri.encodeFull(
            'http://cabofind.com.mx/app_php/APIs/esp/insert_usuarios.php?NOMBRE=${names}&CORREO=${correo}&FOTO=${picture}&NOT=true&IDIOMA=ING'),
        headers: {"Accept": "application/json"});

    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                new Usuario_ing(usuarios: new Users(correofb))));
  }

  addlogin() async {
    final SharedPreferences login = await SharedPreferences.getInstance();

    final correog = "tesging2";

    login.setString('stringLogin', "True");
    login.setString('stringMail', "testing@gmail.com");

    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new MyApp_ing()));
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
    addLoginG(user, name, email, imageUrl);
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
                  "Creat your account",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "To get more benefits",
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
                        new Text('Login with Facebook',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        new Icon(
                          FontAwesomeIcons.facebookSquare,
                          color: Colors.white,
                        )
                      ],
                    )),
                
            RaisedButton(
                  onPressed: (){signInWithApple();},  
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
                  color: Colors.black,  
                  child: new Row (
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text('Login with Apple ID   ', style: TextStyle(fontSize: 20, color: Colors.white)), 
                                            new Icon(FontAwesomeIcons.apple, color: Colors.white,)
                                          ],
                                        )
                ), 
/*
                RaisedButton(
                  onPressed: (){addlogin();},  
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
*/
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
                        new Text('Cabofind privacy policies   ',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        new Icon(
                          FontAwesomeIcons.userSecret,
                          color: Colors.black,
                        )
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
