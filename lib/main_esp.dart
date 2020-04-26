import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cabofind/main_ing.dart';
import 'package:cabofind/main_lista.dart';
import 'package:cabofind/notificaciones/push_publicacion_android.dart';
import 'package:cabofind/paginas/anuncios.dart';
//import 'package:cabofind/notificaciones/push_publicacion_android.dart';
import 'package:cabofind/paginas/descubre.dart';
import 'package:cabofind/paginas/domicilio.dart';
import 'package:cabofind/paginas/educacion.dart';
import 'package:cabofind/paginas/login.dart';
import 'package:cabofind/paginas/maps.dart';
import 'package:cabofind/paginas/misfavoritos.dart';
import 'package:cabofind/paginas/mispromos.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas/publicaciones.dart';
import 'package:cabofind/paginas/ricky.dart';
//import 'package:cabofind/paginas/publicacion_detalle_push.dart';
import 'package:cabofind/paginas/salud.dart';
import 'package:cabofind/paginas/youtube.dart';
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
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cabofind/paginas/acercade.dart';
import 'package:cabofind/paginas/restaurantes.dart';
import 'package:cabofind/paginas/vida_nocturna.dart';
import 'package:cabofind/paginas/servicios.dart';
import 'package:cabofind/paginas/compras.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_pay/flutter_google_pay.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'carrito/carrito.dart';
import 'paginas/promociones.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:geocoder/geocoder.dart';
//import 'package:geolocator/geolocator.dart';



FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void fcmSubscribe() async {
  final SharedPreferences login = await SharedPreferences.getInstance();
 String _status = "";
 String _mail ="";
 _status = login.getString("stringLogin");
 _mail = login.getString("stringMail");
 if (_status != "True") {}

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
  String multi;
  String result;
  List portada;
 


  Icon actionIcon = new Icon(Icons.search);

  Widget appBarTitle = new Text("Cabofind");
  int id=0;

  List data;

  //var mp = MP("CLIENT_ID", "CLIENT_SECRET");

  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/estructura_esp_test.php"),

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

  Future<String> getPortada() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/list_portada.php"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          portada = json.decode(
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
  int _page = 0;
  int selectedIndex = 0;
 PageController _c;
 @override
  void initState() {
    _c =  new PageController(
      initialPage: _page,
    );
    
    isLogged(context);

    _loadCurrencies();
    super.initState();
    
    fcmSubscribe();    

    setupNotification();
    this.getData();
    this.getPortada();
    
    



  final _mensajesStreamController = StreamController<String>.broadcast();


   


  dispose() {
    _mensajesStreamController?.close();
  }


    //this.checkModelIos();
    this.checkModelAndroid();
    ///this._getLocation();
    initializeDateFormatting();
  


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
      multi = (double.parse(fromTextController.text) * (responseBody["rates"][toCurrency])).toString();
      result = multi;

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
      Navigator.of(context).pop();
      Navigator.pushReplacement(
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
                   fit: BoxFit.cover,
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

    /*
routes: <String, WidgetBuilder>{
          "/inicio" : (BuildContext context) => data[index]["est_navegacion"],
         
        };
*/

alertCar(context) async {  
     return showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type AlertDialog
              return AlertDialog(
                //. Disponible únicamente en Cabo San Lucas
                title: new Text("¡Ahí voy Cabo! ¿Como funciona?"),
                content: Container(
                  height: MediaQuery.of(context).size.height,
                  child: new Column(

                    children: <Widget>[
                      Text("Cabofind te ayudará a generar tu pedido, posteriormente, se envía un whatsapp desde tu celular al mensajero,"+
                  "este se pondrá en contacto con usted para validar el pedido.",
                  maxLines: 15,
                  style: TextStyle(fontSize: 15.0,)),
                  Text("El mensajero llegará con tu producto y con su ticket de compra.",
                  maxLines: 15,
                  style: TextStyle(fontSize: 15.0,)),
                  Text("Disponible únicamente en Cabo San Lucas.",
                  maxLines: 15,
                  style: TextStyle(fontSize: 15.0,)),

                  Text("Los precios pueden variar dependiendo la hora.",
                  maxLines: 15,
                  style: TextStyle(fontSize: 15.0,)),
                  Text("El servicio es totalmente ajeno a Cabofind. ",
                  maxLines: 15,
                  style: TextStyle(fontSize: 15.0,)),
                    ],
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
                   child: new Text('Acepto los terminos',style: TextStyle(fontSize: 14.0,color: Colors.white),),
                   onPressed: () { 
                    Navigator.of(context).pop(); 
                    Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Domicilio()
                        )
                        );
                                    },
                 )
               ],
              );
            },
          );
   }


   _makeStripePayment() async {
      var environment = 'rest'; // or 'production'

      if (!(await FlutterGooglePay.isAvailable(environment))) {
        Fluttertoast.showToast(
          msg: "Google pay no disponible",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Color(0xff01969a),
          textColor: Colors.white,
          timeInSecForIos: 1);
      } else {
        PaymentItem pm = PaymentItem(
            stripeToken: 'pk_test_qRcqwUowOCDhl2bEuXPPCKDw00LMVoJpLi',
            stripeVersion: "2018-11-08",
            currencyCode: "mex",
            amount: "10.0",
            gateway: 'stripe');

        FlutterGooglePay.makePayment(pm).then((Result result) {
          if (result.status == ResultStatus.SUCCESS) {
          Fluttertoast.showToast(
          msg: "SUCESS",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Color(0xff01969a),
          textColor: Colors.white,
          timeInSecForIos: 1);
    
          }
        }).catchError((dynamic error) {
          Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Color(0xff01969a),
          textColor: Colors.white,
          timeInSecForIos: 1);
        });
      }
    }

    _makeCustomPayment() async {
      var environment = 'rest'; // or 'production'

      if (!(await FlutterGooglePay.isAvailable(environment))) {
        Fluttertoast.showToast(
          msg:"Google pay no disponible",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Color(0xff01969a),
          textColor: Colors.white,
          timeInSecForIos: 1);
      } else {
        ///docs https://developers.google.com/pay/api/android/guides/tutorial
        PaymentBuilder pb = PaymentBuilder()
          ..addGateway("example")
          ..addTransactionInfo("1.0", "USD")
          ..addAllowedCardAuthMethods(["PAN_ONLY", "CRYPTOGRAM_3DS"])
          ..addAllowedCardNetworks(
              ["AMEX", "DISCOVER", "JCB", "MASTERCARD", "VISA"])
          ..addBillingAddressRequired(true)
          ..addPhoneNumberRequired(true)
          ..addShippingAddressRequired(true)
          ..addShippingSupportedCountries(["US", "GB"])
          ..addMerchantInfo("Example");

        FlutterGooglePay.makeCustomPayment(pb.build()).then((Result result) {
          if (result.status == ResultStatus.SUCCESS) {
            Fluttertoast.showToast(
          msg:"Success",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Color(0xff01969a),
          textColor: Colors.white,
          timeInSecForIos: 1);
          } else if (result.error != null) {
            Fluttertoast.showToast(
          msg:result.error,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Color(0xff01969a),
          textColor: Colors.white,
          timeInSecForIos: 1);
          }
        }).catchError((error) {
          //TODO
        });
      }
    }

   
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
        _doConversion();
        if(currencyCategory == fromCurrency){
          _onFromChanged(value);
          _doConversion();
          
        }else {
          _onToChanged(value);
          _doConversion();
          
        }
        
      },
      
    );
  }

  Widget cuerpo = Container(

        
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
                                  child: FittedBox(
                                    fit:BoxFit.fitWidth,
                                    child: new Text (
                                    data[index]["est_nombre"],
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w900,
                                      backgroundColor: Colors.black45
                                    )
                              ),
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
                        builder: (BuildContext context) => new Promociones_list()
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
               } else if (ruta == "Mapa")
               {
                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Maps()
                        )
                        );
                 
                } else if (ruta == "Rutas")
               {
                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Rutas()
                        )
                        );
                 
               } else if (ruta == "domicilio")
               {
                 alertCar(context);
                 
                 
               } else if (ruta == "rickys")
               {
                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Rickys()
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
    

    );

    return  Scaffold(

     
      bottomNavigationBar: FFNavigationBar(
        
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Colors.white,
          selectedItemBackgroundColor: Color(0xff01969a),
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
        ),
        
      
        items: [
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.home,
            label: 'Inicio',
          ),
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.fire,
            label: 'Promos',
          ),
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.solidHeart,
            label: 'Favoritos',
          ),
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.userAlt,
            label: 'Cuenta',
           ),
          
        ],

        selectedIndex: selectedIndex,

        onSelectTab: (index){
          this._c.animateToPage(index,duration: const Duration(milliseconds: 10),curve: Curves.easeInOut);
        },
      ),
    
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              
              expandedHeight: 250.0,
              floating: true,
              pinned: true,
              automaticallyImplyLeading: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.all(10.0),
                background:  GestureDetector(
                  onTap: () {
                  
                  },
                child: FadeInImage(   
                        image: NetworkImage(portada[0]["POR_FOTO"]),  
                        fit: BoxFit.cover,  
                        width: MediaQuery.of(context).size.width,  
                        //height: MediaQuery.of(context).size.height * 0.38,  
                        height: MediaQuery.of(context).size.height,  
                        // placeholder: AssetImage('android/assets/images/jar-loading.gif'),  
                        placeholder: AssetImage('android/assets/images/loading.gif'),  
                        fadeInDuration: Duration(milliseconds: 200),   
                        
                      ),
                ),
                  centerTitle: false,

                  title: Text("Cabofind",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                      )),
                  ),
              actions: <Widget>[
                new InkResponse( 
                onTap: () {//_makeStripePayment();
                
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Notificaciones()
                        )
                        );
               },
                child: Stack(
                    children: <Widget>[
                    /*Positioned(
                      
                                right: 2.0,
                                bottom: 30,
                                child: new Text('22',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0, color: Colors.redAccent)),
                              ),*/ 
                    Positioned(
                                height: 20,
                                width: 20,
                                right: 3.0,
                                bottom: 28,
                                child: new FloatingActionButton(
                                  
                                 child: new Text('',
                                 style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0, color: Colors.white)),
                                 backgroundColor: Colors.red,
                                  
                                 
                                ),
                              ),             
                    new Center(
                      child: new Row(                   
                        children: <Widget>[new Icon(FontAwesomeIcons.bell),
                        Text("  ",                    
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),
                        ),
                        ]
                      ),
                    ),
                  ],
                )
                ),

          
              new InkResponse( 
                onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new WeatherBuilder().build()
                        )
                        );
               },
                child: new Center(
                  child: new Row(                   
                    children: <Widget>[new Icon(FontAwesomeIcons.cloudSun),
                    Text("   ",                    
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                    ]
                  ),
                )
                ),
          
              new InkResponse( 
                onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Calculadora()
                        )
                        );
               },
                child: new Center(
                  child: new Row(                   
                    children: <Widget>[new Icon(FontAwesomeIcons.moneyBillAlt),
                    Text("   ",                    
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                    ]
                  ),
                )
                ),

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
                      image: ExactAssetImage('assets/mexflag.png'),
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

            
          ];
        },
        body: new PageView(
        controller: _c,
        
        onPageChanged: (newPage){
          setState((){
            this._page=newPage;
            selectedIndex=newPage;
          });
        },
        children: <Widget>[
          
          cuerpo,
          new Mis_promos(),
          new Mis_favoritos(),
          new Login()
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



