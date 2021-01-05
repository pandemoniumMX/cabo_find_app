import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas_ing/acercade.dart';
import 'package:cabofind/paginas_ing/compras.dart';
import 'package:cabofind/paginas_ing/descubre.dart';
import 'package:cabofind/paginas_ing/educacion.dart';
import 'package:cabofind/paginas_ing/login.dart';
import 'package:cabofind/paginas_ing/maps.dart';
import 'package:cabofind/paginas_ing/misfavoritos.dart';
import 'package:cabofind/paginas_ing/mispromos.dart';
import 'package:cabofind/paginas_ing/promociones.dart';
import 'package:cabofind/paginas_ing/publicacion_detalle.dart';
import 'package:cabofind/paginas_ing/publicaciones.dart';
import 'package:cabofind/paginas_ing/restaurantes.dart';
import 'package:cabofind/paginas_ing/salud.dart';
import 'package:cabofind/paginas_ing/servicios.dart';
import 'package:cabofind/paginas_ing/vida_nocturna.dart';
import 'package:cabofind/paginas_listas_ing/list_eventos_grid.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart' as geo;import 'package:cabofind/utilidades/classes.dart';
import 'package:cabofind/utilidades_ing/buscador.dart';
import 'package:cabofind/utilidades_ing/calculadora.dart';
import 'package:cabofind/utilidades_ing/notificaciones.dart';
import 'package:cabofind/utilidades_ing/rutas.dart';
import 'package:cabofind/weather/weather/weather_builder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:location/location.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cabofind/paginas/acercade.dart';
import 'package:cabofind/paginas/restaurantes.dart';
import 'package:cabofind/paginas/servicios.dart';
import 'package:cabofind/paginas/compras.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';
import 'main_esp.dart';
import 'paginas_ing/anuncios.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:geocoder/geocoder.dart';
//import 'package:geolocator/geolocator.dart';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void fcmSubscribe() {
  _firebaseMessaging.unsubscribeFromTopic('Todos');
  _firebaseMessaging.subscribeToTopic('All');
}


class MyHomePages_ing extends StatefulWidget {
  @override
  _MyHomePages_ing createState() => new _MyHomePages_ing();
}

class _MyHomePages_ing extends State<MyHomePages_ing> {
  final fromTextController = TextEditingController();
  List<String> currencies;
  String fromCurrency = "USD";
  String toCurrency = "MXN";
  String result;
  Icon idioma_ing = new Icon(Icons.flag);
  Icon actionIcon = new Icon(Icons.search);
  List portada;
  List data;
  Future puntosLoad;


  Widget appBarTitle = new Text("Cabofind");

  @override
  final String _idioma = "espanol";

  List promociones;
  List eventos;
  DateFormat dateFormat;
  List ciudad;
  String _ciudades;
  String apkversion = '';
  String _mail = '';
    var location = Location();

saveCity(String ciudad) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stringCity', ciudad);
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) => new Myapp1()));
  }

  Future<String> getPortada() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/list_portada_ios_ing.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      portada = json.decode(response.body);
    });

    return "Success!";
  }

  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/estructura_ing.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
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
            "http://cabofind.com.mx/app_php/APIs/esp/list_promociones_ing.php?CITY=$_city"),
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
            "http://cabofind.com.mx/app_php/APIs/esp/list_eventos_ing.php?CITY=$_city"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      eventos = json.decode(response.body);
    });

    return "Success!";
  }

 _getCurrentLocation() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    }
    geo.Position position = await geo.Geolocator().getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.bestForNavigation);
  }

  Future<Map> _getPuntos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('stringLenguage');
    prefs.getString('stringCity');
    String _city = prefs.getString('stringCity');
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/get_puntos.php?IDF=$_mail2&CITY=$_city");
    return json.decode(response.body);
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

  

  @override
  void initState() {
   puntosLoad = _getPuntos();

    this.getPortada();
    this.getEventos();
    this.getPromociones();
    super.initState();
    this.getCiudad();
    _c = new PageController(
      initialPage: _page,
    );
    fcmSubscribe();
    setupNotification();
    this.getData();
    _getCurrentLocation();
    initializeDateFormatting();

    dateFormat = new DateFormat.MMMMd('en');

    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

    final _mensajesStreamController = StreamController<String>.broadcast();
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
      result = (double.parse(fromTextController.text) *
              (responseBody["rates"][toCurrency]))
          .toString();
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
    prefs.setString('stringValue', _idioma);
  }

  void setupNotification() async {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print('===== FCM Token =====');
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('======= On Message ========');
        print(" $message");

        String id_n = (message['data']['id_n']) as String;
        String id = (message['data']['id']) as String;

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'New post!',
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
                    child: new Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    color: Colors.black,
                    child: new Text(
                      'Discover',
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  new Publicacion_detalle_fin_ing(
                                    publicacion: new Publicacion(id_n, id),
                                  )));
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
      onLaunch: (Map<String, dynamic> message) async {
        print('======= On launch ========');
        print(" $message");

        String id_n = (message['data']['id_n']) as String;
        String id = (message['data']['id']) as String;

        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new Publicacion_detalle_fin_ing(
                      publicacion: new Publicacion(id_n, id),
                    )));
      },
      onResume: (Map<String, dynamic> message) async {
        print('======= On resume ========');
        print(" $message");

        String id_n = (message['data']['id_n']) as String;
        String id = (message['data']['id']) as String;

        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new Publicacion_detalle_fin_ing(
                      publicacion: new Publicacion(id_n, id),
                    )));
      },
    );
  }

  int _page = 0;
  int selectedIndex = 0;
  PageController _c;
  Widget build(BuildContext context) {
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
          if (currencyCategory == fromCurrency) {
            _onFromChanged(value);
          } else {
            _onToChanged(value);
          }
        },
      );
    }

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
                  /*  apkversion == portada[0]["APK_VERSION"]
                      ? Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => new Domicilio(
                                  numeropagina: Categoria(0),
                                  numtab: Categoria(0))))
                      : versionError();*/
                } else if (ruta == "mapa") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Maps_ing()));
                } else if (ruta == "dados") {
                  /*  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new DicePage_ing()));*/
                } else if (ruta == "promociones") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Promociones_list_ing()));
                } else if (ruta == "eventos") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Eventos_ing_grid()));
                }
              },
              child: CachedNetworkImage(
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
                height: 230,
                imageUrl: portada[index]["POR_FOTO_ING"],
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
                      borderRadius: BorderRadius.circular(10.0),
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
                    Text(data[index]["est_nombre_ing"],
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
                                new Restaurantes_ing()));
                  } else if (ruta == "Descubre") {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Descubre_ing()));
                  } else if (ruta == "Compras") {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Compras_ing()));
                  } else if (ruta == "Educacion") {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Educacion_ing()));
                  } else if (ruta == "Eventos") {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Eventos_ing_grid()));
                  } else if (ruta == "Acercade") {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Acercade_ing()));
                  } else if (ruta == "Promociones") {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Promociones_list_ing()));
                  } else if (ruta == "Salud") {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Salud_ing()));
                  } else if (ruta == "Servicios") {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Servicios_ing()));
                  } else if (ruta == "Vida_nocturna") {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Vida_nocturna_ing()));
                  } else if (ruta == "Publicaciones") {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Publicaciones_grid_ing()));
                  } else if (ruta == "Anuncios") {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Anuncios_ing()));
                  } else if (ruta == "Mapa") {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Maps_ing()));
                  } else if (ruta == "Rutas") {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Rutas_ing()));
                  } else if (ruta == "Cabofood") {}
                },
              ),
            ),
          ),
        ),
        /*  Padding(
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
                          height: 100,
                          child: InkWell(
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  fit: BoxFit.contain,
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
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Flexible(
                                          child: Text(rec[index]["NEG_NOMBRE"],
                                              style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ),
                                        Flexible(
                                          fit: FlexFit.loose,
                                          child: Text(rec[index]["REC_TITULO"],
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
                                    )
                                  ],
                                )
                              ],
                            ),
                            onTap: () {
                              String id_re = rec[index]["ID_RECOMPENSA"];
                              String id_n = rec[index]["ID_NEGOCIO"];
                              apkversion == portada[0]["APK_VERSION"]
                                  ? Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new Recompensa_detalle(
                                                publicacion: new Publicacion2(
                                                    id_re, id_n, _mail),
                                              )))
                                  : versionError();
                            },
                          ),
                        )
                      : Text('Proximamente');
                })),*/
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('Current promotions.',
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
                                    padding: const EdgeInsets.all(8.0),
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
                                              promociones[index]
                                                  ["PUB_TITULO_ING"],overflow: TextOverflow.ellipsis,
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
                                        new Publicacion_detalle_fin_ing(
                                          publicacion:
                                              new Publicacion(id_n, id),
                                        )));
                          },
                        ),
                      )
                    : Center(child: Text('Coming soon'));
              },
            )),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('Upcoming events.',
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
                                imageUrl: eventos[index]["GAL_FOTO_ING"],
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
                                      Text(eventos[index]["PUB_TITULO_ING"],
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
                                      new Publicacion_detalle_fin_ing(
                                        publicacion: new Publicacion(id_n, id),
                                      )));
                        },
                      ),
                    )
                  : Center(child: Text('No upcoming events'));
            },
          ),
        )
      ],
    );

    return Scaffold(
      bottomNavigationBar: FFNavigationBar(
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
            label: 'Home',
          ),
          /*  FFNavigationBarItem(
            iconData: FontAwesomeIcons.fire,
            label: 'Deals',
          ),
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.solidHeart,
            label: 'Favorites',
          ),*/
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.userAlt,
            label: 'Profile',
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
                                            ' Cabofind',
                                            style: TextStyle(
                                                fontSize: 18,
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
                                            ' Cabofind',
                                            style: TextStyle(
                                                fontSize: 18,
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
                                            ' Cabofind',
                                            style: TextStyle(
                                                fontSize: 18,
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
                                          fontSize: 18,
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
                      return new Buscador_ing();
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
            // new Mis_promos_ing(),
            // new Mis_favoritos_ing(),
            new Login_ing()
          ],
        ),
      ),
    );
  }
}
