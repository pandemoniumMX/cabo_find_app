import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cabofind/main_ing.dart';
import 'package:cabofind/main_lista.dart';
import 'package:cabofind/notificaciones/push_publicacion_android.dart';
import 'package:cabofind/paginas/anuncios.dart';
//import 'package:cabofind/notificaciones/push_publicacion_android.dart';
import 'package:cabofind/paginas/descubre.dart';
import 'package:cabofind/paginas/domicilio_detalle_restaurantes.dart';
import 'package:cabofind/paginas/educacion.dart';
import 'package:cabofind/paginas/maps.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas/publicaciones.dart';
//import 'package:cabofind/paginas/publicacion_detalle_push.dart';
import 'package:cabofind/paginas/salud.dart';
import 'package:cabofind/paginas_ing/promociones.dart';
import 'package:cabofind/paginas_listas/list_eventos_grid.dart';
import 'package:cabofind/paginas_listas/list_promociones.dart';
import 'package:cabofind/paginas_listas/list_publicaciones_grid.dart';
import 'package:cabofind/paginas_listas/list_recomendado_grid.dart';
import 'package:cabofind/paginas_listas/list_visitado.dart';
import 'package:cabofind/paginas_listas/list_visitado_grid.dart';
import 'package:cabofind/paginas_listas_ing/list_publicaciones.dart' as prefix0;
import 'package:cabofind/utilidades/banderasicon_icons.dart' as banderax;
import 'package:cabofind/utilidades/buscador.dart';
import 'package:cabofind/utilidades/buscador_2.dart';

import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/paginas_listas/list_publicaciones.dart';
import 'package:cabofind/utilidades/calculadora.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:cabofind/utilidades/notificaciones.dart';
import 'package:cabofind/utilidades/rutas.dart';
import 'package:cabofind/weather/weather/weather_builder.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cabofind/paginas/acercade.dart';
import 'package:cabofind/paginas/restaurantes.dart';
import 'package:cabofind/paginas/vida_nocturna.dart';
import 'package:cabofind/paginas/servicios.dart';
import 'package:cabofind/paginas/compras.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domicilio_detalle_general.dart';


//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:geocoder/geocoder.dart';
//import 'package:geolocator/geolocator.dart';



FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void fcmSubscribe() {
  _firebaseMessaging.unsubscribeFromTopic('All');
    _firebaseMessaging.subscribeToTopic('Todos');
  }
  

//void main() => runApp(new Myapp());

class Myapp extends StatelessWidget {
  // This widget is the root of your application.
  // final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
   return new MaterialApp(
     // navigatorKey: navigatorKey,
/*
      routes: {
        'publicacionx' : (BuildContext context) => Publicacion_detalle_fin_push(),
      },
*/
        debugShowCheckedModeBanner:false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xff01969a),
          //primaryColor: Colors.blue,
          accentColor: Colors.black26,
        ),
        
        home: new Container(
            child:           new Domicilio()
        )



    );
  }
}



class Domicilio extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();


}



class _MyHomePageState extends State<Domicilio> {

  final fromTextController = TextEditingController();
  List<String> currencies;
  String fromCurrency = "USD";
  String toCurrency = "MXN";
  String multi;
  String result;


  Icon actionIcon = new Icon(Icons.search);

  Widget appBarTitle = new Text("Cabofind");
  int id=0;

  List data;


  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/estructura_domicilio.php"),

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
 


    @override//Registro descarga en Android
    Future<String> checkModelAndroid() async {
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
            "http://cabofind.com.mx/app_php/APIs/esp/insertInfo.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=${currentLocale}"),

        headers: {
          "Accept": "application/json"
        }
    );
  
  }
  
  /*
  //Registro descarga en iOS
  @override
    Future<String> checkModelIos() async {
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
            "http://cabofind.com.mx/app_php/APIs/esp/insertInfoiOS.php?MOD=${iosInfo.model}&BOOT=${iosInfo.utsname.nodename}&VERSION=${iosInfo.systemName}&IDIOMA=${currentLocale}"),

        headers: {
          "Accept": "application/json"
        }
    );

  }
*/


/*
    _getLocation() async
      {
        Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        debugPrint('location: ${position.latitude}');
        final coordinates = new Coordinates(position.latitude, position.longitude);
        var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var first = addresses.first;
        print("${first.featureName} : ${first.addressLine}");
      }
*/
  //final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

 @override
  void initState() {
    //addStringToSF();


    super.initState();
    
    //fcmSubscribe();    

    //setupNotification();
    this.getData();

    
    



  final _mensajesStreamController = StreamController<String>.broadcast();


   


  dispose() {
    _mensajesStreamController?.close();
  }


    //this.checkModelIos();
    //this.checkModelAndroid();
    ///this._getLocation();
  


  }

  Widget build(BuildContext context) {
    
    //_alertCar(BuildContext context) async {
    alertCar(context) async {  
     return showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type AlertDialog
              return AlertDialog(
                title: new Text("AlertDialog Class"),
                content: new Text("Creates an alert dialog.Typically used in conjunction with showDialog."+
                "The contentPadding must not be null. The titlePadding defaults to null, which implies a default."),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
   }
    /*
    return new MaterialApp(
      navigatorKey: navigatorKey,

      routes: {
        'publicacionx' : (BuildContext context) => Publicacion_detalle_fin_push(),
      },
        debugShowCheckedModeBanner:false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          //primaryColor: Color(0xff01969a)
          primaryColor: Colors.blue,
          accentColor: Colors.black26,
        ),
        home: new Container(
            child:           new MyHomePages()
        )



    );
    */
   // new Publicaciones();

    /*
routes: <String, WidgetBuilder>{
          "/inicio" : (BuildContext context) => data[index]["est_navegacion"],
         
        };
*/

    return  Scaffold(

      
      appBar: AppBar(
        title: Text("Servicio a domicilio"),
        
        centerTitle: true,
      ),
         
              


      


      body: Stack(

        
     // height: MediaQuery.of(context).size.height,
    children: <Widget>[
      new  StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount:data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) => new Container(
            //color: Colors.white,
          child: Container(
            
            decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(20.0),   
                      border: Border.all(
                      color: Color(0xff01969a),)),
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.all(10.0),
                      
            child: InkWell(
                      child: Column(


                children: <Widget>[              

                  
                  Expanded(
                  child: Stack(
                    
                  
                  children: <Widget>[

                    
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                                    child: FadeInImage(   
                          image: NetworkImage(data[index]["EST_DOM_FOTO"]),  
                          fit: BoxFit.cover,  
                          width: MediaQuery.of(context).size.width,  
                          //height: MediaQuery.of(context).size.height * 0.38,  
                          height: MediaQuery.of(context).size.height,  
                          // placeholder: AssetImage('android/assets/images/jar-loading.gif'),  
                          placeholder: AssetImage('android/assets/images/loading.gif'),  
                          fadeInDuration: Duration(milliseconds: 200),   
                          
                        ),
                  ),

                  
                  
                      Positioned(
                       
                                  child: Center(
                                    child: new Text (
                                    data[index]["EST_DOM_NOMBRE"],
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w900,
                                      backgroundColor: Colors.black45
                                    )
                                ),
                                  ),
                                
                                  
                                ),  
                                
],
                                    ),
                  ),

/*
                  Row(
                      children: <Widget>[


                        Padding(
                            child: new Text(
                              data[index]["NEG_NOMBRE"],
                              overflow: TextOverflow.ellipsis,),
                            padding: EdgeInsets.all(
                                1.0)),
                        Text(
                            " | "),
                        Flexible(
                          child: new Text(
                            data[index]["NEG_LUGAR"],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,),


                        ),



                      ]),
*/

                ],

              ),
              onTap: () {


                String ruta = data[index]["EST_DOM_NAVEGACION"];
                String id = data[index]["EST_DOM_ID"];
                print(ruta);
                
                 if( ruta == "comida"){

                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                          builder: (BuildContext context) => new Domicilio_comida(empresa: new Empresa(id))
                          )
                        );

               } else {
                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                          builder: (BuildContext context) => new Domicilio_general(empresa: new Empresa(id))
                          )
                        );
               } 
                 


              },
            ),
          ),

        ),

        staggeredTileBuilder: (int index) =>
        new StaggeredTile.count(2, index.isEven ? 2 :2 ),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),

      
      
    ],
    

    ),

        );
  }
  @override
  void dispose() {
    super.dispose();
  }
}



