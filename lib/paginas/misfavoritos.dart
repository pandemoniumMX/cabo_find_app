import 'dart:convert';

import 'package:cabofind/main_esp.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas/usuario.dart';

import 'package:cabofind/utilidades/classes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'empresa_detalle.dart';
class Mis_favoritos extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Mis_favoritos> {
bool isLoggedIn=false;
final GlobalKey<State> _keyLoader = new GlobalKey<State>();
void initState() {

  //sesionLog();
  super.initState();
}

Future<bool>  sesionLog() async {
  
 final SharedPreferences login = await SharedPreferences.getInstance();
 String _status = "";
 String _mail ="";
 _status = login.getString("stringLogin")?? '';
 _mail = login.getString("stringMail")?? '';
 bool checkValue = login.containsKey('value');
 return checkValue = login.containsKey('stringLogin');
 print(checkValue);
 print(_status);
 print(_mail);
 
  // if (prefs.getString(_idioma) ?? 'stringValue' == "espanol")
  if (_status == "True") {
      print("Sesión ya iniciada");
    
    }
    else
    {
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
             return snapshot.data ?  Usuario2(usuarios: new Users("testing@gmail.com")) : Login3();
           }
           return Login3(); // noop, this builder is called again when the future completes
         },
       )
    );
    }
}



class Usuario2 extends StatefulWidget {
  final Users usuarios;
  
  Usuario2({Key key, @required this.usuarios}) : super(
    key: key);
  @override
  _UsuarioState createState() => _UsuarioState();
}



class _UsuarioState extends State<Usuario2> {

  List data;

  void initState(){
  super.initState();
  this._loadUser();

  }

  Future<Map> _loadUser() async {
final SharedPreferences login = await SharedPreferences.getInstance();
 String _status = "";
 String _mail ="";
 String _mail2 ="";
 _status = login.getString("stringLogin");
 _mail2 = login.getString("stringMail"); 
 
 print(_mail2) ;
  

  var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_favoritos_api.php?CORREO=$_mail2"),  
       
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          data = json.decode(
              response.body);
        });            
  
}
  
  

Future<Map> _cerrarsesion() async {
final SharedPreferences login = await SharedPreferences.getInstance();
//login.setString('stringLogin', "False");
login.clear();
//login.setString('stringLogin', "True");
Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Myapp1()
                        )
                        );
 
}
  @override
  Widget build(BuildContext context) {

    Widget estructura = ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
      
          return new ListTile(


            title: new Card(

              elevation: 5.0,
              child: new Container(
                child: Column(

                  children: <Widget>[
                    //Text("Texto",
                    Row(
                      mainAxisAlignment : MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        
                      FadeInImage(
                      image: NetworkImage(data[index]["GAL_FOTO"]),
                      fit: BoxFit.fill,
                      width:  MediaQuery.of(context).size.width * .20,
                      height: MediaQuery.of(context).size.height * .15,
                      placeholder: AssetImage('android/assets/images/loading.gif'),
                      fadeInDuration: Duration(milliseconds: 200),
                      ),  
                        Flexible(
                                  child: Text(data[index]["NEG_NOMBRE"],overflow: TextOverflow.ellipsis,softWrap: true,   
                                  style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0, color: Colors.black,)),
                              ),

                        FloatingActionButton(
                          child: new Image.asset(
                        "assets/delete.png",
                        fit: BoxFit.cover,
                        width: 20.0,
                        height: 20.0,

                      ),
                          elevation: 0.0,
                          backgroundColor: Colors.transparent,
                           onPressed: (){},

                        ),
                        
                  

                       


                      ],
                        


                    ),
                  ],

                ),

              ),

            ),

            onTap: () {
            String id_sql = data[index]["ID_NEGOCIO"];
              Navigator.push(context, new MaterialPageRoute
                (builder: (context) => new Empresa_det_fin(empresa: new Empresa(id_sql))));

            },
            
          );

        },

    );
    return Scaffold(
     
      body: ListView(
       
    children: <Widget>[                  
    Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [
          Color(0xff01969a),
          Colors.white,          
        ])),
      child: Text("Mis Favoritos",style: TextStyle(fontSize:40, color: Colors.white,fontWeight: FontWeight.bold ),)),
  
      estructura,


      ],
      ),
    );
  }
  
}

class Login3 extends StatefulWidget {
  @override
  _States createState() => _States();
}

class _States extends State<Login3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    
  colors: [
    Color(0xff01969a),
    Colors.white,
    
  ])),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100.0,),
            ClipRRect(borderRadius: BorderRadius.circular(8.0),child: Image.asset("assets/splash.png",fit: BoxFit.fill,width: 150.0,height: 150.0,)),
            SizedBox(height: 50.0,),
            Text("Crea tu cuenta",style: TextStyle(fontSize:25, color: Colors.white,fontWeight: FontWeight.bold ),),
            Text("Para agregar tus favoritos!",style: TextStyle(fontSize:25, color: Colors.white,fontWeight: FontWeight.bold ),),
            SizedBox(height: 50.0,),
            ClipRRect(borderRadius: BorderRadius.circular(8.0),child: Image.asset("assets/corazon2.png",fit: BoxFit.fill,width: 80.0,height: 80.0,)),
            
            

          ],
        ),
      ),
    );
  }
}