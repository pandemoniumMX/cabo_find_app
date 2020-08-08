import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'package:cabofind/main_esp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class Login_esp extends StatefulWidget {
  @override
  _Compras2 createState() => new _Compras2();
}

class _Compras2 extends State<Login_esp> {
  bool isLoggedIn = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  void initState() {
    //sesionLog(context);
    super.initState();
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
    print(name);

    login.setString('stringLogin', "True");
    login.setString('stringMail', correofb);
    login.setString('stringID', id);
    tokenfirebase = login.getString("stringToken");

    var response = await http.get(
        Uri.encodeFull(
            'http://cabofind.com.mx/app_php/APIs/esp/insert_usuarios.php?NOMBRE=${nombresfb},${apellidosfb}&CORREO=${correofb}&FOTO=${imagenfb}&NOT=true&IDIOMA=ESP&IDF=${id}&TOKEN=${tokenfirebase}'),
        headers: {"Accept": "application/json"});

    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) => new Myapp()));
  }

  /*addLoginG(FirebaseUser user, name, email, imageUrl) async {
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
            'http://cabofind.com.mx/app_php/APIs/esp/insert_usuarios.php?NOMBRE=${names}&CORREO=${correo}&FOTO=${picture}&NOT=true&IDIOMA=ESP'),
        headers: {"Accept": "application/json"});

    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                new Usuario(usuarios: new Users(correofb))));
  }*/

  addlogin() async {
    final SharedPreferences login = await SharedPreferences.getInstance();

    final correog = "tesging2";

    login.setString('stringLogin', "True");
    login.setString('stringMail', "testing@gmail.com");
    login.setString('stringID', '54321');

    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) => new Myapp()));
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
    const url = 'http://cabofind.com.mx/admin/politicas.html';
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
            Colors.black,
            Colors.white,
          ])),
      child: Center(
        child: ListView(
          shrinkWrap: false,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      "assets/splash.png",
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
                  "Para poder ordenar",
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
                        new Text('Sesión con Facebook',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        new Icon(
                          FontAwesomeIcons.facebookSquare,
                          color: Colors.white,
                        )
                      ],
                    )),
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
                        new Text('Políticas de privacidad   ',
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
