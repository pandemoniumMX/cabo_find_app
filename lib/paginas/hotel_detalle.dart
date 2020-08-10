import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas/publicacion_detalle_estatica.dart';
import 'package:cabofind/utilidades/clasesilver.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:cabofind/paginas/reservacion.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/services.dart';
//import 'package:flutter/Reservacion.dart';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//import 'reseña_insert.dart';

class Hotel_detalle extends StatefulWidget {
//final Publicacion publicacion;
  final Empresa empresa;

  Hotel_detalle({Key key, @required this.empresa}) : super(key: key);

  @override
  Detalles createState() => new Detalles();
}

class Detalles extends State<Hotel_detalle> {
  TextEditingController controllerCode = TextEditingController();
  String _displayValue = "";
  String _displayValor = "";

  bool widgetcarac = false;

  Map userProfile;

  List _cities = ["👍", "👎"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  bool isLoggedIn = false;
  List data;
  List data_serv;
  List data_serh;
  List data_hab;
  List dataneg;
  List data_list;
  List data_carrusel;
  List data_car;
  List logos;
  List descripcion;
  List data_resena;
  int _current = 0;
  String reason = '';

  Future<String> getResena() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_resena.php?ID=${widget.empresa.id_nm}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data_resena = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> getInfo() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_hotel_api.php?ID=${widget.empresa.id_nm}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      dataneg = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> getCar() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_car_hab.php?ID=${widget.empresa.id_nm}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data_car = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> getSerH() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_ser_hab.php?ID=${widget.empresa.id_nm}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data_serh = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> getHab() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_tip_hab.php?ID=${widget.empresa.id_nm}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data_hab = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> getSer() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_servicios_api.php?ID=${widget.empresa.id_nm}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data_serv = json.decode(response.body);
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
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    //print('Running on ${iosInfo.identifierForVendor}');
    var response = await http.get(Uri.encodeFull(
            // "http://cabofind.com.mx/app_php/APIs/esp/insert_visita_negocio.php?ID=${widget.empresa.id_nm}"),
            "http://cabofind.com.mx/app_php/APIs/esp/insert_reporte.php?MOD=${iosInfo.model}&BOOT=${iosInfo.utsname.nodename},${iosInfo.identifierForVendor}&VERSION=${iosInfo.systemName}&IDIOMA=esp&ID=${widget.empresa.id_nm}&SO=iOS"),
        headers: {"Accept": "application/json"});
  }

  Future<String> get_list() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_publicaciones_api.php?ID=${widget.empresa.id_nm}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data_list = json.decode(response.body);
    });

    return "Success!";
  }
//contador de visitas android
/*
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
            "http://cabofind.com.mx/app_php/APIs/esp/insert_visita_negocio.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=esp&ID=${widget.empresa.id_nm}&SO=Android"),


        headers: {
          "Accept": "application/json"
        }
    );
}
*/

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
    var response = await http.get(Uri.encodeFull(
            // "http://cabofind.com.mx/app_php/APIs/esp/insert_visita_negocio.php?ID=${widget.empresa.id_nm}"),
            "http://cabofind.com.mx/app_php/APIs/esp/insert_visita_negocio.php?MOD=${iosInfo.model}&BOOT=${iosInfo.utsname.nodename},${iosInfo.identifierForVendor}&VERSION=${iosInfo.systemName}&IDIOMA=esp&ID=${widget.empresa.id_nm}&SO=iOS"),
        headers: {"Accept": "application/json"});
  }

  Future<String> getCarrusel() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/galeria_hotel_api.php?ID=${widget.empresa.id_nm}"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      data_carrusel = json.decode(response.body);
    });
    return "Success!";
  }

  Future<Map> getPortada() async {
    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/galeria_hotel_api2.php?ID=${widget.empresa.id_nm}");
    return json.decode(response.body);
  }

  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
    this.getCar();
    this.get_list();
    this.getSer();
    this.getCarrusel();
    this.getInfo();
    this.getSerH();
    this.getHab();
    //this.insertVisitaAndroid();
    this.getResena();
    this.insertVisitaiOS;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  void onLoginStatusChange(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  void showResena() {
    Fluttertoast.showToast(
      msg: "Reseña enviada exitosamente",
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  void reporte() {
    Fluttertoast.showToast(
      msg: "Comentario reportado",
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerCode.dispose();
    super.dispose();
  }

  void initiateFacebookLogin() async {
    var login = FacebookLogin();
    var result = await login.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.error:
        print("Surgio un error");
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelado por el usuario");
        break;
      case FacebookLoginStatus.loggedIn:
        onLoginStatusChange(true);
        //getInfofb(result,_displayValue);
        final _formKey = GlobalKey<FormState>();

        return showDialog(
            context: context,
            builder: (context) {
              return Form(
                key: _formKey,
                child: AlertDialog(
                  title: Text(
                    'Reseña',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  content: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 350.0,
                      child: Column(
                        children: <Widget>[
                          Text('Valoración'),
                          DropdownButton(
                            value: _currentCity,
                            items: _dropDownMenuItems,
                            onChanged: changedDropDownItem,
                          ),
                          Text('Escribe una breve reseña'),
                          TextFormField(
                            controller: controllerCode,
                            maxLines: 5,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Este campo no puede estar vacío';
                              } else if (value.length <= 3) {
                                return 'Requiere minimi 5 letras';
                              }
                              return null;
                            },
                          ),
                        ],
                      )),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    new FlatButton(
                      child: new Text('Enviar'),
                      onPressed: () {
                        getInfofb(result, _displayValue, _currentCity);
                        showResena();

                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
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

  void getInfofb(
      FacebookLoginResult result, _displayValue, _currentCity) async {
    //final result = await facebookSignIn.logInWithReadPermissions(['email']);
    final token = result.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,picture,email&access_token=${token}');
    final profile = json.decode(graphResponse.body);
    print(
      profile['email'],
    );
    print(
      profile['last_name'],
    );
//final pictures= profile[ 'picture']["data"]["url"];
    final id = profile['id'];
    final correofb = profile['email'];
    final nombresfb = profile['first_name'];
    final apellidosfb = profile['last_name'];
    final imagenfb = profile['picture']["data"]["url"];
    final resena = controllerCode.text;
    final valor = _currentCity;

//final imagenfb = profile['picture'];
//final url =  dataneg[0]["NEG_WEB"];
    var response = await http.get(
        Uri.encodeFull(
            'http://cabofind.com.mx/app_php/APIs/esp/insertar_resena.php?ID_FB=${id}&CORREO=${correofb}&NOM=${nombresfb}&APE=${apellidosfb}&FOTO=${imagenfb}&IDIOMA=ESP&RESENA=${resena}&VALOR=${valor}&ID_N=${widget.empresa.id_nm}'),
        headers: {"Accept": "application/json"});
  }

  Widget build(BuildContext context) {
/*
_mapa() async {
      
final url =  dataneg[index]["NEG_MAP_IOS"];
      if (await canLaunch(url)) {
        await launch(url,forceSafariVC: false);
      } else {
        throw 'Could not launch $url';
      }
        
    }*/

    _alertCar(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Caracteristicas',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              content: Container(
                  width: double.maxFinite,
                  height: 300.0,
                  child: ListView.builder(
                      itemCount: data == null ? 0 : data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                data[index]["CAR_NOMBRE"],
                                style: TextStyle(),
                              ),
                              padding: EdgeInsets.only(bottom: 15.0),
                            ),
                          ],
                        );
                      })),
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

    _alertSer(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Servicios',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              content: Container(
                  width: double.maxFinite,
                  height: 300.0,
                  child: ListView.builder(
                      itemCount: data_serv == null ? 0 : data_serv.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                data_serv[index]["SERV_NOMBRE"],
                                style: TextStyle(),
                              ),
                              padding: EdgeInsets.only(bottom: 15.0),
                            ),
                          ],
                        );
                      })),
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

/*
   _mapa() async {
      if (Platform.isIOS) {
        final url =  dataneg[1]["NEG_MAP_IOS"];
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
*/

    Widget carrusel = Container(
      child: new CarouselSlider.builder(
        autoPlay: true,
        height: 500.0,
        aspectRatio: 16 / 9,
        viewportFraction: 0.9,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayCurve: Curves.fastOutSlowIn,
        itemCount: data_carrusel == null ? 0 : data_carrusel.length,
        itemBuilder: (BuildContext context, int index) => Container(
          child: FadeInImage(
            image: NetworkImage(data_carrusel[index]["GAL_FOTO"]),
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / .5,

            // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
            placeholder: AssetImage('android/assets/images/loading.gif'),
            fadeInDuration: Duration(milliseconds: 200),
          ),
        ),
      ),
    );

    Widget titleSection = Container(
      //padding: const EdgeInsets.all(20),
      height: 50.0,
      child: new ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: dataneg == null ? 0 : dataneg.length,
        itemBuilder: (BuildContext context, int index) {
          return new Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dataneg[index]["HOT_NOMBRE"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      //color: Colors.black,
                    ),
                  ),
                ],
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      dataneg[index]["EST_ESTRELLAS"],
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      " | ",
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                    Text(
                      dataneg[index]["RAN_HOTEL"],
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    Widget widgetinfo = Container(
      //padding: const EdgeInsets.all(20),
      height: 50.0,
      child: new ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: dataneg == null ? 0 : dataneg.length,
        itemBuilder: (BuildContext context, int index) {
          return new Column(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        color: Colors.black,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Icon(
                              FontAwesomeIcons.globeAmericas,
                              color: Colors.white,
                            ),
                            new Text(' Visitar sitio web',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ],
                        )),
                    // Sitioweb(dataneg: dataneg),

                    RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        color: Colors.black,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Icon(
                              FontAwesomeIcons.phoneAlt,
                              color: Colors.white,
                            ),
                            new Text(' Llamar',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    Widget textSection = Column(children: <Widget>[
      new ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: dataneg == null ? 0 : dataneg.length,
          itemBuilder: (BuildContext context, int index) {
            //padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20);
            return Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                dataneg[index]["HOT_DES"],
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            );
          })
    ]);

    Widget caracteristicas_desc = Column(children: <Widget>[
      new ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: data_car == null ? 0 : data_car.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: const EdgeInsets.all(10),
                child: ExpandablePanel(
                  header: Text(
                    'Características de la habitación',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      //color: Colors.black,
                    ),
                    softWrap: true,
                  ),
                  collapsed: Text(
                    "Ver características",
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Text(
                    data_car[index]["Datos"],
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ));
          })
    ]);

    Widget servicios_desc = Column(children: <Widget>[
      new ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: data_serh == null ? 0 : data_serh.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: const EdgeInsets.all(10),
                child: ExpandablePanel(
                  header: Text(
                    'Servicios del establecimiento',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      //color: Colors.black,
                    ),
                    softWrap: true,
                  ),
                  collapsed: Text(
                    "Ver Servicios",
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Text(
                    data_serh[index]["Datos2"],
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ));
          })
    ]);

    Widget tipo_hab = Column(children: <Widget>[
      new ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: data_hab == null ? 0 : data_hab.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: const EdgeInsets.all(10),
                child: ExpandablePanel(
                  header: Text(
                    'Tipo de habitaciones',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      //color: Colors.black,
                    ),
                    softWrap: true,
                  ),
                  collapsed: Text(
                    "Ver Habitaciones",
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Text(
                    data_hab[index]["Datos"],
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ));
          })
    ]);

    Widget logo = Column(children: <Widget>[
      new ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: dataneg == null ? 0 : dataneg.length,
          itemBuilder: (BuildContext context, int index) {
            return new FadeInImage(
              image: NetworkImage(dataneg[index]["GAL_FOTO"]),
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
              height: 230,

              // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
              placeholder: AssetImage('android/assets/images/loading.gif'),
              fadeInDuration: Duration(milliseconds: 200),
            );
          })
    ]);

    Widget buttonSection() {
      return new ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: dataneg == null ? 0 : dataneg.length,
          itemBuilder: (BuildContext context, int index) {
            mapa() async {
              final url = dataneg[index]["NEG_MAP_IOS"];

              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            }

            return new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      child: Icon(FontAwesomeIcons.feather),
                      onPressed: () => _alertCar(context),
                      backgroundColor: Colors.black,
                      heroTag: "bt1",
                      elevation: 0.0,
                    ),
                    Flexible(
                        child: Text(
                      'Servicios propiedad',
                      style: TextStyle(color: Colors.black),
                    )),
                  ],
                ),
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      child: Icon(FontAwesomeIcons.conciergeBell),
                      onPressed: () => _alertSer(context),
                      backgroundColor: Colors.black,
                      heroTag: "bt2",
                      elevation: 0.0,
                    ),
                    Text(
                      'Caracteristicas ',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      child: Icon(FontAwesomeIcons.mapMarkerAlt),
                      onPressed: mapa,
                      backgroundColor: Colors.black,
                      heroTag: "bt4",
                      elevation: 0.0,
                    ),
                    Text(
                      'Abrir mapa',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            );
          });
    }

    Widget ubersection = Column(children: <Widget>[
      new ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: dataneg == null ? 0 : dataneg.length,
          itemBuilder: (BuildContext context, int index) {
//uber://?action=setPickup&client_id=5qCx0VeV1YF9ME3qt2kllkbLbp0hfIdq&pickup=my_location&dropoff[formatted_address]=Cabo%20San%20Lucas%2C%20Baja%20California%20Sur%2C%20M%C3%A9xico&dropoff[latitude]=22.890533&dropoff[longitude]=-109.916737

            _uber() async {
              final lat = dataneg[index]["NEG_MAP_LAT"];
              final long = dataneg[index]["NEG_MAP_LONG"];
              final String url1 =
                  "uber://?action=setPickup&client_id=5qCx0VeV1YF9ME3qt2kllkbLbp0hfIdq&pickup=my_location&dropoff[formatted_address]=Cabo%20San%20Lucas%2C%20Baja%20California%20Sur%2C%20M%C3%A9xico&dropoff[latitude]=$lat&dropoff[longitude]=$long";

              final url = url1;
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            }

            String latc = dataneg[0]["NEG_MAP_LAT"];
            String resv = dataneg[0]["NEG_RESERVA"];
            return new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (latc != null)
                  RaisedButton(
                      onPressed: () {
                        _uber();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                      color: Colors.black,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text('Solicitar Uber',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          new Icon(
                            FontAwesomeIcons.uber,
                            color: Colors.white,
                          )
                        ],
                      )),
                if (resv == 'TRUE')
                  RaisedButton(
                      onPressed: () {
                        String tipo_r = dataneg[0]["CAT_NOMBRE"];
                        String tipo_n = dataneg[0]["SUB_NOMBRE"];
                        String nombre = dataneg[0]["NEG_NOMBRE"];
                        String id_negocio = dataneg[0]["ID_NEGOCIO"];
                        String correo = dataneg[0]["NEG_CORREO"];
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new Reservacion(
                                        reserva: new Reserva(tipo_r, tipo_n,
                                            nombre, id_negocio, correo))));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                      color: Colors.black,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text('Reservar ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          new Icon(
                            FontAwesomeIcons.calendarAlt,
                            color: Colors.white,
                          )
                        ],
                      )),
              ],
            );
          }),
    ]);

    Widget resenasection = Column(children: <Widget>[
      new ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: data_resena == null ? 0 : data_resena.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Column(
                    children: <Widget>[
                      Image.network(data_resena[index]["COM_FOTO"],
                          width: 50, height: 50, fit: BoxFit.fill),
                      Text(
                        data_resena[index]["COM_NOMBRES"],
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
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
                        child: FloatingActionButton(
                          child: Icon(FontAwesomeIcons.timesCircle),
                          onPressed: () {
                            insert_reporte();
                            reporte();
                          },
                          backgroundColor: Colors.red,
                          heroTag: "bt1",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    ]);

    Widget social() {
      return Container(
          //padding: const EdgeInsets.all(20),

          height: 60.0,
          child: new ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: dataneg == null ? 0 : dataneg.length,
              itemBuilder: (BuildContext context, int index) {
                facebook() async {
                  final url = dataneg[index]["HOT_FACEBOOK"];
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }

                web() async {
                  final url = dataneg[index]["HOT_TRIPADVISOR"];
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }

                instagram() async {
                  final url = dataneg[index]["HOT_INSTAGRAM"];
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }

                telefono() async {
                  final url = "tel:${dataneg[index]["NEG_TEL"]}";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }

                correo() async {
                  if (await canLaunch(
                      "mailto:${dataneg[index]["HOT_CORREO"]}")) {
                    await launch("mailto:${dataneg[index]["HOT_CORREO"]}");
                  } else {
                    throw 'Could not launch';
                  }
                }

                return new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(width: 30),
                    FloatingActionButton(
                      child: Icon(FontAwesomeIcons.instagram),
                      onPressed: instagram,
                      backgroundColor: Colors.black,
                      heroTag: "bt1",
                      elevation: 0.0,
                    ),
                    Expanded(
                        child: SizedBox(
                      width: 5.0,
                    )),
                    FloatingActionButton(
                      child: Icon(FontAwesomeIcons.facebook),
                      onPressed: facebook,
                      backgroundColor: Colors.black,
                      heroTag: "bt2",
                      elevation: 0.0,
                    ),
                    Expanded(
                        child: SizedBox(
                      width: 5.0,
                    )),
                    FloatingActionButton(
                      child: Icon(FontAwesomeIcons.tripadvisor),
                      onPressed: web,
                      backgroundColor: Colors.black,
                      heroTag: "bt3",
                      elevation: 0.0,
                    ),
                    Expanded(
                        child: SizedBox(
                      width: 5.0,
                    )),
                    FloatingActionButton(
                      child: Icon(FontAwesomeIcons.envelope),
                      onPressed: correo,
                      backgroundColor: Colors.black,
                      heroTag: "bt5",
                      elevation: 0.0,
                    ),
                    Expanded(
                        child: SizedBox(
                      width: 5.0,
                    )),
                  ],
                );
              }));
    }

    Widget publicaciones = ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: data_list == null ? 0 : data_list.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: new Card(
            elevation: 5.0,
            child: new Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black)),
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Padding(
                      child: Text(
                        data_list[index]["PUB_TITULO"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      padding: EdgeInsets.all(1.0)),
                  FadeInImage(
                    image: NetworkImage(data_list[index]["GAL_FOTO"]),
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,

                    // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                    placeholder:
                        AssetImage('android/assets/images/loading.gif'),
                    fadeInDuration: Duration(milliseconds: 200),
                  ),
                  Row(children: <Widget>[
                    Padding(
                        child: Text(data_list[index]["CAT_NOMBRE"]),
                        padding: EdgeInsets.all(1.0)),
                    Text(" | "),
                    Padding(
                        child: new Text(data_list[index]["NEG_NOMBRE"]),
                        padding: EdgeInsets.all(1.0)),
                    Text(" | "),
                    Flexible(
                      child: new Text(
                        data_list[index]["NEG_LUGAR"],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),

          onTap: () {
            String id_n = data_list[index]["ID_NEGOCIO"];
            String id_p = data_list[index]["ID_PUBLICACION"];

            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Publicacion_detalle_fin_estatica(
                          publicacion: new Publicacion(id_n, id_p),
                        )));
          },
          //A Navigator is a widget that manages a set of child widgets with
          //stack discipline.It allows us navigate pages.
          //stack discipline.It allows us navigate pages.
          //Navigator.of(context).push(route);
        );
      },
    );

    return new Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
              expandedHeight: 230.0,
              floating: false,
              pinned: true,
              title: SABT(
                  child: Text(
                'testing',
                style: TextStyle(fontSize: 18),
              )),
              //title: Text(dataneg[0]["HOT_NOMBRE"],style: TextStyle(fontSize: 18),),
              automaticallyImplyLeading: true,
              flexibleSpace: FlexibleSpaceBar(
                //titlePadding: EdgeInsets.all(10.0),
                background: GestureDetector(
                  onTap: () {},
                  child: FutureBuilder(
                      future: getPortada(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          default:
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                "Error :(",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25.0),
                                textAlign: TextAlign.center,
                              ));
                            } else {
                              String _portada = snapshot.data["POR_FOTO"];
                              // String _matricula = snapshot.data["INT_MATRICULA"];
                              return CarouselSlider.builder(
                                autoPlay: true,
                                height: 250.0,
                                //aspectRatio: 16/9,
                                viewportFraction: 1.0,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayCurve: Curves.fastOutSlowIn,

                                itemCount: data_carrusel == null
                                    ? 0
                                    : data_carrusel.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        Container(
                                  child: FadeInImage(
                                    image: NetworkImage(
                                        data_carrusel[index]["GAL_FOTO"]),
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,

                                    // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                                    placeholder: AssetImage(
                                        'android/assets/images/loading.gif'),
                                    fadeInDuration: Duration(milliseconds: 200),
                                  ),
                                ),
                              );
                            }
                        }
                      }),
                ),
              ))
        ];
      },
      body: ListView(
        //shrinkWrap: true,
        //physics: BouncingScrollPhysics(),

        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              titleSection,
              widgetinfo,
              textSection,
              Divider(
                color: Colors.black,
                thickness: 3,
              ),
              Text(
                ' Información',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Divider(),
              caracteristicas_desc,
              Divider(),
              servicios_desc,
              Divider(),
              tipo_hab,
              Divider(),

              //buttonSection(),
              SizedBox(
                height: 10.0,
              ),
              //ubersection,
            ],
          ),
          Container(
              child: Column(
            children: <Widget>[
              SizedBox(
                height: 15.0,
              ),
              Center(
                  child: Text(
                'Redes sociales y contacto',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              )),
              SizedBox(
                height: 15.0,
              ),
              social(),
            ],
          )),
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                // Center(child: Text('Publicaciones',style: TextStyle(fontSize: 20.0,color: Colors.black ),)),
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
              // Center(child: Text('Reseñas',style: TextStyle(fontSize: 20.0,color: Colors.black ),)),
              SizedBox(
                height: 15.0,
              ),
            ],
          )),
          resenasection,
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    ));
  }
}
/*
class Sitioweb extends StatelessWidget {
  const Sitioweb({
    Key key,
    @required this.dataneg,
  }) : super(key: key);

  final List dataneg;

  @override
  Widget build(BuildContext context) {
    return Text(

      dataneg[index]["EST_ESTRELLAS"],
      style: TextStyle(
     fontSize: 20
    ),
      
    );
  }
}*/
