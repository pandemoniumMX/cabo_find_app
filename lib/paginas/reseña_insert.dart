/*
import 'dart:convert';
import 'package:cabofind/utilidades/classes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Resena extends StatefulWidget {
  final Empresa empresa;
  Resena({Key key, @required this.empresa}) : super(
    key: key);

@override
_Acercade createState() => new _Acercade();
}

class _Acercade extends State<Resena> {
final controllerCode =  TextEditingController();
  String _displayValue = "";
  _onSubmitted(String value) {
    setState(() => _displayValue = value);
  }
  
  
void getInfofb(FacebookLoginResult result) async { 
 //final result = await facebookSignIn.logInWithReadPermissions(['email']);
final token = result.accessToken.token;
final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,picture,email&access_token=${token}');
final profile = json.decode(graphResponse.body);
 print(profile[ 'email'],);
 print(profile[ 'last_name'],);
//final pictures= profile[ 'picture']["data"]["url"];
final id= profile['id'];
final correofb= profile['email'];
final nombresfb= profile['first_name'];
final apellidosfb= profile['last_name'];
final imagenfb = profile[ 'picture']["data"]["url"];
final resena = Text(controllerCode.text);
final valor = '👍';

//final imagenfb = profile['picture'];
//final url =  dataneg[0]["NEG_WEB"];
var response = await http.get(
        Uri.encodeFull(
            'http://cabofind.com.mx/app_php/APIs/esp/insertar_resena.php?ID_FB=${id}&CORREO=${correofb}&NOM=${nombresfb}&APE=${apellidosfb}&FOTO=${imagenfb}&IDIOMA=ESP&RESENA=${resena}&VALOR=${valor}&ID_N=${widget.empresa.id_nm}'),

        headers: {
          "Accept": "application/json"
        }
    );   
        }
        @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerCode.dispose();
    super.dispose();
  }
   
@override
Widget build(BuildContext context) {

 



return new Scaffold(
appBar: new AppBar(
title: new Text('Reseña'),
),
body: Center(
  child: Column(
    children: <Widget>[ 

      Center(
        child: Padding(
          padding: const EdgeInsets.only(top:150.0),
          child: FadeInImage(

                       image: AssetImage('android/assets/images/cabofind.jpeg'),
                       fit: BoxFit.cover,
                       width: 150,
                       height: 150,

                       placeholder: AssetImage('android/assets/images/loading.gif'),
                       fadeInDuration: Duration(milliseconds: 200), 

                     ),
        ),
      ),
      Text('Reseña',style: 
      TextStyle(
        color: Color(0XFF000000),
        fontSize:25.0,
        fontWeight: FontWeight.bold),),

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('Reporte de bugs o informacíon de Cabofind',style: 
      TextStyle(
          color: Color(0XFF000000),
          fontSize:18.0,
          ),),
        ),
              TextField(
                controller: controllerCode,
                onSubmitted: _onSubmitted,               
                maxLines: 5, 
                ),
        
        FlatButton(
                 child: new Text('Enviar'),
                 onPressed: (){ getInfofb;  
                 
                 },
               )

       

        
    ],
  ),

),
);
}
}
*/
