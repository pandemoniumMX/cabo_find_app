import 'package:cabofind/paginas/domicilio.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Carrito_check extends StatefulWidget {
  @override
  _Compras2 createState() => new _Compras2();
}

class _Compras2 extends State<Carrito_check> {
  bool isLoggedIn = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  void initState() {
    //sesionLog(context);
    super.initState();
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
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new Domicilio(numeropagina: Categoria(0))));
      },
      child: new Scaffold(
          appBar: AppBar(
            title: Text('Regresar'),
          ),
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
                            "assets/cabofind.png",
                            fit: BoxFit.fill,
                            width: 150.0,
                            height: 150.0,
                          )),
                      SizedBox(
                        height: 50.0,
                      ),
                      Text(
                        "Carrito vacío",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Aún no has ordenado",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
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
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
