import 'dart:async';
import 'dart:convert';
import 'package:cabofind/main_ing.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:cabofind/utilidades/maps_restaurantes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_esp.dart';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void fcmSubscribe() {
  _firebaseMessaging.unsubscribeFromTopic('All');
  _firebaseMessaging.subscribeToTopic('Todos');
}

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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Color(0xff192227),
          //primaryColor: Colors.black,
          accentColor: Color(0xff192227),
        ),
        home: new Container(child: new Start()));
  }
}

class Start extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<Start> {
  Icon actionIcon = new Icon(Icons.search);
  final _formKey = GlobalKey<FormState>();

  Widget appBarTitle = new Text("Cabofind");
  int id = 0;
  int _value = 1;
  List data;
  List ciudad;
  int ciudadselect = 1;
  String _ciudades;
  @override //Registro descarga en Android
  Future<String> checkModelAndroid() async {
    String currentLocale;
    try {
      currentLocale = await Devicelocale.currentLocale;
      print(currentLocale);
    } on PlatformException {}

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insertInfo.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=${currentLocale}"),
        headers: {"Accept": "application/json"});
  }

  Future<String> getCiudad() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx//app_php/consultas_negocios/esp/ciudades.php"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      ciudad = json.decode(response.body);
      //  userStatus.add(false);
    });
    for (var u in ciudad) {
      // userStatus.add(false);
    }
    return "Success!";
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

  @override
  void initState() {
    //addStringToSF();
    isLogged(context);
    this.getCiudad();

    super.initState();
    // setupNotification();

    final _mensajesStreamController = StreamController<String>.broadcast();
    dispose() {
      _mensajesStreamController?.close();
    }

    this.checkModelAndroid();
  }

  saveSettings(String idioma, String ciudad) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.remove("stringValue");
    prefs.setString('stringLenguage', idioma);
    prefs.setString('stringCity', ciudad);
  }

  Future isLogged(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getString('stringLenguage');
    prefs.getString('stringCity');
    String _lenguage = prefs.getString('stringLenguage');
    String _city = prefs.getString('stringCity');

    if (_lenguage != "2" && _city != null) {
      Navigator.of(context).pop();
      // Route route = MaterialPageRoute(builder: (context) => Myapp());x
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new MyHomePages()));
    } else if (_lenguage != "1" && _city != null) {
      Navigator.of(context).pop();
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new MyHomePages_ing()));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: appBarTitle,
        actions: <Widget>[],
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.fitHeight,
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        imageUrl:
                            'https://seecolombia.travel/blog/wp-content/uploads/2015/02/Nadar-cerca-del-Arco.jpg',
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Container(
                          child: Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 150.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: FadeInImage(
                            image: AssetImage('assets/cabofind.png'),
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                            placeholder:
                                AssetImage('android/assets/images/loading.gif'),
                            fadeInDuration: Duration(milliseconds: 200),
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              _value == 1
                  ? Text(
                      'Bienvenido',
                      style: TextStyle(fontSize: 25),
                    )
                  : Text(
                      'Welcome',
                      style: TextStyle(fontSize: 25),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _value == 1 ? Text('Idioma') : Text('Lenguage'),
                  Container(
                    width: 200,
                    child: DropdownButton(
                        onTap: () {
                          setState(() {});
                        },
                        isExpanded: true,
                        value: _value,
                        items: [
                          DropdownMenuItem(
                            child: Row(children: [
                              Text("Español  "),
                              CachedNetworkImage(
                                fit: BoxFit.fitHeight,
                                height: 20,
                                width: 30,
                                imageUrl:
                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Bandera_de_México_%281916-1934%29.png/1280px-Bandera_de_México_%281916-1934%29.png',
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Container(
                                  margin: EdgeInsets.only(top: 180),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )
                            ]),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Row(children: [
                              Text("English   "),
                              CachedNetworkImage(
                                fit: BoxFit.fitHeight,
                                height: 20,
                                width: 30,
                                imageUrl:
                                    'https://upload.wikimedia.org/wikipedia/en/thumb/a/a4/Flag_of_the_United_States.svg/1280px-Flag_of_the_United_States.svg.png',
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Container(
                                  margin: EdgeInsets.only(top: 180),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )
                            ]),
                            value: 2,
                          ),
                        ],
                        onChanged: (valuex) {
                          setState(() {
                            _value = valuex;
                          });
                        }),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _value == 1 ? Text('Ciudad') : Text('City          '),
                  Container(
                      width: 200,
                      child: DropdownButtonFormField(
                        items: ciudad.map((item) {
                          return new DropdownMenuItem(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(item['CIU_NOMBRE']),
                                ]),
                            onTap: () {},
                            value: item['idciudades'].toString(),
                          );
                        }).toList(),
                        onTap: null,
                        onChanged: (newVal) {
                          _ciudades = newVal;
                        },
                        validator: (value) =>
                            value == null ? 'Campo requerido' : null,
                        value: _ciudades,
                        hint:
                            _value == 1 ? Text('Seleccionar') : Text('Select'),

                        // isExpanded: true,
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                  onPressed: () {
                    String idioma = _value.toString();
                    String ciudad = ciudadselect.toString();
                    if (_formKey.currentState.validate()) {
                      saveSettings(idioma, ciudad);
                      if (_value != 2) {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new MyHomePages()));
                      } else {
                        Navigator.of(context).pop();

                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new MyHomePages_ing()));
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  color: Color(0xff60032D),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _value == 1
                          ? new Text('Guardar ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white))
                          : Text('Save ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                      new Icon(
                        FontAwesomeIcons.save,
                        color: Colors.white,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
