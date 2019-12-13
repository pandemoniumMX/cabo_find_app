import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas/publicacion_detalle_estatica.dart';
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
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

Future<String> getResena() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_resena.php?ID=${widget.anuncio.id_anun}"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          data_resena = json.decode(
              response.body);
        });


    return "Success!";
  }
  



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

  
 

  Future<String> getCar() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_caracteristicas_api.php?ID=${widget.anuncio.id_anun}"),

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
            "http://cabofind.com.mx/app_php/APIs/esp/list_servicios_api.php?ID=${widget.anuncio.id_anun}"),

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

  Future<String> insert_reporte() async {
    
       String currentLocale;
    try {
      currentLocale = await Devicelocale.currentLocale;
      print(currentLocale);
    } on PlatformException {
      print("Error obtaining current locale");
    }

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.id}');
        print('Running on ${androidInfo.fingerprint}');

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insert_reporte.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=${currentLocale},&ID=${widget.anuncio.id_anun}&SO=Android"),

        headers: {
          "Accept": "application/json"
        }
    );
  
  }


  Future<String> getHorarios() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_horarios_api.php?ID=${widget.anuncio.id_anun}"),

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


  Future<String> get_list() async {
    var response = await http.get(
        Uri.encodeFull(
         "http://cabofind.com.mx/app_php/APIs/esp/list_publicaciones_api.php?ID=${widget.anuncio.id_anun}"),


        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          data_list = json.decode(
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
            "http://cabofind.com.mx/app_php/APIs/esp/galeria_api.php?ID=${widget.anuncio.id_anun}"),

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
     _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
    this.getCar();
    this.get_list();
    this.getSer();
    this.getCarrusel();
    this.getHorarios();
    this.getInfo();   
    this.insertVisitaAndroid();
    this.getResena();
  
   // this.insertVisitaiOS;

  }
List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(

          value: city,
          child: new Text(city)
      ));
    }
    return items;
  }
  
void onLoginStatusChange(bool isLoggedIn){
  setState(() {
   this.isLoggedIn=isLoggedIn; 
   
  });
}

void showResena() {
      Fluttertoast.showToast(
          msg: "Reseña enviada exitosamente",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          timeInSecForIos: 1);
    }

void reporte() {
      Fluttertoast.showToast(
          msg: "Comentario reportado",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          timeInSecForIos: 1);
    }    

      @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerCode.dispose();
    super.dispose();
  }

void initiateFacebookLogin() async{
  var login = FacebookLogin();
  var result = await login.logIn(['email']);
  switch(result.status){
    case FacebookLoginStatus.error:
    print("Surgio un error");
    break;
    case FacebookLoginStatus.cancelledByUser:
    print("Cancelado por el usuario");
    break;
    case FacebookLoginStatus.loggedIn:
    onLoginStatusChange(true);
    //getInfofb(result,_displayValue);

    
               
    return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Reseña',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: MediaQuery.of(context).size.width,
                 height: 350.0,
                 child:  
                Column(
                                    children: <Widget>[  
              Text('Valoración'),  
              DropdownButton(

                value: _currentCity,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,

              ),                           
              Text('Escribe una breve reseña'),
              TextField(
                controller: controllerCode,
                maxLines: 5, 
                ),
               
                ],
                 )
                 
             ),
             actions: <Widget>[
               new FlatButton(
                 child: new Text('Cancelar'),
                 onPressed: () {
                   Navigator.of(context).pop();
                 },
               ),
               new FlatButton(
                 child: new Text('Enviar'),
                 onPressed: (){ getInfofb(result,_displayValue,_currentCity); showResena(); 
                 
                 Navigator.of(context).pop();
                 
                 },
               )
             ],
           );
         });

         
    break;
  }
 
}  

void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });

}

void getInfofb(FacebookLoginResult result, _displayValue,_currentCity) async {

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
final resena = controllerCode.text;
final valor = _currentCity;

//final imagenfb = profile['picture'];
//final url =  dataneg[0]["NEG_WEB"];
var response = await http.get(
        Uri.encodeFull(
            'http://cabofind.com.mx/app_php/APIs/esp/insertar_resena.php?ID_FB=${id}&CORREO=${correofb}&NOM=${nombresfb}&APE=${apellidosfb}&FOTO=${imagenfb}&IDIOMA=ESP&RESENA=${resena}&VALOR=${valor}&ID_N=${widget.anuncio.id_anun}'),

        headers: {
          "Accept": "application/json"
        }
    );   
        }

        






 Widget build(BuildContext context){
      
      
 
  Widget carrusel =   Container(
     child: new ListView.builder(

       scrollDirection: Axis.horizontal,

       itemCount: data_carrusel == null ? 0 : data_carrusel.length,
       itemBuilder: (BuildContext context, int index) {

         return  new Container(
           padding: EdgeInsets.only( left: 0.0, right: 10.0),
           child: Column(
             children: <Widget>[
               Padding(
                 child:  FadeInImage(

                   image: NetworkImage(data_carrusel[index]["GAL_FOTO"]),
                   fit: BoxFit.cover,
                   width: MediaQuery.of(context).size.width,
                   height: 400,

                   // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                   placeholder: AssetImage('android/assets/images/loading.gif'),
                   fadeInDuration: Duration(milliseconds: 200),

                 ),
                 padding: EdgeInsets.all(0.0),
               ),
             ],
           ),
         );
       },
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
             FloatingActionButton(child: Icon(FontAwesomeIcons.moneyBillWave), onPressed:()  => _alertHorario(context),backgroundColor:Color(0xff189bd3),heroTag: "bt1",),
             Text('Price', style: TextStyle(color: Colors.black),),

           ],
         ),
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.play), onPressed:()  => _alertVideo(context),backgroundColor:Color(0xff189bd3),heroTag: "bt2",),
             Text('Video', style: TextStyle(color: Colors.black),),

           ],
         ),
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.mapMarkedAlt), onPressed: _mapa,backgroundColor:Color(0xff189bd3),heroTag: "bt3",),
             Text('Open map', style: TextStyle(color: Colors.black),),

           ],
         ),
       ],
     );

       }
     )
     ]
   );

  

Widget resenasection = Column(
         
     // height:  MediaQuery.of(context).size.height,
      children: <Widget>[
    new ListView.builder(  
         shrinkWrap: true,  
         physics: BouncingScrollPhysics(),
          itemCount: data_resena == null ? 0 : data_resena.length,  
         itemBuilder: (BuildContext context, int index) {  
        return new Card(  
              child: Row(  
           mainAxisAlignment: MainAxisAlignment.spaceBetween,  
           children: [  
             Column(  
               children: <Widget>[  
                Image.network(data_resena[index]["COM_FOTO"],
                              width: 50,
                              height: 50,
                              fit: BoxFit.fill ),     
                      Row(
                     children: <Widget>[  
                      Text(   
                      data_resena[index]["COM_NOMBRES"], 
                      style: TextStyle(fontSize: 18.0),    
                    ),  
                    ],   
                    ),     
                  ],  
                ),  
            Column(  
                     children: <Widget>[
    Text(      
                       data_resena[index]["COM_RESENA"],    
                      maxLines: 10,    
                      softWrap: true,  
                      style: TextStyle(fontSize: 18.0),  
  
                      ),
                      RaisedButton(  
                  onPressed: () {  insert_reporte(); reporte();
                       
                  },   
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(60.0) ),  
                  color: Colors.red,  
                  child: Text('Reportar comentario', style: TextStyle(fontSize: 10, color: Colors.white)),   
                  ),
],  
               
            ),
            Container(  
                
                     child: 
    Text(  
                      data_resena[index]["COM_VALOR"],
                      maxLines: 10,     
                      softWrap: true,  
                      style: TextStyle(fontSize: 18.0), 
                      ),                       
 
                      
                    ),             
                    ],  
                    ),     
                    );                    
  
         }
  
        ),
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
             FloatingActionButton(child: Icon(FontAwesomeIcons.phone), onPressed: telefono,backgroundColor:Color(0xff189bd3),heroTag: "bt5",),

           ],
         ),

         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.envelope), onPressed: correo,backgroundColor:Color(0xff189bd3),heroTag: "bt6",),

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
                 Center(child: Text('Gallery',style: TextStyle(fontSize: 20.0,color: Colors.blueAccent ),)),
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
                 Center(child: Text('Contact',style: TextStyle(fontSize: 20.0,color: Colors.blueAccent ),)),
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