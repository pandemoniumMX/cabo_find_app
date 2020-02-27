import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas/publicacion_detalle_estatica.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutube/flutube.dart';

import 'package:http/http.dart' as http;
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';







class Anuncios_detalle_ing extends StatefulWidget {
//final Publicacion publicacion;
final Anuncios_clase anuncio;

Anuncios_detalle_ing({Key key, @required this.anuncio}) : super(
    key: key);

@override
  Detalles createState() => new Detalles();

}

class Detalles extends State<Anuncios_detalle_ing> {
  TextEditingController controllerCode =  TextEditingController();
  String _displayValue = "";
  String _displayValor = "";



  

   Map userProfile;

 List _cities  =
  ["","👍", "👎"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  bool isLoggedIn=false;
  List data;
  List data_serv;
  List dataneg;
  List data_list;
  List data_carrusel;
  List data_hor;
  List logos;
  List descripcion;
  List data_resena;
String stateText;




  Future<String> getInfo() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/ing/list_anuncios_api.php?ID=${widget.anuncio.id_anun}"),

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

  

//contador de visitas android

Future<String> insertVisitaAndroid() async {
    String currentLocale;
    try {
      currentLocale = await Devicelocale.currentLocale;
      print(currentLocale);
    } on PlatformException {
      print("Error obtaining current locale");
    }

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //print('Running on ${androidInfo.id}');
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insert_visita_anuncios.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=ing&ID=${widget.anuncio.id_anun}&SO=Android"),


        headers: {
          "Accept": "application/json"
        }
    );
}
/*
Future<String> insertVisitaiOS() async {
    String currentLocale;
    try {
      currentLocale = await Devicelocale.currentLocale;
      print(currentLocale);
    } on PlatformException {
      print("Error obtaining current locale");
    }
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    //print('Running on ${iosInfo.identifierForVendor}');
    var response = await http.get(
        Uri.encodeFull(
           // "http://cabofind.com.mx/app_php/APIs/esp/insert_visita_negocio.php?ID=${widget.empresa.id_nm}"),
            "http://cabofind.com.mx/app_php/APIs/esp/insert_visita_negocio.php?MOD=${iosInfo.model}&BOOT=${iosInfo.utsname.nodename},${iosInfo.utsname.sysname}&VERSION=${iosInfo.systemName}&IDIOMA=esp&ID=${widget.empresa.id_nm}&SO=iOS"),
        headers: {
          "Accept": "application/json"
        }
    );
}
*/
   Future<String> getCarrusel() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/galeria_anuncios_api.php?ID=${widget.anuncio.id_anun}"),

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
    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
    this.getCarrusel();
    this.getInfo();   
    this.insertVisitaAndroid();
  
   // this.insertVisitaiOS;

  }

      @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerCode.dispose();
    super.dispose();
  }






 Widget build(BuildContext context){
      
      
 
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
                    dataneg[0]["ANUN_TITULO_ING"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                       //color: Colors.blue[500],
                    ),
                  ),               

              ],
            ),
          Center(
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            
                Text(

                  dataneg[0]["ANUN_LUGAR"],
                  style: TextStyle(
                    color: Colors.blue[500],
                  ),
                ),
                

              Text(
                " | ",
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
              Text(
                dataneg[0]["ANUN_ESTADO_ING"],
                style: TextStyle(
                  color: Colors.blue[500],
                ),
              ), 
              
              
              

            ],
            ),
            ),
          ],       
        );
       },
      
      )
    
    );

    Color color = Theme.of(context).primaryColor;


    Widget textSection = Column(
     // height:  MediaQuery.of(context).size.height,
     
     children: <Widget>[
        new ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: dataneg == null ? 0 : dataneg.length,
       itemBuilder: (BuildContext context, int index) {
  //padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20);
      return new Card(
              child: Text(
         dataneg[index]["ANUN_DESCRIPCION_ING"],        
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

                    image: NetworkImage(dataneg[index]["GAL_FOTO_ING"]),
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: 300,

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

/*


   _alertCar(BuildContext context) async {
     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Caracteristicas',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: double.maxFinite,
                 height: 300.0,
                 child: ListView.builder(
                     itemCount: data == null ? 0 : data.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: <Widget>[
                           Container(child: Text(data[index]["CAR_NOMBRE"],style: TextStyle(),),padding: EdgeInsets.only(bottom:15.0),) ,
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
             title: Text('Servicios',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: double.maxFinite,
                 height: 300.0,
                 child: ListView.builder(
                     itemCount: data_serv == null ? 0 : data_serv.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: <Widget>[
                           Container(child: Text(data_serv[index]["SERV_NOMBRE"],style: TextStyle(),),padding: EdgeInsets.only(bottom:15.0),) ,
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
*/

    _alertHorario(BuildContext context) async {
     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Price',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: double.maxFinite,
                 height: 50.0,
                 child: ListView.builder(
                     itemCount: dataneg == null ? 0 : dataneg.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: <Widget>[
                           Container(child: Text(dataneg[index]["ANUN_PRECIO_USD"],style: TextStyle(),),padding: EdgeInsets.only(bottom:15.0),) ,
                         ],
                       );
                     }
                 )
             ),
             actions: <Widget>[
               new FlatButton(
                 child: new Text('Close'),
                 onPressed: () {
                   Navigator.of(context).pop();
                 },
               )
             ],
           );
         });
   }

   _alertVideo(BuildContext context) async {
     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Video',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                width: double.maxFinite,
                 height: 300.0,
               child: FluTube(
                                                dataneg[index]["ANUN_VIDEO"],
                                                autoPlay: false,
                                                autoInitialize: true,                                                                                            
                                                aspectRatio: 4 / 3,
                                                allowMuting: false,
                                                looping: false,
                                                showThumb: true,
                                                allowFullScreen: false,
                                                deviceOrientationAfterFullscreen: [
                                                  DeviceOrientation.portraitUp,
                                                  DeviceOrientation.landscapeLeft,
                                                  DeviceOrientation.landscapeRight,
                                                ],
                                                systemOverlaysAfterFullscreen: SystemUiOverlay.values,
                                                onVideoStart: () {
                                                  setState(() {
                                                    stateText = 'Video started playing!';
                                                    
                                                  });
                                                },
                                                onVideoEnd: () {
                                                  setState(() {
                                                    stateText = 'Video ended playing!';
                                                   
                                                  });
                                                },
                                                
                                              ),
             ),
             actions: <Widget>[
               new FlatButton(
                 child: new Text('Close'),
                 onPressed: () {
                   Navigator.of(context).pop();
                 },
               )
             ],
           );
         });
   }

   _mapa() async {
      final url =  dataneg[index]["ANUN_MAP_GOOGLE"];
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     } 
    }    

      return new  Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.moneyBillWave), onPressed:()  => _alertHorario(context),backgroundColor:Color(0xff01969a),heroTag: "bt1",),
             Text('Price', style: TextStyle(color: Colors.black),),

           ],
         ),
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.play), onPressed:() 
             {FlutterYoutube.playYoutubeVideoByUrl(
                                         apiKey: "AIzaSyAmNDqJm2s5Fpualsl_VF6LhG733knN0BY",
                                         videoUrl: dataneg[index]["ANUN_VIDEO"],
                                         autoPlay: false, //default falase
                                         fullScreen: false //default false
                                       );},
             backgroundColor:Color(0xff01969a),heroTag: "bt2",),
             Text('Video', style: TextStyle(color: Colors.black),),

           ],
         ),
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.mapMarkerAlt), onPressed: _mapa,backgroundColor:Color(0xff01969a),heroTag: "bt3",),
             Text('Open map', style: TextStyle(color: Colors.black),),

           ],
         ),
       ],
     );

       }
     )
     ]
   );

  
  Widget social() { 
    return Container (
     // width: MediaQuery.of(context).size.width,
      //padding: const EdgeInsets.all(20),
      height: 65.0,

      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: dataneg == null ? 0 : dataneg.length,
       itemBuilder: (BuildContext context, int index) {
         

    


   telefono() async {
     final tel = dataneg[index]["ANUN_TELEFONO"];
     final url =  "tel: $tel";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

   correo() async {
     final mail = dataneg[index]["ANUN_CORREO"];
     final url = "mailto: $mail";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }
         return new Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: <Widget>[

         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.phone), onPressed: telefono,backgroundColor:Color(0xff01969a),heroTag: "bt5",),

           ],
         ),

         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.envelope), onPressed: correo,backgroundColor:Color(0xff01969a),heroTag: "bt6",),

           ],
         ),  
         

         ],
         );      
      }
      )
      
      
    );
  }
    

  

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
                buttonSection,



              ],
            ),

            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                 Center(child: Text('Gallery',style: TextStyle(fontSize: 20.0,color: Color(0xff01969a) ),)),
                  SizedBox(
                    height: 15.0,
                  ),

                ],
              )

            ),

            Container(
              child: carrusel,
              height: 400.0,

            ),

            

            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                 Center(child: Text('Contact',style: TextStyle(fontSize: 20.0,color: Color(0xff01969a) ),)),
                  SizedBox(
                    height: 15.0,
                  ),
                 social(),

                ],
              )

            ),
            
            

            SizedBox(
                    height: 15.0,
                  ),

            



          ],

        ),

        appBar: new AppBar(
          title: new Text( 'Back'),
        ),

    );
  }

 

 
}