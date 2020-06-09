import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';



class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage>with TickerProviderStateMixin {
  int leftDiceNumber = 0;
  int start = 0;
Animation _control;
 AnimationController _controller;
  void throwDices() {
    Future.delayed(const Duration(seconds:5));
    setState(() {
      
      leftDiceNumber = Random().nextInt(6) + 1;
    });
  }
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _control =
        Tween(begin: 0.0, end: pi).animate(_controller);
  }  

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<Map> _checkDado() async { 
  final SharedPreferences login = await SharedPreferences.getInstance();
 String _status = "";
 String _mail ="";
 String _mail2 ="";
 String _idusu="";  
_status = login.getString("stringLogin");
 _mail2 = login.getString("stringMail");   

  http.Response response = await http.get("http://cabofind.com.mx/app_php/APIs/esp/list_check_dados.php?CORREO=$_mail2");
  return json.decode(response.body);
  
  }  

    Future<Map> _checkCompartidas() async { 
  final SharedPreferences login = await SharedPreferences.getInstance();
 String _mail2 ="";
 _mail2 = login.getString("stringMail");   

  http.Response response = await http.get("http://cabofind.com.mx/app_php/APIs/esp/list_check_share.php?CORREO=$_mail2");
  return json.decode(response.body);
  
  }  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Regresar')),
          body: Container(
           // color: Color(0xff01969a),
            child: Column(
              children: [
                Text('Obten puntos para: ',style: TextStyle(fontSize: 20,color: Colors.black),),
                SizedBox(height:10),
                Text('Chiltepinos',style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
                SizedBox(height:10),
      AnimatedBuilder(
      animation: _controller,
      child: Container(
              color: Color(0xff01969a),  
                child: Center( 
                child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      child: Image.asset('assets/dice$leftDiceNumber.png'),
                     // onPressed: throwDices,
                    ),
                  ),
                ],
                  ),
                ),
              ),
      builder: (BuildContext context, Widget child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * math.pi,
          child: child,
        );
      },
    ),  

             /* Container(
              color: Color(0xff01969a),  
                child: Center( 
                child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      child: Image.asset('assets/dice$leftDiceNumber.png'),
                     // onPressed: throwDices,
                    ),
                  ),
                ],
                  ),
                ),
              ),*/
              FutureBuilder(
          future: _checkDado(),
          builder: (context, snapshot) {    
            //var _contadorx = int.parse(snapshot.data["ID_DADOS"]);         
              switch (snapshot.connectionState) {
                
                case ConnectionState.none:
                case ConnectionState.waiting:
                return Center(
                      child: CircularProgressIndicator()
                  );
                default:
                  if (snapshot.hasError) {
                    return RaisedButton(
                                onPressed: () {
            _controller.isCompleted
                ? _controller.reverse()
                : _controller.forward();
                throwDices();
          }, 
                                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
                                color: Colors.white, 
                                child: new Row (
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,

                                          children: <Widget>[
                                            new Text('Tirar dado de la suerte :)  ', style: TextStyle(fontSize: 20, color: Colors.black)), 
                                            new Icon(FontAwesomeIcons.dice, color: Colors.black,)
                                          ],
                                        )
                              );
                  } else if(snapshot.data["ID_DADOS"] != null) {
                
                    return  RaisedButton(
                                onPressed: null,  
                                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
                                color: Colors.white, 
                                child: new Row (
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,

                                          children: <Widget>[
                                            new Text('Ya has hecho tu tiro diario  ', style: TextStyle(fontSize: 20, color: Colors.black)), 
                                            new Icon(FontAwesomeIcons.dice, color: Colors.black,)
                                          ],
                                        )
                              );
                  }  
                
              }
          }),
                        FutureBuilder(
          future: _checkCompartidas(),
          builder: (context, snapshot) { 
              var _contadorx = int.parse(snapshot.data["TOTAL"]);        
              switch (snapshot.connectionState) {
                 
                case ConnectionState.none:
                case ConnectionState.waiting:
                return Center(
                      child: CircularProgressIndicator()
                  );
                default:
                  if (snapshot.hasError) {
                   
                    String total= snapshot.data["TOTAL"];
                    return   RaisedButton(
                                onPressed: (){
                                  Share.share('Descarga Cabofind, obten puntos y canjealos por increibles recompensas https://bit.ly/33ywdUS');
                                  },  
                                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
                                color: Colors.white, 
                                child: new Row (
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,

                                          children: <Widget>[
                                            new Text('Número de compartidas: '+total, style: TextStyle(fontSize: 20, color: Colors.black)), 
                                            new Icon(FontAwesomeIcons.share, color: Colors.black,)
                                          ],
                                        )
                              );
                  } else if (_contadorx >=5) {
                    return      RaisedButton(
                                onPressed: throwDices,  
                                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
                                color: Colors.white, 
                                child: new Row (
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,

                                          children: <Widget>[
                                            new Text('Tirar dado de la suerte :)  ', style: TextStyle(fontSize: 20, color: Colors.black)), 
                                            new Icon(FontAwesomeIcons.dice, color: Colors.black,)
                                          ],
                                        )
                              );
                  }else {                
                   String _contador = snapshot.data["TOTAL"];
                    return      RaisedButton(
                                onPressed: (){
                                  Share.share('Descarga Cabofind, obten puntos y canjealos por increibles recompensas https://bit.ly/33ywdUS');
                                  },  
                                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
                                color: Colors.white, 
                                child: new Row (
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,

                                          children: <Widget>[
                                            new Text('Número de compartidas: '+_contador, style: TextStyle(fontSize: 20, color: Colors.black)), 
                                            new Icon(FontAwesomeIcons.share, color: Colors.black,)
                                          ],
                                        )
                              );}
                
              }
          }),


                              Text('Comparte 5 veces para obtener un tiro gratis!',style:TextStyle(color: Colors.black,fontSize: 12))   
                                                           
    ],
            ),
          ),
    );
  }
}