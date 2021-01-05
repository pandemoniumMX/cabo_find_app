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
import 'package:cabofind/paginas/recompensa_detalle.dart';
import 'package:cabofind/paginas/ricky.dart';
import 'package:cabofind/paginas/salud.dart';
import 'package:cabofind/paginas/scan.dart';
import 'package:cabofind/paginas_listas/list_eventos_grid.dart';
import 'package:cabofind/settings.dart';
import 'package:cabofind/utilidades/buscador.dart';
import 'package:cabofind/utilidades/calculadora.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:cabofind/utilidades/notificaciones.dart';
import 'package:cabofind/utilidades/rutas.dart';
import 'package:cabofind/weather/weather/weather_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:location/location.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'paginas/promociones.dart';
import 'package:geolocator/geolocator.dart' as geo;

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


class MyHomePages extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePages> {
  Future puntosLoad;
  Icon actionIcon = new Icon(Icons.search);

  Widget appBarTitle = new Text("Cabofind");
  var location = Location();
  String _status = "";

  List data;
  List portada;
  List rec;
  List promociones;
  List eventos;
  DateFormat dateFormat;
  List ciudad;
  String _ciudades;

  String apkversion = '';
  String _mail = '';

  int id = 0;


  //var mp = MP("CLIENT_ID", "CLIENT_SECRET");

  //final List<Todo> todos;
  Future<String> getData() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      apkversion = info.buildNumber;
      print(apkversion);

    });

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/estructura_esp_ios.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> getPortada() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/list_portada_ios.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      portada = json.decode(response.body);
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

  Future<String> getRec() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getString('stringLenguage');
    prefs.getString('stringCity');
    String _city = prefs.getString('stringCity');

    _mail = prefs.getString("stringID");

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_rec_main.php?CITY=$_city"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      rec = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> getPromociones() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getString('stringLenguage');
    prefs.getString('stringCity');
    String _city = prefs.getString('stringCity');
    _mail = prefs.getString("stringID");
    print(_mail);

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_promociones.php?CITY=$_city"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      promociones = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> getEventos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getString('stringLenguage');
    prefs.getString('stringCity');
    String _city = prefs.getString('stringCity');
    _mail = prefs.getString("stringID");
    print(_mail);

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_eventos.php?CITY=$_city"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      eventos = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> getCiudad() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getString('stringLenguage');
    prefs.getString('stringCity');
    String _city = prefs.getString('stringCity');
    String _idi = prefs.getString('stringLenguage');
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx//app_php/consultas_negocios/esp/ciudades.php"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      ciudad = json.decode(response.body);
      _ciudades = _city;
    });
    for (var u in ciudad) {
      // userStatus.add(false);
    }
    return "Success!";
  }
Future<Map> _getPuntos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('stringLenguage');
    prefs.getString('stringCity');
    String _city = prefs.getString('stringCity');
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/get_puntos.php?IDF=$_mail2&CITY=$_city");
    return json.decode(response.body);
  }

  _getCurrentLocation() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    }
    geo.Position position = await geo.Geolocator().getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.bestForNavigation);
  }

  saveCity(String ciudad) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stringCity', ciudad);
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) => new Myapp1()));
  }
  int _page = 0;
  PageController _c;
  @override
  void initState() {
    _c = new PageController(
      initialPage: _page,
    );
    puntosLoad = _getPuntos();
this.getCiudad();
this.getRec();
    this.getPromociones();
    this.getEventos();
        _getCurrentLocation();

    this.getPortada();
    isLogged(context);
    initializeDateFormatting();
    dateFormat = new DateFormat.MMMMd('es');

    super.initState();

    fcmSubscribe();

    setupNotification();
    this.getData();
    final _mensajesStreamController = StreamController<String>.broadcast();  
    this.checkModelAndroid();

  }
void dispose() {
    // TODO: implement dispose
    super.dispose();
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

    if (_token != "ingles") {
      //your home page is loaded
    } else {
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new MyHomePages_ing()));
    }
  }

  void setupNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.remove("stringValue");

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
        String idcn = (message['data']['idn']) as String;
        String tipo = (message['data']['tipo']) as String;
        var idcnumber = int.parse(idc);

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

                    // placeholder: AssetImage('android/assets/jar-loading.gif'),
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
                    color: Color(0xff192227),
                    child: new Text(
                      'Ver pedido',
                      style: TextStyle(
                          fontSize: 14.0, color: Colors.white),
                    ),
                    onPressed: () {
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
                    color: Color(0xff192227),
                    child: new Text(
                      'Ver pedido',
                      style: TextStyle(
                          fontSize: 14.0, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new Domicilio(
                                  numeropagina: Categoria(2),
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
                    color: Color(0xff192227),
                    child: new Text(
                      'Ver pedido',
                      style: TextStyle(
                          fontSize: 14.0, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new Domicilio(
                                  numeropagina:
                                  Categoria(2),
                                  numtab: Categoria(2))));
                    },
                  )
                ],
              );
            })
            : SizedBox();

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
      onLaunch: (Map<String, dynamic> message) async {
        print('======= On launch ========');
        print(" $message");

        String id_n = (message['data']['id_n']) as String;
        String id = (message['data']['id']) as String;
        String idc = (message['data']['idc']) as String;
        String idcn = (message['data']['idn']) as String;
        String tipo = (message['data']['tipo']) as String;
        var idcnumber = int.parse(idc);
        id_n != null
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
                    numeropagina: Categoria(2), numtab: Categoria(1))))
            : tipo == 'recoger'
            ? Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new Domicilio(
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
        String idcn = (message['data']['idn']) as String;
        String tipo = (message['data']['tipo']) as String;
        var idcnumber = int.parse(idc);
        id_n != null
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
                    numeropagina: Categoria(2), numtab: Categoria(1))))
            : tipo == 'recoger'
            ? Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new Domicilio(
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

  Widget build(BuildContext context) {
   
    Widget cuerpo = ListView(
      padding: EdgeInsets.zero, //hack para espacio en lista
      children: [
        Container(
            child: CarouselSlider.builder(
          autoPlay: true,
          height: 250.0,
          aspectRatio: 16 / 9,
          viewportFraction: 0.98,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayCurve: Curves.fastOutSlowIn,
          itemCount: portada == null ? 0 : portada.length,
          itemBuilder: (BuildContext context, int index) => Container(
            child: GestureDetector(
              onTap: () {
                String ruta = portada[index]["POR_RUTA"];

                if (ruta == "cabofood") {
                  apkversion == portada[0]["IOS_VERSION"]
                      ? Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => new Domicilio(
                                  numeropagina: Categoria(0),
                                  numtab: Categoria(0))))
                      : versionError();
                } else if (ruta == "mapa") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Maps()));
                } else if (ruta == "dados") {
                  _status != 'True'
                      ? Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => Login()))
                      : apkversion == portada[0]["IOS_VERSION"]
                          ? Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new DicePage()))
                          : versionError();
                } else if (ruta == "promociones") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Promociones_list()));
                } else if (ruta == "eventos") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Eventos_grid()));
                }
              },
              child: CachedNetworkImage(
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
                height: 230,
                imageUrl: portada[index]["POR_FOTO"],
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        )),
        Container(
          height: 140,
          child: ListView.builder(
            shrinkWrap: true,
            // physics: ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            //padding: EdgeInsets.only(top: 2),
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) => Container(
              height: 100,
              padding: EdgeInsets.all(10),
              // margin: EdgeInsets.all(2),
              child: InkWell(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                        imageUrl: data[index]["est_foto"],
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Container(
                          margin: EdgeInsets.only(top: 1),
                          child: Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Text(data[index]["est_nombre"],
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          //  backgroundColor: Colors.black45
                        ))
                  ],
                ),
                onTap: () {
                  String ruta = data[index]["est_navegacion"];

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
                            builder: (BuildContext context) =>
                                new Educacion()));
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
                            builder: (BuildContext context) =>
                                new Servicios()));
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
                    apkversion == portada[0]["IOS_VERSION"]
                        ? Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new Domicilio(
                                        numeropagina: Categoria(0),
                                        numtab: Categoria(0))))
                        : versionError();
                  }
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('Canjéa tus puntos aquí.',
              style: new TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              )),
        ),
        Container(
            height: 130,
            child: CarouselSlider.builder(
                autoPlay: true,
                height: 250.0,
                aspectRatio: 16 / 9,
                viewportFraction: 0.98,
                autoPlayInterval: Duration(seconds: 15),
                autoPlayCurve: Curves.fastOutSlowIn,
                itemCount: rec == null ? 0 : rec.length,
                itemBuilder: (BuildContext context, int index) {
                  return rec.isNotEmpty
                      ? Container(
                          //padding: EdgeInsets.all(5),
                          height: 100,
                          child: InkWell(
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 130,
                                    imageUrl: rec[index]["REC_FOTO"],
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Container(
                                      margin: EdgeInsets.only(top: 1),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Flexible(
                                            child: Text(
                                                rec[index]["NEG_NOMBRE"],
                                                style: new TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                          Flexible(
                                            fit: FlexFit.loose,
                                            child: Text(
                                                rec[index]["REC_TITULO"],
                                                style: new TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w300,
                                                )),
                                          ),
                                          Text(
                                              '🔴 ' +
                                                  rec[index]["REC_META"] +
                                                  ' PUNTOS',
                                              style: new TextStyle(
                                                color: Colors.red,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            onTap: () {
                              String id_re = rec[index]["ID_RECOMPENSA"];
                              String id_n = rec[index]["ID_NEGOCIO"];

                              _status != 'True'
                                  ? Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Login()))
                                  : apkversion == portada[0]["IOS_VERSION"]
                                      ? Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new Recompensa_detalle(
                                                    publicacion:
                                                        new Publicacion2(
                                                            id_re, id_n, _mail),
                                                  )))
                                      : versionError();
                            },
                          ),
                        )
                      : Center(child: Text('Proximamente'));
                })),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('Promociones actuales.',
              style: new TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              )),
        ),
        Container(
            height: 130,
            child: CarouselSlider.builder(
              autoPlay: true,
              height: 250.0,
              aspectRatio: 16 / 9,
              viewportFraction: 0.98,
              autoPlayInterval: Duration(seconds: 15),
              autoPlayCurve: Curves.fastOutSlowIn,
              itemCount: promociones == null ? 0 : promociones.length,
              itemBuilder: (BuildContext context, int index) {
                return promociones.isNotEmpty
                    ? Container(
                        height: 100,
                        child: InkWell(
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 200,
                                  imageUrl: promociones[index]["GAL_FOTO"],
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Container(
                                    margin: EdgeInsets.only(top: 1),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Flexible(
                                          child: Text(
                                              promociones[index]["NEG_NOMBRE"],overflow: TextOverflow.ellipsis,
                                              style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ),
                                        Flexible(
                                          child: Text(
                                              promociones[index]["PUB_TITULO"],
                                              style: new TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w300,
                                              )),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          onTap: () {
                            String id_n = promociones[index]["ID_NEGOCIO"];
                            String id = promociones[index]["ID_PUBLICACION"];

                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        new Publicacion_detalle_fin(
                                          publicacion:
                                              new Publicacion(id_n, id),
                                        )));
                          },
                        ),
                      )
                    : Center(child: Text('Proximamente'));
              },
            )),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('Eventos próximos.',
              style: new TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              )),
        ),
        Container(
          height: 160,
          child: CarouselSlider.builder(
            autoPlay: true,
            height: 250.0,
            aspectRatio: 16 / 9,
            viewportFraction: 0.98,
            autoPlayInterval: Duration(seconds: 15),
            autoPlayCurve: Curves.fastOutSlowIn,
            itemCount: eventos == null ? 0 : eventos.length,
            itemBuilder: (BuildContext context, int index) {
              return eventos.isNotEmpty
                  ? Container(
                      height: 150,
                      padding: EdgeInsets.all(5.0),
                      child: InkWell(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: 150,
                                width: 380,
                                imageUrl: eventos[index]["GAL_FOTO"],
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Container(
                                  margin: EdgeInsets.only(top: 1),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration:
                                      BoxDecoration(color: Colors.black26),
                                  height: 80,
                                  child: Column(
                                    children: [
                                      Text(eventos[index]["NEG_NOMBRE"],
                                          style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      Text(eventos[index]["PUB_TITULO"],
                                          style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w300,
                                          )),
                                      Text(
                                          dateFormat.format(DateTime.parse(
                                              eventos[index]
                                                  ["PUB_FECHA_LIMITE"])),
                                          style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w300,
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        onTap: () {
                          String id_n = eventos[index]["ID_NEGOCIO"];
                          String id = eventos[index]["ID_PUBLICACION"];

                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      new Publicacion_detalle_fin(
                                        publicacion: new Publicacion(id_n, id),
                                      )));
                        },
                      ),
                    )
                  : Center(child: Text('No hay eventos próximos'));
            },
          ),
        )
      ],
    );

    return Scaffold(
      /* bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _page,
        backgroundColor: Colors.white,
        fixedColor: Color(0xff192227),
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
          selectedItemBackgroundColor: Color(0xff192227),
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Color(0xff192227),
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
              expandedHeight: 50.0,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(top: 20.0),
                centerTitle: false,
                title: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          FutureBuilder(
                              future:
                                  puntosLoad, //hack future builder // Correct way
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                  case ConnectionState.waiting:
                                    return Center(
                                        child: CircularProgressIndicator());
                                  default:
                                    if (snapshot.hasError) {
                                      return Row(
                                        children: [
                                          new Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: new BoxDecoration(
                                              color: const Color(0xff7c94b6),
                                              image: new DecorationImage(
                                                image: ExactAssetImage(
                                                    'assets/noprofile.png'),
                                                fit: BoxFit.fill,
                                              ),
                                              borderRadius: new BorderRadius
                                                      .all(
                                                  new Radius.circular(50.0)),
                                              border: new Border.all(
                                                color: Colors.white,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            ' 0 PUNTOS',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      );
                                    } else if (snapshot.hasData &&
                                        snapshot.data["Total"] != null &&
                                        snapshot.data["USU_FOTO"] != null) {
                                      return Row(
                                        children: [
                                          new Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: new BoxDecoration(
                                              color: const Color(0xff7c94b6),
                                              image: new DecorationImage(
                                                image: NetworkImage(
                                                    snapshot.data["USU_FOTO"]),
                                                fit: BoxFit.fill,
                                              ),
                                              borderRadius: new BorderRadius
                                                      .all(
                                                  new Radius.circular(50.0)),
                                              border: new Border.all(
                                                color: Colors.white,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            ' ' +
                                                snapshot.data['Total'] +
                                                ' PUNTOS',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Row(
                                        children: [
                                          new Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: new BoxDecoration(
                                              color: Colors.white,
                                              image: new DecorationImage(
                                                image: ExactAssetImage(
                                                    'assets/noprofile.png'),
                                                fit: BoxFit.fill,
                                              ),
                                              borderRadius: new BorderRadius
                                                      .all(
                                                  new Radius.circular(50.0)),
                                              border: new Border.all(
                                                color: Colors.white,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            ' 0 PUNTOS',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      );
                                    }
                                }
                              })
                        ],
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          iconSize: 0.0,
                          dropdownColor: Color(0xff192227),
                          hint: Text('Seleccionar ciudad'),
                          items: ciudad.map((item) {
                            return new DropdownMenuItem(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(
                                      item['CIU_NOMBRE'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                              value: item['idciudades'].toString(),
                            );
                          }).toList(),
                          onTap: null,
                          onChanged: (newVal) {
                            setState(() {
                              _ciudades = newVal;
                              saveCity(newVal);
                            });
                          },

                          value: _ciudades,

                          // isExpanded: true,
                        ),
                      ),
                      SizedBox()
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
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
            apkversion == portada[0]["IOS_VERSION"]
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
}