import 'dart:async';
import 'dart:convert';
import 'package:cabofind/main_ing.dart';
import 'package:cabofind/paginas/anuncios.dart';
import 'package:cabofind/paginas/dados.dart';
import 'package:cabofind/paginas/descubre.dart';
import 'package:cabofind/paginas/domicilio.dart';
import 'package:cabofind/paginas/educacion.dart';
import 'package:cabofind/paginas/hoteles.dart';
import 'package:cabofind/paginas/login.dart';
import 'package:cabofind/paginas/maps.dart';
import 'package:cabofind/paginas/menu.dart';
import 'package:cabofind/paginas/misfavoritos.dart';
import 'package:cabofind/paginas/mispromos.dart';
import 'package:cabofind/paginas/misrecompensa.dart';
import 'package:cabofind/paginas/pedidos_proceso_list.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas/publicaciones.dart';
import 'package:cabofind/paginas/ricky.dart';
import 'package:cabofind/paginas/salud.dart';
import 'package:cabofind/paginas/scan.dart';
import 'package:cabofind/paginas_listas/list_eventos_grid.dart';
import 'package:cabofind/utilidades/buscador.dart';
import 'package:cabofind/utilidades/calculadora.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:cabofind/utilidades/notificaciones.dart';
import 'package:cabofind/utilidades/rutas.dart';
import 'package:cabofind/weather/weather/weather_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cabofind/paginas/acercade.dart';
import 'package:cabofind/paginas/restaurantes.dart';
import 'package:cabofind/paginas/vida_nocturna.dart';
import 'package:cabofind/paginas/servicios.dart';
import 'package:cabofind/paginas/compras.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'paginas/promociones.dart';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void fcmSubscribe() async {
  final SharedPreferences login = await SharedPreferences.getInstance();
  String _status = "";
  String _mail = "";
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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Color(0xff60032D),
          //primaryColor: Colors.black,
          accentColor: Color(0xff773E42),
        ),
        home: new Container(child: new MyHomePages()));
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
  int id = 0;

  List data;

  //var mp = MP("CLIENT_ID", "CLIENT_SECRET");

  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/estructura_esp.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> getPortada() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/list_portada.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      portada = json.decode(response.body);
    });

    return "Success!";
  }

  //Registro descarga en Android

  /*Future<String> checkModelAndroid() async {
    String currentLocale;
    try {
      currentLocale = await Devicelocale.currentLocale;
    } on PlatformException {}

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insertInfo.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=${currentLocale}"),
        headers: {"Accept": "application/json"});
  }*/

  
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
    print('Running on ${iosInfo.utsname.nodename}');
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insertInfoiOS.php?MOD=${iosInfo.model}&BOOT=${iosInfo.utsname.nodename}&VERSION=${iosInfo.systemName}&IDIOMA=${currentLocale}"),

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
  //final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  int _page = 0;
  int selectedIndex = 0;
  PageController _c;
  @override
  void initState() {
    _c = new PageController(
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

    this.checkModelIos();
    //this.checkModelAndroid();

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
    return "Success";
  }

  Future<String> _doConversion() async {
    String uri =
        "http://api.openrates.io/latest?base=$fromCurrency&symbols=$toCurrency";
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    setState(() {
      multi = (double.parse(fromTextController.text) *
              (responseBody["rates"][toCurrency]))
          .toString();
      result = multi;
    });
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
      //your home page is loaded
    } else {
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new MyHomePages_ing()));
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.remove("stringValue");

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
      
      onMessage: (Map<String, dynamic> message) async {
        print('======= On Message ========');
        print(" $message");

        String id_n = (message['data']['id_n']) as String;
        String id = (message['data']['id']) as String;
        String idc = (message['data']['idc']) as String;
        String idcn = (message['data']['idn']) as String;
        var idcnumber = int.parse(idc);
        print(idc);
        print(idcn);
        print(idcnumber);

        id_n != null
            ? showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Nueva publicación!',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    content: Container(
                      width: 300,
                      height: 300.0,
                      child: FadeInImage(
                        image: NetworkImage(
                            "http://cabofind.com.mx/assets/img/alerta.png"),
                        fit: BoxFit.fill,
                        width: 300,
                        height: 300,

                        // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                        placeholder:
                            AssetImage('android/assets/images/loading.gif'),
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
                        color: Colors.black,
                        child: new Text(
                          'Descubrir',
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      new Publicacion_detalle_fin(
                                        publicacion: new Publicacion(id_n, id),
                                      )));
                        },
                      )
                    ],
                  );
                })
            : 1 != null
                ? showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Nuevo pedido!',
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                        content: Container(
                            width: 300,
                            height: 50.0,
                            child: Text('Pedido número #$idcnumber enviado')),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text('Cerrar'),
                            onPressed: () {
                              // _stopFile();

                              Navigator.of(context).pop();
                            },
                          ),
                          new FlatButton(
                            color: Color(0xff773E42),
                            child: new Text(
                              'Ver pedido',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new Domicilio(
                                              numeropagina: Categoria(2),
                                              numtab: Categoria(1))));
                            },
                          )
                        ],
                      );
                    })
                : SizedBox();


      },
      
      onLaunch: (Map<String, dynamic> message) async {
        print('======= On launch ========');
        print(" $message");

        String id_n = (message['data']['id_n']) as String;
        String id = (message['data']['id']) as String;
        String idc = (message['data']['idc']) as String;
        String idcn = (message['data']['idn']) as String;
        var idcnumber = int.parse(idc);
        print(idcn);
        id_n != null
            ? Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Publicacion_detalle_fin(
                          publicacion: new Publicacion(id_n, id),
                        )))
            : idcnumber != null
                ? Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Lista_enproceso(
                              carrito: new Costos(idc, idcn),
                            )))
                : SizedBox();
      },
      
      onResume: (Map<String, dynamic> message) async {
        print('======= On resume ========');
        print(" $message");

        String id_n = (message['data']['id_n']) as String;
        String id = (message['data']['id']) as String;
        String idc = (message['data']['idc']) as String;
        String idcn = (message['data']['idn']) as String;
        print(idc);
        print(idcn);

        var idcnumber = int.parse(idc);
        print(idcn);
        /*id_n != null
            ? Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Publicacion_detalle_fin(
                          publicacion: new Publicacion(id_n, id),
                        )))
            : */idcnumber != null
                ? Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Domicilio(
                            numeropagina: Categoria(2), numtab: Categoria(1))))
                : SizedBox();
      },
      onBackgroundMessage: myBackgroundMessageHandler,
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
          primarySwatch: Colors.grey,
          //primaryColor: Colors.black
          primaryColor: Colors.black,
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
                  Text(
                      "Cabofind te ayudará a generar tu pedido, posteriormente, se envía un whatsapp desde tu celular al mensajero," +
                          "este se pondrá en contacto con usted para validar el pedido.",
                      maxLines: 15,
                      style: TextStyle(
                        fontSize: 15.0,
                      )),
                  Text(
                      "El mensajero llegará con tu producto y con su ticket de compra.",
                      maxLines: 15,
                      style: TextStyle(
                        fontSize: 15.0,
                      )),
                  Text("Disponible únicamente en Cabo San Lucas.",
                      maxLines: 15,
                      style: TextStyle(
                        fontSize: 15.0,
                      )),
                  Text("Los precios pueden variar dependiendo la hora.",
                      maxLines: 15,
                      style: TextStyle(
                        fontSize: 15.0,
                      )),
                  Text("El servicio es totalmente ajeno a Cabofind. ",
                      maxLines: 15,
                      style: TextStyle(
                        fontSize: 15.0,
                      )),
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
                color: Colors.black,
                child: new Text(
                  'Acepto los terminos',
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Domicilio()));
                },
              )
            ],
          );
        },
      );
    }
/*

   _makeStripePayment() async {
      var environment = 'rest'; // or 'production'

      if (!(await FlutterGooglePay.isAvailable(environment))) {
        Fluttertoast.showToast(
          msg: "Google pay no disponible",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
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
          backgroundColor: Colors.black,
          textColor: Colors.white,
          timeInSecForIos: 1);
    
          }
        }).catchError((dynamic error) {
          Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
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
          backgroundColor: Colors.black,
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
          backgroundColor: Colors.black,
          textColor: Colors.white,
          timeInSecForIos: 1);
          } else if (result.error != null) {
            Fluttertoast.showToast(
          msg:result.error,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          timeInSecForIos: 1);
          }
        }).catchError((error) {
          //TODO
        });
      }
    }*/

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
          if (currencyCategory == fromCurrency) {
            _onFromChanged(value);
            _doConversion();
          } else {
            _onToChanged(value);
            _doConversion();
          }
        },
      );
    }

    Widget cuerpo = GridView.builder(
      shrinkWrap: true,
      itemCount: data == null ? 0 : data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.46,
      ),
      itemBuilder: (BuildContext context, int index) => Container(
        height: 400,
        padding: EdgeInsets.all(1),
        margin: EdgeInsets.all(1),
        child: Stack(
          children: [
            InkWell(
              child: Column(
                children: <Widget>[
                  CachedNetworkImage(
                    fit: BoxFit.fitHeight,
                    height: 400,
                    width: MediaQuery.of(context).size.width / 2,
                    imageUrl: data[index]["est_foto"],
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Container(
                      margin: EdgeInsets.only(top: 180),
                      child: Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ],
              ),
              onTap: () {
                String ruta = data[index]["est_navegacion"];
                print(ruta);

                if (ruta == "Restaurantes") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Restaurantes()));
                } else if (ruta == "Descubre") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Descubre()));
                } else if (ruta == "Compras") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Compras()));
                } else if (ruta == "Educacion") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Educacion()));
                } else if (ruta == "Eventos") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Eventos_grid()));
                } else if (ruta == "Acercade") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Acercade()));
                } else if (ruta == "Promociones") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Promociones_list()));
                } else if (ruta == "Salud") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Salud()));
                } else if (ruta == "Servicios") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Servicios()));
                } else if (ruta == "Vida_nocturna") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Vida_nocturna()));
                } else if (ruta == "Publicaciones") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Publicaciones_grid()));
                } else if (ruta == "Anuncios") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Anuncios()));
                } else if (ruta == "Mapa") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Maps()));
                } else if (ruta == "Rutas") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Rutas()));
                } else if (ruta == "domicilio") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Menu_comidas()));
                } else if (ruta == "rickys") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Rickys()));
                } else if (ruta == "Hotel") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Hoteles()));
                } else if (ruta == "Cabofood") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Domicilio(
                              numeropagina: Categoria(0),
                              numtab: Categoria(0))));
                }
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Point(
                      triangleHeight: 10.0,
                      edge: Edge.LEFT,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8, top: 8),
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 8.0, bottom: 8.0),
                        color: Color(int.parse(data[index]["est_color"])),
                        child: new Text(data[index]["est_nombre"],
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900,
                              //  backgroundColor: Colors.black45
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      /* staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 2),*/
    );

    return Scaffold(
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Colors.white,
          selectedItemBackgroundColor: Color(0xff773E42),
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Color(0xff773E42),
        ),
        items: [
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.home,
            label: 'Inicio',
          ),
          /*  FFNavigationBarItem(
            iconData: FontAwesomeIcons.shoppingCart,
            label: 'Carrito',
          ),
          
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.fire,
            label: 'Promos',
          ),
          
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.solidHeart,
            label: 'Favoritos',
          ),*/
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.userAlt,
            label: 'Cuenta',
          ),
        ],
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          this._c.animateToPage(index,
              duration: const Duration(milliseconds: 10),
              curve: Curves.easeInOut);
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
                background: GestureDetector(
                  onTap: () {},
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    imageUrl: portada[0]["POR_FOTO"],
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
                    onTap: () {
                      //_makeStripePayment();

                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new Notificaciones()));
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0,
                                    color: Colors.white)),
                            backgroundColor: Colors.red,
                          ),
                        ),
                        new Center(
                          child: new Row(children: <Widget>[
                            new Icon(FontAwesomeIcons.bell),
                            Text(
                              "  ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25.0),
                            ),
                          ]),
                        ),
                      ],
                    )),
                new InkResponse(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new WeatherBuilder().build()));
                    },
                    child: new Center(
                      child: new Row(children: <Widget>[
                        new Icon(FontAwesomeIcons.cloudSun),
                        Text(
                          "   ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.0),
                        ),
                      ]),
                    )),
                new InkResponse(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new Calculadora()));
                    },
                    child: new Center(
                      child: new Row(children: <Widget>[
                        new Icon(FontAwesomeIcons.moneyBillAlt),
                        Text(
                          "   ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.0),
                        ),
                      ]),
                    )),
                new InkResponse(
                    onTap: () {
                      addStringToSF();
                      //Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new MyHomePages_ing()));
                    },
                    child: new Center(
                      //padding: const EdgeInsets.all(13.0),

                      child: new Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: ExactAssetImage('assets/mexflag.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: new Text(
                          "     ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.0),
                        ),
                      ),
                    )),
                new IconButton(
                  icon: actionIcon,
                  onPressed: () {
                    //Use`Navigator` widget to push the second screen to out stack of screens
                    Navigator.of(context).push(MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                      return new Buscador();
                    }));
                  },
                ),
              ],
            ),
          ];
        },
        body: new PageView(
          controller: _c,
          onPageChanged: (newPage) {
            setState(() {
              this._page = newPage;
              selectedIndex = newPage;
            });
          },
          children: <Widget>[
            cuerpo,
            //new Mis_recompensas(),
            //new Mis_promos(),
            //new Mis_favoritos(),
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
