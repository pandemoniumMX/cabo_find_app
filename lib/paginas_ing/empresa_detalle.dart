import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas/publicacion_detalle_estatica.dart';
import 'package:cabofind/paginas_ing/publicacion_detalle_estatica.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';







class Empresa_det_fin_ing extends StatefulWidget {
//final Publicacion publicacion;
final Empresa empresa;

Empresa_det_fin_ing({Key key, @required this.empresa}) : super(
    key: key);

@override
  Detalles createState() => new Detalles();

}

class Detalles extends State<Empresa_det_fin_ing> {
  TextEditingController controllerCode =  TextEditingController();
  String _displayValue = "";
  String _displayValor = "";



  

   Map userProfile;

 List _cities  =
  ["👍", "👎"];

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

Future<String> getResena() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/ing/list_resena.php?ID=${widget.empresa.id_nm}"),

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
            "http://cabofind.com.mx/app_php/APIs/ing/list_negocios_api.php?ID=${widget.empresa.id_nm}"),

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
            "http://cabofind.com.mx/app_php/APIs/ing/list_caracteristicas_api.php?ID=${widget.empresa.id_nm}"),

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
            "http://cabofind.com.mx/app_php/APIs/ing/list_servicios_api.php?ID=${widget.empresa.id_nm}"),

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
            "http://cabofind.com.mx/app_php/APIs/ing/list_horarios_api.php?ID=${widget.empresa.id_nm}"),

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
         "http://cabofind.com.mx/app_php/APIs/ing/list_publicaciones_api.php?ID=${widget.empresa.id_nm}"),


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
            "http://cabofind.com.mx/app_php/APIs/esp/insert_visita_negocio.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=ing&ID=${widget.empresa.id_nm}&SO=Android"),


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
            "http://cabofind.com.mx/app_php/APIs/esp/insert_reporte.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=${currentLocale},&ID=${widget.empresa.id_nm}&SO=Android"),

        headers: {
          "Accept": "application/json"
        }
    );
  
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

      @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerCode.dispose();
    super.dispose();
  }

  void showResena() {
      Fluttertoast.showToast(
          msg: "Review sent successfully",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          timeInSecForIos: 1);
    }
    
    void reporte() {
      Fluttertoast.showToast(
          msg: "Comment reported",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          timeInSecForIos: 1);
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
             title: Text('Review',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: MediaQuery.of(context).size.width,
                 height: 350.0,
                 child:  
                Column(
                                    children: <Widget>[  
              Text('Rate'),  
              DropdownButton(

                value: _currentCity,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,

              ),                           
              Text('Write a short opinion'),
              TextField(
                controller: controllerCode,
                maxLines: 5, 
                ),
               
                ],
                 )
                 
             ),
             actions: <Widget>[
               new FlatButton(
                 child: new Text('Cancel'),
                 onPressed: () {
                   Navigator.of(context).pop();
                 },
               ),
               new FlatButton(
                 child: new Text('Send'),
                 onPressed: (){ getInfofb(result,_displayValue,_currentCity);showResena();  
                 
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
            'http://cabofind.com.mx/app_php/APIs/esp/insertar_resena.php?ID_FB=${id}&CORREO=${correofb}&NOM=${nombresfb}&APE=${apellidosfb}&FOTO=${imagenfb}&IDIOMA=ING&RESENA=${resena}&VALOR=${valor}&ID_N=${widget.empresa.id_nm}'),

        headers: {
          "Accept": "application/json"
        }
    );   
        }

        






 Widget build(BuildContext context){




   _alertCar(BuildContext context) async {
     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Features',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: double.maxFinite,
                 height: 300.0,
                 child: ListView.builder(
                     itemCount: data == null ? 0 : data.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: <Widget>[
                           Container(child: Text(data[index]["CAR_NOMBRE_ING"],style: TextStyle(),),padding: EdgeInsets.only(bottom:15.0),) ,
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


   _alertSer(BuildContext context) async {
     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Services',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: double.maxFinite,
                 height: 300.0,
                 child: ListView.builder(
                     itemCount: data_serv == null ? 0 : data_serv.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: <Widget>[
                           Container(child: Text(data_serv[index]["SERV_NOMBRE_ING"],style: TextStyle(),),padding: EdgeInsets.only(bottom:15.0),) ,
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

    _alertHorario(BuildContext context) async {
     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Close',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: double.maxFinite,
                 height: 150.0,
                 child: ListView.builder(
                     itemCount: data_hor == null ? 0 : data_hor.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: <Widget>[
                           Container(child: Text(data_hor[index]["NEG_HORARIO_ING"],style: TextStyle(),),padding: EdgeInsets.only(bottom:15.0),) ,
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
      if (Platform.isIOS) {
        final url =  dataneg[0]["NEG_MAP_IOS"];
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
      } else {
      final url =  dataneg[0]["NEG_MAP_IOS"];
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
      }    
    }

   

 
  Widget carrusel =   Container(
      child: new CarouselSlider.builder(      
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
     ),
   );

    
    Widget titleSection = Container(
     // width: MediaQuery.of(context).size.width,
      //padding: const EdgeInsets.all(20),
     height:  50.0,
      child: new ListView.builder(
        shrinkWrap: true,
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
                    dataneg[index]["NEG_NOMBRE"],
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

                  dataneg[index]["CAT_NOMBRE_ING"],
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
                dataneg[index]["SUB_NOMBRE_ING"],
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
      ),
       
    
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
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
              child: Text(
         dataneg[index]["NEG_DESCRIPCION_ING"],        
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


   Widget buttonSection = Container(
     width: MediaQuery.of(context).size.width +30,

     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.feather), onPressed:() => _alertCar(context),backgroundColor:Color(0xff01969a),heroTag: "bt1",elevation: 0.0,),
             Text('Features', style: TextStyle(color: Colors.black),),
           ],
         ),

         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.conciergeBell), onPressed:() => _alertSer(context),backgroundColor:Color(0xff01969a),heroTag: "bt2",elevation: 0.0,),
             Text('Services', style: TextStyle(color: Colors.black),),

           ],
         ),
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.clock), onPressed:() => _alertHorario(context),backgroundColor:Color(0xff01969a),heroTag: "bt3",elevation: 0.0,),
             Text('Schedule', style: TextStyle(color: Colors.black),),

           ],
         ),
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.mapMarkerAlt), onPressed:() => _mapa(),backgroundColor:Color(0xff01969a),heroTag: "bt4",elevation: 0.0,),
             Text('Open map', style: TextStyle(color: Colors.black),),

           ],
         ),
       ],
     ),

   );

  Widget ubersection = Column(
     //width: MediaQuery.of(context).size.width +30,

     children: <Widget>[
        new ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: dataneg == null ? 0 : dataneg.length,
       itemBuilder: (BuildContext context, int index) {

 
    _uber() async {
      final lat = dataneg[index]["NEG_MAP_LAT"];
      final long = dataneg[index]["NEG_MAP_LONG"];
      final url = "https://m.uber.com/ul/?action=setPickup&client_id=5qCx0VeV1YF9ME3qt2kllkbLbp0hfIdq&pickup=my_location&dropoff[formatted_address]=Cabo%20San%20Lucas%2C%20B.C.S.%2C%20M%C3%A9xico&dropoff[latitude]=$lat&dropoff[longitude]=$long";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     } 
    } 

String latc = dataneg[index]["NEG_MAP_LAT"];
if (latc != null){
  return new  Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [         
                     
         
         RaisedButton(

                  onPressed: (){_uber();},  

                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
                  color: Colors.black,  
                  
                  child: new Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,

                    children: <Widget>[
                      new Text('Uber request ', style: TextStyle(fontSize: 20, color: Colors.white)), 
                      new Icon(FontAwesomeIcons.uber, color: Colors.white,)
                    ],
                  )
                  
                ),
       ],
     );
}
      

       }
     ),
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
           //mainAxisAlignment: MainAxisAlignment.start,  
           children: [  
             Column(  
               children: <Widget>[  
                      Image.network(data_resena[index]["COM_FOTO"],
                              width: 50,
                              height: 50,
                              fit: BoxFit.fill ),     
                      Text(   
                      data_resena[index]["COM_NOMBRES"], 
                      style: TextStyle(fontSize: 12.0,),  
                      overflow: TextOverflow.ellipsis,  
                    ),     
                  ],  
                ),  
            Flexible(  
              fit: FlexFit.tight,
                     child: Center(
                       child: Text(      
                       data_resena[index]["COM_RESENA"],   
                       overflow: TextOverflow.ellipsis, 
                       maxLines: 10,    
                       softWrap: true,  
                       style: TextStyle(fontSize: 18.0),  
                       ),
                     ), 
            ),
            
            Column(
                          children: <Widget>[
                Text(   
                data_resena[index]["COM_VALOR"], 
                overflow: TextOverflow.ellipsis,    
                maxLines: 1,   
                softWrap: true,      
                style: TextStyle(fontSize: 30.0),    
                ),

                Container(
                  width: 30.0,
                  child: FloatingActionButton(child: Icon(FontAwesomeIcons.timesCircle), 
                  onPressed:() {  insert_reporte(); reporte();}, 
                  backgroundColor:Colors.red, heroTag: "bt1",),
                )
                ,


                
              ],
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

      height:  60.0,
      child: new ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: dataneg == null ? 0 : dataneg.length,
       itemBuilder: (BuildContext context, int index) {
         

         mapa() async {
      if (Platform.isAndroid) {
        final url =  dataneg[index]["NEG_MAP"];
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
      } else {
      final url =  dataneg[index]["NEG_MAP_IOS"];
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
      }
      
    }

   facebook() async {
     final url =  dataneg[index]["NEG_FACEBOOK"];
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

   web() async {
     final url =  dataneg[index]["NEG_WEB"];
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

   instagram() async {
     final url =  dataneg[index]["NEG_INSTAGRAM"];
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

   telefono() async {
     final tel = dataneg[index]["NEG_TEL"];
     final url =  "tel: $tel";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

   correo() async {
     final mail = dataneg[index]["NEG_CORREO"];
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
         SizedBox(width: 30),
         FloatingActionButton(child: Icon(FontAwesomeIcons.instagram), onPressed: instagram,backgroundColor:Color(0xff01969a),heroTag: "bt1",elevation: 0.0,),
         Expanded(child: SizedBox(width: 5.0,)),
         FloatingActionButton(child: Icon(FontAwesomeIcons.facebook), onPressed: facebook,backgroundColor:Color(0xff01969a),heroTag: "bt2",elevation: 0.0,),
         Expanded(child: SizedBox(width: 5.0,)),
         FloatingActionButton(child: Icon(FontAwesomeIcons.globeAmericas), onPressed: web,backgroundColor:Color(0xff01969a),heroTag: "bt3",elevation: 0.0,),
         Expanded(child: SizedBox(width: 5.0,)),
         FloatingActionButton(child: Icon(FontAwesomeIcons.phone), onPressed: telefono,backgroundColor:Color(0xff01969a),heroTag: "bt4",elevation: 0.0,),
         Expanded(child: SizedBox(width: 5.0,)),
         FloatingActionButton(child: Icon(FontAwesomeIcons.envelope), onPressed: correo,backgroundColor:Color(0xff01969a),heroTag: "bt5",elevation: 0.0,),
         Expanded(child: SizedBox(width: 5.0,)),

         ],
         );


         

         
      
      }
      )
      
    );
  }
    

  Widget publicaciones =  ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: data_list == null ? 0 : data_list.length,
      itemBuilder: (BuildContext context, int index) {

        return new ListTile(


          title: new Card(

            elevation: 5.0,
            child: new Container(


              decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10.0),

                  border: Border.all(
                      color: Colors.blue)),
              padding: EdgeInsets.all(
                  10.0),
              margin: EdgeInsets.all(
                  10.0),

              child: Column(

                children: <Widget>[

                  Padding(

                      child: Text(

                        data_list[index]["PUB_TITULO_ING"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.0,


                        ),

                      ),
                      padding: EdgeInsets.all(
                          1.0)
                  ),

                  FadeInImage(

                    image: NetworkImage(data_list[index]["GAL_FOTO_ING"]),
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,

                    // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                    placeholder: AssetImage('android/assets/images/loading.gif'),
                    fadeInDuration: Duration(milliseconds: 200),

                  ),


                  Row(
                      children: <Widget>[

                        Padding(

                            child: Text(

                                data_list[index]["CAT_NOMBRE_ING"]),
                            padding: EdgeInsets.all(
                                1.0)),
                        Text(
                            " | "),
                        Padding(
                            child: new Text(
                                data_list[index]["NEG_NOMBRE"]),
                            padding: EdgeInsets.all(
                                1.0)),
                        Text(
                            " | "),
                        Flexible(
                          child: new Text(
                            data_list[index]["NEG_LUGAR"],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,),
                        ),



                      ]),
                ],

              ),

            ),

          ),

          onTap: () {
            String id_n = data_list[index]["ID_NEGOCIO"];
            String id_p = data_list[index]["ID_PUBLICACION"];
             


              Navigator.push(context, new MaterialPageRoute
                (builder: (context) => new Publicacion_detalle_fin_estatica_ing(
                publicacion: new Publicacion(id_n,id_p),
                )
              )
              );


          },
          //A Navigator is a widget that manages a set of child widgets with
          //stack discipline.It allows us navigate pages.
          //stack discipline.It allows us navigate pages.
          //Navigator.of(context).push(route);
        );

      },

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
                ubersection



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
                 Center(child: Text('Social networks and contact',style: TextStyle(fontSize: 20.0,color: Colors.blueAccent ),)),
                  SizedBox(
                    height: 15.0,
                  ),
                 social(),

                ],
              )

            ),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(child: Text('Posts',style: TextStyle(fontSize: 20.0,color: Colors.blueAccent ),)),
                ],
              ),
              height: 50.0,

            ),
            Column(
              children: <Widget>[publicaciones],
             // height:1000.0,

            ),

            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                 Center(child: Text('Reviews',style: TextStyle(fontSize: 20.0,color: Colors.blueAccent ),)),
                  SizedBox(
                    height: 15.0,
                  ),

                ],
              )

            ),
            resenasection,

            SizedBox(
                    height: 15.0,
                  ),

            Container(
  
                padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
  
                child: RaisedButton(
  
  
  
                  //child: Text(‘Send data to the second page’),
  
                  onPressed: (){initiateFacebookLogin();},
  
  
  
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
  
                  color: Color(0xff4267b2),
  
                  child: new Row (
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,

                                          children: <Widget>[
                                            new Text('REVIEW USING FACEBOOK ', style: TextStyle(fontSize: 20, color: Colors.white)), 
                                            new Icon(FontAwesomeIcons.facebookSquare, color: Colors.white,)
                                          ],
                                        )
  
  
  
                ),
  
  
  
              ),



          ],

        ),

        appBar: new AppBar(
          title: new Text( 'Back'),
        ),

    );
  }

 

 
}