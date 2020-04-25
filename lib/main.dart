import 'dart:async';
import 'dart:convert';
import 'package:cabofind/main_ing.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_esp.dart';

void main() => runApp(new Myapp1());

class Myapp1 extends StatelessWidget {
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

          accentColor: Colors.black26,
        ),
        home: new Container(
            child:           new Start()
        )



    );
  }
}



class Start extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();


}



class _MyHomePageState extends State<Start> {



FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void fcmSubscribe() {
  _firebaseMessaging.unsubscribeFromTopic('All');
    _firebaseMessaging.subscribeToTopic('Todos');
  }
  Icon actionIcon = new Icon(Icons.search);

  Widget appBarTitle = new Text("Cabofind");
  int id=0;
 
/*

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
  */

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
    print('Running on ${iosInfo.identifierForVendor}');
    //print('Running on ${iosInfo.utsname.nodename}');
    print('Running on ${iosInfo.utsname.sysname}');


    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insertInfoiOS.php?MOD=${iosInfo.model}&BOOT=${iosInfo.utsname.nodename},${iosInfo.identifierForVendor}&VERSION=${iosInfo.systemName}&IDIOMA=${currentLocale}"),

        headers: {
          "Accept": "application/json"
        }
    );

  }



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
 // final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  List data;


  
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/estructura_esp.php"),

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
  @override
  void initState() {
    isLogged(context);
    

    fcmSubscribe();

    //setupNotification();
    this.getData();
    



    final _mensajesStreamController = StreamController<String>.broadcast();


   super.initState();


    dispose() {
      _mensajesStreamController?.close();
    }


/*
    pushpub.mensajes.listen( (data) {
      // Navigator.pushNamed(context, 'mensaje');
      print('Argumento del Push');
      print(data);
      //navigatorKey.currentState.pushNamed('Publicacion_detalle_fin_push', arguments: data );
      navigatorKey.currentState.pushNamed('publicacionx', arguments: data );


    });
    */
    //this.checkModelIos();
   // this.checkModelAndroid();
    ///this._getLocation();



  }

  addStringToSF() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.remove("stringValue");
    prefs.setString('stringValue', "ingles");
  }

  addStringToSFESP() async {
  	final SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.remove("stringValue");
	prefs.setString('stringValue', "espanol");
  } 

  Future isLogged(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String _token = "";
    _token = prefs.getString("stringValue");

    // if (prefs.getString(_idioma) ?? 'stringValue' == "espanol")
    if (_token != "ingles") {
      print("alreay login.");
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new Myapp()
          )
      );
    }
    else
    {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new MyHomePages_ing()
          )
      );
    }
  }

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}
  void setupNotification() async {

    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true));
      _firebaseMessaging.onIosSettingsRegistered
      .listen((IosNotificationSettings settings){
        print("settings registred main: $settings");
        });



    _firebaseMessaging.getToken().then( (token) {


      print('===== FCM Token =====');
      print( token );

    });


    _firebaseMessaging.configure(

      onMessage: ( Map<String, dynamic> message ) async {

        print('======= On Message ========');
        print(" $message" );

        String id_n= (message['data']['id_n']) as String;
        String id =(message['data']['id'])as String;

       
          showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Nueva publicación!',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: 300,
                 height: 300.0,
                 child: FadeInImage(

                   image: NetworkImage("http://cabofind.com.mx/assets/img/alerta.png"),
                   fit: BoxFit.fill,
                   width: 300,
                   height: 300,

                   // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                   placeholder: AssetImage('android/assets/images/loading.gif'),
                   fadeInDuration: Duration(milliseconds: 200),

                 ),
                 
             ),
             actions: <Widget>[
               new FlatButton(
                 child: new Text('Cerrar'),
                 onPressed: () {
                   Navigator.of(context).pop();
                 },
               ), 
               new FlatButton(
                 color: Colors.blueAccent,
                 child: new Text('Descubrir',style: TextStyle(fontSize: 14.0,color: Colors.white),),
                 onPressed: () {
                  Navigator.push(context, new MaterialPageRoute
              (builder: (context) => new Publicacion_detalle_fin(
              publicacion: new Publicacion(id_n,id),
            )
            )
            );
                 },
               )
             ],
           );
         });
            
/*
       showDialog(
         context: context,
         builder: (context) => AlertDialog(
           content: ListTile(
             title: Text(message['data']['id_n']),
             subtitle: Text(message['data']['id']),
           ),
         )
       );
*/
       

      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: ( Map<String, dynamic> message ) async {

        print('======= On launch ========');
        print(" $message" );

       String id_n= (message['data']['id_n']) as String;
        String id =(message['data']['id'])as String;

       Navigator.push(context, new MaterialPageRoute
              (builder: (context) => new Publicacion_detalle_fin(
              publicacion: new Publicacion(id_n,id),
            )
            )
            );

       

      },

      onResume: ( Map<String, dynamic> message ) async {

        print('======= On resume ========');
        print(" $message" );

       String id_n= (message['data']['id_n']) as String;
        String id =(message['data']['id'])as String;

       Navigator.push(context, new MaterialPageRoute
              (builder: (context) => new Publicacion_detalle_fin(
              publicacion: new Publicacion(id_n,id),
            )
            )
            );

       

      },


    );


  }


  Widget build(BuildContext context) {
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

      
      appBar: new AppBar(
        
        //enterTitle: true,
        title:appBarTitle,
        actions: <Widget>[    

      

        ],


      ),


      body: Center(
  child: Column(
    children: <Widget>[ 

      Center(
        child: Padding(
          padding: const EdgeInsets.only(top:150.0),
          child: FadeInImage(

                       image: AssetImage('assets/splash.png'),
                       fit: BoxFit.cover,
                       width: 150,
                       height: 150,

                       placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                       fadeInDuration: Duration(milliseconds: 200), 

                     ),
        ),
      ),
      SizedBox(
          height: 30.0,
        ),
      Card(
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(100.0) ),
        color: Color(0xffA9A6A6),
        child: Column(
          children: <Widget>[

            Text('Lenguage/Idioma',style: 
      TextStyle(
        color: Color(0XFF000000),
        fontSize:25.0,
        fontWeight: FontWeight.normal),),
        SizedBox(
          height: 30.0,
        ),

        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
               
                InkResponse(
                onTap: () {
                  addStringToSF();
              //Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new MyHomePages_ing()
                        )
                        );
            },
                child: new Center(
                  //padding: const EdgeInsets.all(13.0),
                  
                  child: new Container(
                    height: 100,
                    width: 130,
                   decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: NetworkImage("https://upload.wikimedia.org/wikipedia/en/thumb/a/a4/Flag_of_the_United_States.svg/1280px-Flag_of_the_United_States.svg.png"),
                      fit: BoxFit.fill,

                    ),
                  
                      
                      ),
                      child: new Text("     ",
                    
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                    
                    

                  ),
                )
                ),
                SizedBox(
                height: 10.0,
              ),
                Text('English', style: TextStyle(color: Colors.black, fontSize: 30.0),),
              ],
            ),

            Column(
              children: <Widget>[
               
                InkResponse(
                onTap: () {
                  addStringToSFESP();
              //Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Myapp()
                        )
                        );
            },
                child: new Center(
                  //padding: const EdgeInsets.all(13.0),
                  
                  child: new Container(
                    height: 100,
                    width: 130,
                   decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Bandera_de_México_%281916-1934%29.png/1280px-Bandera_de_México_%281916-1934%29.png"),
                      fit: BoxFit.fill,

                    ),
                  
                      
                      ),
                      child: new Text("     ",
                    
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                    
                    

                  ),
                )
                ),
                SizedBox(
                height: 10.0,
              ),
                Text('Español', style: TextStyle(color: Colors.black, fontSize: 30.0),),
              ],
            ),
            
            
             
          ],
        ),

          ],
        ),
      )  
      

        
    ],
  ),

),

        );
  }
  @override
  void dispose() {
    super.dispose();
  }
}