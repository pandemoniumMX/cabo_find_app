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
import 'package:cabofind/paginas/mis_reservaciones.dart';
import 'package:cabofind/paginas/mispromos.dart';
import 'package:cabofind/paginas/misrecompensa.dart';
import 'package:cabofind/paginas/pedidos_proceso_list.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas/publicaciones.dart';
import 'package:cabofind/paginas/ricky.dart';
import 'package:cabofind/paginas/salud.dart';
import 'package:cabofind/paginas_listas/list_eventos_grid.dart';
import 'package:cabofind/settings.dart';
import 'package:cabofind/utilidades/buscador.dart';
import 'package:cabofind/utilidades/calculadora.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:cabofind/utilidades/notificaciones.dart';
import 'package:cabofind/utilidades/rutas.dart';
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
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'paginas/promociones.dart';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void fcmSubscribe() async {
  final SharedPreferences login = await SharedPreferences.getInstance();

  _firebaseMessaging.unsubscribeFromTopic('All');
  _firebaseMessaging.subscribeToTopic('Todos');
}



class MyHomePages extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePages> {

  Icon actionIcon = new Icon(Icons.search);

  Widget appBarTitle = new Text("Cabofind");

  @override

  List data;
  List portada;

  String apkversion='';

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

  Future<String> getData() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      apkversion = info.version;
    });

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/estructura_esp.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }


  @override //Registro descarga en Android

  Future<String> checkModelAndroid() async {
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
    this.getPortada();
    super.initState();
    _c = new PageController(
      initialPage: _page,
    );
    fcmSubscribe();
    setupNotification();
    this.getData();
    //this.checkModelIos();
    this.checkModelAndroid();
    ///this._getLocation();
    initializeDateFormatting();
  }
  


  void setupNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print('===== FCM Token =====');
      print(token);
      prefs.setString('stringToken', token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('======= On Message ========');
        print(" $message");
        String id_n = (message['data']['id_n']) as String;
        String id = (message['data']['id']) as String;
        String idc = (message['data']['idc']) as String;
        String tipo = (message['data']['tipo']) as String;
        String idr = (message['data']['idr']) as String;

        var idcnumber = int.parse(idc);

        

        idr != null
            ? showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Reservaciones',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    content: Container(
                        width: 300,
                        height: 50.0,
                        child: Text('Estado de la reservación #$idr')),
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
                          'Ver estado',
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new Mis_reservaciones()));
                        },
                      )
                    ],
                  );
                })
            : id_n != null
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

                            // placeholder: AssetImage('android/assets/images/loading.gif'),
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
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new Publicacion_detalle_fin(
                                            publicacion:
                                                new Publicacion(id_n, id),
                                          )));
                            },
                          )
                        ],
                      );
                    })
                : tipo == 'domicilio'
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
                                child:
                                    Text('Pedido número #$idcnumber enviado')),
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
                                  Navigator.pushReplacement(
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
                    : tipo == 'recoger'
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
                                    child: Text(
                                        'Pedido número #$idcnumber listo para recoger')),
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
                                      Navigator.pushReplacement(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new Domicilio(
                                                      numeropagina:
                                                          Categoria(2),
                                                      numtab: Categoria(0))));
                                    },
                                  )
                                ],
                              );
                            })
                        : tipo == 'cancelado'
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
                                        child: Text(
                                            'Pedido número #$idcnumber fue cancelado')),
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
                                              fontSize: 14.0,
                                              color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.pushReplacement(
                                              context,
                                              new MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          new Domicilio(
                                                              numeropagina:
                                                                  Categoria(2),
                                                              numtab: Categoria(
                                                                  2))));
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
        String tipo = (message['data']['tipo']) as String;
        String idr = (message['data']['idr']) as String;

        idr != null
            ? Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Mis_reservaciones()))
            : id_n != null
                ? Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Publicacion_detalle_fin(
                              publicacion: new Publicacion(id_n, id),
                            )))
                : tipo == 'domicilio'
                    ? Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Domicilio(
                                numeropagina: Categoria(2),
                                numtab: Categoria(1))))
                    : tipo == 'recoger'
                        ? Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new Domicilio(
                                        numeropagina: Categoria(2),
                                        numtab: Categoria(0))))
                        : tipo == 'cancelado'
                            ? Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new Domicilio(
                                            numeropagina: Categoria(2),
                                            numtab: Categoria(2))))
                            : SizedBox();
      },
      onResume: (Map<String, dynamic> message) async {
        print('======= On resume ========');
        print(" $message");

        String id_n = (message['data']['id_n']) as String;
        String id = (message['data']['id']) as String;
        String idc = (message['data']['idc']) as String;
        String tipo = (message['data']['tipo']) as String;
        String idr = (message['data']['idr']) as String;

        idr != null
            ? Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Mis_reservaciones()))
            : id_n != null
                ? Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Publicacion_detalle_fin(
                              publicacion: new Publicacion(id_n, id),
                            )))
                : tipo == 'domicilio'
                    ? Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Domicilio(
                                numeropagina: Categoria(2),
                                numtab: Categoria(1))))
                    : tipo == 'recoger'
                        ? Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new Domicilio(
                                        numeropagina: Categoria(2),
                                        numtab: Categoria(0))))
                        : tipo == 'cancelado'
                            ? Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new Domicilio(
                                            numeropagina: Categoria(2),
                                            numtab: Categoria(2))))
                            : SizedBox();
      },
    );
  }

  versionError() {
    Fluttertoast.showToast(
        msg: portada[0]["POR_MSJ"],
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIos: 1);
  }
  int _page = 0;
  int selectedIndex = 0;
  PageController _c;
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

    Widget cuerpo = GridView.builder(
      padding: EdgeInsets.only(top: 2),
      itemCount: data == null ? 0 : data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.height / 1500,
      ),
      itemBuilder: (BuildContext context, int index) => Container(
        height: 400,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(2),
        child: Stack(
          children: [
            InkWell(
              child: CachedNetworkImage(
                fit: BoxFit.fitHeight,
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 2,
                imageUrl: data[index]["est_foto"],
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
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
                  apkversion == portada[0]["APK_VERSION"]
                      ? Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => new Domicilio(
                                  numeropagina: Categoria(0),
                                  numtab: Categoria(0))))
                      : versionError();
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
                            left: 18.0, right: 18.0, top: 8.0, bottom: 8.0),
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
      /* bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _page,
        backgroundColor: Colors.white,
        fixedColor: Color(0xff773E42),
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: false,
        //unselectedIconTheme: Colors.grey,

        onTap: (index) {
          this._c.animateToPage(index,
              duration: const Duration(milliseconds: 100),
              curve: Curves.bounceIn);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.home,
              ),
              title: Text("Inicio")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.gift,
              ),
              title: Text("Rewards")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.userAlt,
              ),
              title: Text("Perfil")),
        ],
      ),*/

      bottomNavigationBar: FFNavigationBar(
        selectedIndex: _page,
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
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.gift,
            label: 'Rewards',
          ),
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.userAlt,
            label: 'Cuenta',
          ),
        ],
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
                      //Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new Settings()));
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
          physics: const NeverScrollableScrollPhysics(),
          controller: _c,
          onPageChanged: (newPage) {
            setState(() {
              this._page = newPage;
              // selectedIndex = newPage;
            });
          },
          children: <Widget>[
            cuerpo,
            apkversion == portada[0]["APK_VERSION"]
                ? Mis_recompensas()
                : ListView(
                    shrinkWrap: true,
                    //addAutomaticKeepAlives: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      SizedBox(
                        height: 100.0,
                      ),
                      Center(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              "assets/cabofind.png",
                              fit: BoxFit.fill,
                              width: 150.0,
                              height: 150.0,
                            )),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      //SizedBox(height: 25.0,),
                      Center(
                          child: Text(
                        portada[0]["POR_MSJ"],
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: RaisedButton(
                              onPressed: () {
                                FlutterYoutube.playYoutubeVideoByUrl(
                                    apiKey:
                                        "AIzaSyAmNDqJm2s5Fpualsl_VF6LhG733knN0BY",
                                    videoUrl:
                                        'https://www.youtube.com/watch?v=hsLSjImkf-c',
                                    autoPlay: false, //default falase
                                    fullScreen: false //default false
                                    );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0)),
                              color: Colors.red,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Icon(
                                    FontAwesomeIcons.youtube,
                                    color: Colors.white,
                                  ),
                                  new Text('  Ver video',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white)),
                                ],
                              ))),
                      Center(
                          child: SizedBox(
                        height: 25.0,
                      )),
                    ],
                  ),
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
