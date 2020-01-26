import 'dart:async';
import 'dart:convert';
import 'package:cabofind/main_ing.dart';
import 'package:cabofind/main_lista.dart';
import 'package:cabofind/notificaciones/push_publicacion_android.dart';
//import 'package:cabofind/notificaciones/push_publicacion_android.dart';
import 'package:cabofind/paginas/descubre.dart';
import 'package:cabofind/paginas/educacion.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas/publicaciones.dart';
//import 'package:cabofind/paginas/publicacion_detalle_push.dart';
import 'package:cabofind/paginas/salud.dart';
import 'package:cabofind/paginas_listas/list_eventos_grid.dart';
import 'package:cabofind/paginas_listas/list_promociones.dart';
import 'package:cabofind/paginas_listas/list_promociones_grid.dart';
import 'package:cabofind/paginas_listas/list_publicaciones_grid.dart';
import 'package:cabofind/paginas_listas/list_recomendado_grid.dart';
import 'package:cabofind/paginas_listas/list_visitado.dart';
import 'package:cabofind/paginas_listas/list_visitado_grid.dart';
import 'package:cabofind/utilidades/banderasicon_icons.dart' as banderax;
import 'package:cabofind/utilidades/buscador.dart';
import 'package:cabofind/utilidades/buscador_2.dart';
import 'package:cabofind/utilidades/buscador_notap.dart';

import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/paginas_listas/list_publicaciones.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:cabofind/utilidades/maps.dart';
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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'paginas/anuncios.dart';
import 'paginas/promociones.dart';
//import 'package:geocoder/geocoder.dart';
//import 'package:geolocator/geolocator.dart';



FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void fcmSubscribe() {
  _firebaseMessaging.unsubscribeFromTopic('All');
    _firebaseMessaging.subscribeToTopic('Todos');
  }


void main() => runApp(new Myapp());

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

          accentColor: Colors.black26,
        ),
        home: new Container(
            child:           new MyHomePages()
        )



    );
  }
}



class MyHomePages extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();


}



class _MyHomePageState extends State<MyHomePages> {

  final fromTextController = TextEditingController();
  List<String> currencies;
  String fromCurrency = "USD";
  String toCurrency = "MXN";
  String result;


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
    print('Running on ${iosInfo.utsname.nodename}');
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
    super.initState();

    fcmSubscribe();

    setupNotification();
    this.getData();
    _loadCurrencies();


    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

    final _mensajesStreamController = StreamController<String>.broadcast();





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
    this.checkModelIos();
   // this.checkModelAndroid();
    ///this._getLocation();



  }
  Future<String> _loadCurrencies() async {
    String uri = "http://api.openrates.io/latest";
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    Map curMap = responseBody['rates'];
    currencies = curMap.keys.toList();
    setState(() {});
    print(currencies);
    return "Success";
  }

  Future<String> _doConversion() async {
    String uri = "http://api.openrates.io/latest?base=$fromCurrency&symbols=$toCurrency";
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    setState(() {
      result = (double.parse(fromTextController.text) * (responseBody["rates"][toCurrency])).toString();
    });
    print(result);
    return "Success";
  }

  _onFromChanged(String value) {
    setState(() {
      fromCurrency = value;
    });
  }

  _onToChanged(String value) {
    setState(() {
      toCurrency = value;
    });
  }

  addStringToSF() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.remove("stringValue");
    prefs.setString('stringValue', "ingles");
  }

  Future isLogged(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String _token = "";
    _token = prefs.getString("stringValue");

    // if (prefs.getString(_idioma) ?? 'stringValue' == "espanol")
    if (_token != "ingles") {
      print("alreay login.");
      //your home page is loaded
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


  void setupNotification() async {

    _firebaseMessaging.requestNotificationPermissions();


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


  Widget _buildDropDownButton(String currencyCategory) {
    return DropdownButton(
      value: currencyCategory,
      items: currencies
          .map((String value) => DropdownMenuItem(
                value: value,
                child: Row(
                  children: <Widget>[
                    Text(value),
                  ],
                ),
              ))
          .toList(),
      onChanged: (String value) {
        if(currencyCategory == fromCurrency){
          _onFromChanged(value);
        }else {
          _onToChanged(value);
        }
      },
    );
  }


    return  Scaffold(

      appBar: new AppBar(
        
        //enterTitle: true,
        title:appBarTitle,
        actions: <Widget>[  

          new IconButton(
            icon: Icon(FontAwesomeIcons.coins),
              onPressed: () {

                return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Tipo de cambio',style: TextStyle(fontSize: 25.0,),),
                    content: currencies == null
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Card(
                              elevation: 3.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  ListTile(
                                    title: TextField(
                                      controller: fromTextController,
                                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                                      keyboardType:
                                          TextInputType.numberWithOptions(decimal: true),
                                    ),
                                    trailing: _buildDropDownButton(fromCurrency),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_downward),
                                    onPressed: _doConversion,
                                    
                                    
                                  ),
                                  ListTile(
                                    title: Chip(
                                      label: result != null ?
                                      Text(
                                        result,
                                        style: Theme.of(context).textTheme.display1,
                                      ) : Text(""),
                                    ),
                                    trailing: _buildDropDownButton(toCurrency),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                
              }, ),        
                       
       new InkResponse(
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
                   decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: ExactAssetImage('assets/usaflag.png'),
                      fit: BoxFit.fill,
                    ),
                  
                      
                      ),
                      child: new Text("     ",
                    
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                    
                    

                  ),
                )
                ),

              

          



          new IconButton(
            icon: actionIcon,
              onPressed: () {
                //Use`Navigator` widget to push the second screen to out stack of screens
                Navigator.of(context)
                    .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new Buscador();
                }));
              }, ),

        ],


      ),


      body: Container(


        // height: MediaQuery.of(context).size.height,
        child: new  StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount:data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) => new Container(
            //color: Colors.white,
            child: Container(

              decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(20.0),


                  border: Border.all(
                    color: Color(0xff01969a),)),
              padding: EdgeInsets.all(
                  5.0),
              margin: EdgeInsets.all(
                  10.0),
              child: InkWell(
                child: Column(

                  children: <Widget>[

                    Expanded(
                      child: Stack(

                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: FadeInImage(
                              image: NetworkImage(data[index]["est_foto"]),
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
                                  data[index]["est_nombre"],
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
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


                  String ruta = data[index]["est_navegacion"];
                  print(ruta);

                  if( ruta == "Restaurantes"){

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Restaurantes()
                        )
                    );

                  } else if (ruta == "Descubre"){
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Descubre()
                        )
                    );
                  } else if (ruta == "Compras"){
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Compras()
                        )
                    );
                  } else if (ruta == "Educacion"){
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Educacion()
                        )
                    );
                  } else if (ruta == "Eventos"){
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Eventos_grid()
                        )
                    );
                  } else if (ruta == "Acercade"){
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Acercade()
                        )
                    );
                  } else if (ruta == "Promociones"){
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Promociones_grid()
                        )
                    );
                  } else if (ruta == "Salud"){
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Salud()
                        )
                    );
                  } else if (ruta == "Servicios"){
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Servicios()
                        )
                    );
                  } else if (ruta == "Vida_nocturna"){
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Vida_nocturna()
                        )
                    );
                  } else if (ruta == "Publicaciones"){
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Publicaciones_grid()
                        )
                    );

                  } else if (ruta == "Anuncios"){
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Anuncios()
                        )
                    );
                  } else if (ruta == "Mapa"){
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Maps()
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

      ),

    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}



