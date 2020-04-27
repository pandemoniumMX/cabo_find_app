import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/ricky_preparing.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  


class Myapp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
   return new MaterialApp(
   
        debugShowCheckedModeBanner:false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xff01969a),
          //primaryColor: Colors.blue,
          accentColor: Colors.black26,
        ),
        home: new Container(
            child:           new Ricky_general()
        )
    );
  }
}



class Ricky_general extends StatefulWidget {
  final Empresa empresa;
  @override

  Ricky_general({Key key, @required this.empresa}) : super(
    key: key);
  _MyHomePageState createState() => new _MyHomePageState();


}



class _MyHomePageState extends State<Ricky_general> {
  Completer<GoogleMapController> _controller = Completer();

  TextEditingController pedido =  TextEditingController();
  TextEditingController nombre =  TextEditingController();
  TextEditingController numero =  TextEditingController();

  String _displayValue = "";



  

   Map userProfile;

 List _cities  =
  ["👍", "👎"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;
  String _mySelection;
  String _mispagos;

  bool isLoggedIn=false;
  List data;
  List data_serv;
  List playas;
  List pagos;
  List dataneg;
  List data_list;
  List data_carrusel;
  List data_hor;
  List logos;
  List descripcion;
  List data_resena;


Future<String> getPlaya() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_playas.php"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          playas = json.decode(
              response.body);
        });


    return "Success!";
  }

  Future<String> getPagos() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_pagos.php"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          pagos = json.decode(
              response.body);
        });


    return "Success!";
  }
  Future<String> getInfo() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_domicilio.php?ID=${widget.empresa.id_nm}"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          dataneg = json.decode(
              response.body);
        });


    return "Success!";
  }

  
 

  Future<String> getCar() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_caracteristicas_api.php?ID=${widget.empresa.id_nm}"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          data = json.decode(
              response.body);
        });


    return "Success!";
  }


  Future<String> getSer() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_servicios_api.php?ID=${widget.empresa.id_nm}"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
              data_serv = json.decode(
              response.body);
        });


    return "Success!";
  }



  Future<String> getHorarios() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_horarios_api.php?ID=${widget.empresa.id_nm}"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
              data_hor = json.decode(
              response.body);
        });


    return "Success!";
  }


  
   Future<String> getCarrusel() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/galeria_api.php?ID=${widget.empresa.id_nm}"),

        headers: {
          "Accept": "application/json"
        }
    );
    this.setState(
            () {
          data_carrusel = json.decode(
              response.body);
        });
    return "Success!";
  }
  
  



  void initState() {
     
   
    super.initState();
    this.getCar();
    this.getSer();
    this.getCarrusel();
    this.getHorarios();
    this.getInfo();   
    this.getPlaya();
    this.getPagos();
    //this.getLocation(context);
    //this._currentLocation();
   
  
   // this.insertVisitaiOS;

  }


  
void onLoginStatusChange(bool isLoggedIn){
  setState(() {
   this.isLoggedIn=isLoggedIn; 
   
  });
}

void showResena() {
      Fluttertoast.showToast(
          msg: "Pedido enviado exitosamente",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Color(0xff01969a),
          textColor: Colors.white,
          timeInSecForIos: 1);
    }

 

      @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    pedido.dispose();
    nombre.dispose();
    super.dispose();
  }



 Widget build(BuildContext context){

alertCar(context) async {  
     return showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type AlertDialog
              return AlertDialog(
                //. Disponible únicamente en Cabo San Lucas
                title: new Text("Terminos Ricky's Corner"),
                content: Text("En caso de dañar el equipo de playa, se deberá cubrir el 50% "+
                  "del valor del equipo dañado."),
                actions: <Widget>[
                 new FlatButton(
                   child: new Text('Cerrar'),
                   onPressed: () {
                     Navigator.of(context).pop();                     
                   },
                 ), 
                 new FlatButton(
                   color: Colors.blueAccent,
                   child: new Text('Acepto los terminos',style: TextStyle(fontSize: 14.0,color: Colors.white),),
                   onPressed: () { 
                   Navigator.of(context).pop(); 
                   String paquete = dataneg[0]["NEG_NOMBRE"];
                   String costo = dataneg[0]["NEG_WEB"];

                    Navigator.push(
                    context,
                    new MaterialPageRoute(
                          builder: (BuildContext context) => new Rick_preparing(costos: new Costos(paquete,costo))
                          )
                        );
                  
                                    },
                 )
               ],
              );
            },
          );
   }
   
      
 Widget carrusel =   new CarouselSlider.builder(      
 autoPlay: true,
 height: 500.0,
 aspectRatio: 16/9,
 viewportFraction: 0.9,
 autoPlayInterval: Duration(seconds: 3),
 autoPlayCurve: Curves.fastOutSlowIn,
 itemCount: data_carrusel == null ? 0 : data_carrusel.length,
 itemBuilder: (BuildContext context, int index)  =>
   Container(
       child:FadeInImage(
 
              image: NetworkImage(data_carrusel[index]["GAL_FOTO"]),
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,

              // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
              placeholder: AssetImage('android/assets/images/loading.gif'),
              fadeInDuration: Duration(milliseconds: 200),

            ),
   ),
     );
 

    
    Widget titleSection = Container (
      height: 60.0,
      child: ListView.builder(
        shrinkWrap: false,
        physics: BouncingScrollPhysics(),
        itemCount: dataneg == null ? 0 : dataneg.length,
        itemBuilder: (BuildContext context, int index) {    

         return  new Column(
          children:[
            Row(
              mainAxisAlignment: 
              MainAxisAlignment.center,            
              children: [

                   Text(
                    dataneg[0]["NEG_NOMBRE"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                       //color: Colors.blue[500],
                    ),
                  ),               

              ],
            ),
         
          ],       
        );
       },
      
      )
    
    );

   // Color color = Theme.of(context).primaryColor;


    Widget textSection = Column(     
     children: <Widget>[
        new ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: dataneg == null ? 0 : dataneg.length,
       itemBuilder: (BuildContext context, int index) {
  //padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20);
      return new Card(
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30.0) ),
          child: Text(
          dataneg[index]["NEG_DESCRIPCION"],        
          maxLines: 20,
          softWrap: true,
          textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
        ),
      );
       }
      )
      ]
    );

    Widget logo = Column(
     // height:  MediaQuery.of(context).size.height,
    
      children: <Widget>[
         new ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: dataneg == null ? 0 : dataneg.length,
       itemBuilder: (BuildContext context, int index) {

      return new FadeInImage(

                    image: NetworkImage(dataneg[index]["GAL_FOTO"]),
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,

                    // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                    placeholder: AssetImage('android/assets/images/loading.gif'),
                    fadeInDuration: Duration(milliseconds: 200),

                  );
       }
      )
      ]
    );


   Widget buttonSection = Column(
     //width: MediaQuery.of(context).size.width +30,

     children: <Widget>[
        new ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: dataneg == null ? 0 : dataneg.length,
       itemBuilder: (BuildContext context, int index) {

_alertCobertura(BuildContext context) async {
     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(             
             title: Text('Costo de cobertura nocturna',style: TextStyle(fontSize: 25.0,),),
             content: FadeInImage(

                    image: NetworkImage("http://cabofind.com.mx/assets/galeria/cobertura.png"),
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,

                    // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                    placeholder: AssetImage('android/assets/images/loading.gif'),
                    fadeInDuration: Duration(milliseconds: 200),

                  ),
             actions: <Widget>[
               new FlatButton(
                 child: new Text('Cerrar'),
                 onPressed: () {
                   Navigator.of(context).pop();
                 },
               )
             ],
           );
         });
   }


   _alertCar(BuildContext context) async {
     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Contenido',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: double.maxFinite,
                 height: 300.0,
                 child: ListView.builder(
                     itemCount: data == null ? 0 : data.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: <Widget>[
                           Container(child: Text(data[index]["CAR_NOMBRE_MENU"],style: TextStyle(fontSize: 20.0,),),padding: EdgeInsets.only(bottom:15.0),) ,
                         ],
                       );
                     }
                 )
             ),
             actions: <Widget>[
               new FlatButton(
                 child: new Text('Cerrar'),
                 onPressed: () {
                   Navigator.of(context).pop();
                 },
               )
             ],
           );
         });
   }


   _alertSer(BuildContext context) async {
     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Playas',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: double.maxFinite,
                 height: 300.0,
                 child: ListView.builder(
                     itemCount: data_serv == null ? 0 : data_serv.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: <Widget>[
                           Container(child: Text(data_serv[index]["SERV_NOMBRE_MENU"],style: TextStyle(fontSize: 20.0,),),padding: EdgeInsets.only(bottom:15.0),) ,
                         ],
                       );
                     }
                 )
             ),
             actions: <Widget>[
               new FlatButton(
                 child: new Text('Cerrar'),
                 onPressed: () {
                   Navigator.of(context).pop();
                 },
               )
             ],
           );
         });
   }

    _alertHorario(BuildContext context) async {
     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Costos',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: double.maxFinite,
                 height: 150.0,
                 child: ListView.builder(
                     itemCount: data_hor == null ? 0 : data_hor.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: <Widget>[
                           Container(child: Text(data_hor[index]["NEG_HORARIO"],style: TextStyle(),),padding: EdgeInsets.only(bottom:15.0),) ,
                         ],
                       );
                     }
                 )
             ),
             actions: <Widget>[
               new FlatButton(
                 child: new Text('Cerrar'),
                 onPressed: () {
                   Navigator.of(context).pop();
                 },
               )
             ],
           );
         });
   }

   _mapa() async {
      final url =  dataneg[index]["NEG_MAP"];
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     } 
    }    

      String mapac =  dataneg[index]["NEG_MAP"];

      return new  Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.listUl), onPressed:() => _alertCar(context),backgroundColor:Color(0xff01969a),heroTag: "bt1",elevation: 0.0,),
             Text('Contenido', style: TextStyle(color: Colors.black),),
           ],
         ),

         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.umbrellaBeach), onPressed:() => _alertSer(context),backgroundColor:Color(0xff01969a),heroTag: "bt2",elevation: 0.0,),
             Text('Playas', style: TextStyle(color: Colors.black),),

           ],
         ),
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.dollarSign), onPressed:()  => _alertHorario(context),backgroundColor:Color(0xff01969a),heroTag: "bt3",elevation: 0.0,),
             Text('Costos', style: TextStyle(color: Colors.black),),

           ],
         ),
         
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.youtube), onPressed: () => FlutterYoutube.playYoutubeVideoByUrl(
                                         apiKey: "AIzaSyAmNDqJm2s5Fpualsl_VF6LhG733knN0BY",
                                         videoUrl: dataneg[index]["NEG_TEL_RESP"],
                                         autoPlay: false, //default falase
                                         fullScreen: false //default false
                                        ),backgroundColor:Colors.red,heroTag: "bt4",elevation: 0.0,
                                        ),             
             Text('Ver video', style: TextStyle(color: Colors.black),),

           ],
         ),
       ],
     );

       }
     ),

     
     ]
   );
  
 
    return new Scaffold(

      body: ListView(
        //shrinkWrap: true,
       physics: BouncingScrollPhysics(),

          children: [
            Column(

              children: <Widget>[
               

                logo,
                SizedBox(height: 15.0,),
                titleSection,
                textSection,
                SizedBox(height: 10.0,),

                buttonSection,
                SizedBox(height: 10.0,),



              ],
            ),

            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                 Center(child: Text('Galería de imagenes',style: TextStyle(fontSize: 20.0,color: Colors.blueAccent ),)),
                  SizedBox(
                    height: 15.0,
                  ),

                ],
              )

            ),

            Container(
              child: carrusel,
              height: MediaQuery.of(context).size.height / 1.8,

            ),

            

            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 0.0,
                  ),
                  SizedBox(
                    height: 0.0,
                  ),

                ],
              )

            ),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 0.0,
                  ),
                  //Center(child: Text('Publicaciones',style: TextStyle(fontSize: 20.0,color: Colors.blueAccent ),)),
                ],
              ),
              height: 50.0,

            ),
            

            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 0.0,
                  ),
                 //Center(child: Text('Reseñas',style: TextStyle(fontSize: 20.0,color: Colors.blueAccent ),)),
                  SizedBox(
                    height: 0.0,
                  ),

                ],
              )

            ),
           //usando resenasection,

            SizedBox(
                    height: 15.0,
                  ),

            Container(
  
                padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
                child: RaisedButton(
                  onPressed: (){

                    alertCar(context);
                
                  },  
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
                  color: Color(0xff4267b2),  
                  child: new Row (
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,

                                          children: <Widget>[
                                            new Text('Agendar y pagar ', style: TextStyle(fontSize: 20, color: Colors.white)), 
                                            new Icon(FontAwesomeIcons.calendarAlt, color: Colors.white,)
                                          ],
                                        )
                ),
              ),



          ],

        ),

        appBar: new AppBar(
          title: new Text( 'Regresar'),
        ),

    );
  }

 

 
}