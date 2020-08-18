import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas/publicacion_detalle_estatica.dart';
import 'package:cabofind/paginas/reservacion.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_pro/carousel_pro.dart';

import 'list_manejador_menus.dart';
import 'list_manejador_recompensas.dart';

class Empresa_det_fin extends StatefulWidget {
//final Publicacion publicacion;
  final Empresa empresa;

  Empresa_det_fin({Key key, @required this.empresa}) : super(key: key);

  @override
  Detalles createState() => new Detalles();
}

class Detalles extends State<Empresa_det_fin> {
  TextEditingController controllerCode = TextEditingController();
  String _displayValue = "";

  Map userProfile;

  List _cities = ["👍", "👎"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  bool isLoggedIn = false;
  List data;
  List data_serv;
  List dataneg;
  List data_list;
  List data_carrusel;
  List data_hor;
  List logos;
  List descripcion;
  List data_resena;

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
            "http://cabofind.com.mx/app_php/APIs/esp/list_negocios_api.php?ID=${widget.empresa.id_nm}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      dataneg = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> getCar() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_caracteristicas_api.php?ID=${widget.empresa.id_nm}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
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
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.id}');
    print('Running on ${androidInfo.fingerprint}');

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insert_reporte.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=${currentLocale},&ID=${widget.empresa.id_nm}&SO=Android"),
        headers: {"Accept": "application/json"});
  }

  Future<String> getHorarios() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_horarios_api.php?ID=${widget.empresa.id_nm}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data_hor = json.decode(response.body);
    });

    return "Success!";
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
        headers: {"Accept": "application/json"});
  }

/*
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
    var response = await http.get(
        Uri.encodeFull(
           // "http://cabofind.com.mx/app_php/APIs/esp/insert_visita_negocio.php?ID=${widget.empresa.id_nm}"),
            "http://cabofind.com.mx/app_php/APIs/esp/insert_visita_negocio.php?MOD=${iosInfo.model}&BOOT=${iosInfo.utsname.nodename},${iosInfo.utsname.sysname}&VERSION=${iosInfo.systemName}&IDIOMA=esp&ID=${widget.empresa.id_nm}&SO=iOS"),
        headers: {
          "Accept": "application/json"
        }
    );
}
*/
  Future<String> getCarrusel() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/galeria_api.php?ID=${widget.empresa.id_nm}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data_carrusel = json.decode(response.body);
    });

    return "Success!";
  }

  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
    this.getCar();
    this.get_list();
    this.getSer();
    this.getCarrusel();
    this.getHorarios();
    this.getInfo();
    this.insertVisitaAndroid();
    this.getResena();

    // this.insertVisitaiOS;
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
        backgroundColor: Color(0xff773E42),
        textColor: Colors.white,
        timeInSecForIos: 1);
  }

  void reporte() {
    Fluttertoast.showToast(
        msg: "Comentario reportado",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Color(0xff773E42),
        textColor: Colors.white,
        timeInSecForIos: 1);
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

        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
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
                        TextField(
                          controller: controllerCode,
                          maxLines: 5,
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
    Widget carrusel = new CarouselSlider.builder(
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
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.5,

          // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
          placeholder: AssetImage('android/assets/images/loading.gif'),
          fadeInDuration: Duration(milliseconds: 200),
        ),
      ),
    );

    Widget titleSection = Container(
        height: 60.0,
        child: ListView.builder(
          shrinkWrap: false,
          physics: BouncingScrollPhysics(),
          itemCount: dataneg == null ? 0 : dataneg.length,
          itemBuilder: (BuildContext context, int index) {
            return new Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dataneg[0]["NEG_NOMBRE"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        dataneg[0]["CAT_NOMBRE"],
                        style: TextStyle(
                          color: Color(0xff773E42),
                        ),
                      ),
                      Text(
                        " | ",
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                      Text(
                        dataneg[0]["SUB_NOMBRE"],
                        style: TextStyle(
                          color: Color(0xff773E42),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));

    // Color color = Theme.of(context).primaryColor;

    Widget textSection = Column(
        // height:  MediaQuery.of(context).size.height,

        children: <Widget>[
          new ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: dataneg == null ? 0 : dataneg.length,
              itemBuilder: (BuildContext context, int index) {
                //padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20);
                return new Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Text(
                    dataneg[index]["NEG_DESCRIPCION"],
                    maxLines: 20,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0),
                  ),
                );
              })
        ]);

    Widget logo = Column(
        // height:  MediaQuery.of(context).size.height,

        children: <Widget>[
          new ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: dataneg == null ? 0 : dataneg.length,
              itemBuilder: (BuildContext context, int index) {
                return new FadeInImage(
                  image: NetworkImage(dataneg[index]["GAL_FOTO"]),
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,

                  // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                  placeholder: AssetImage('android/assets/images/loading.gif'),
                  fadeInDuration: Duration(milliseconds: 200),
                );
              })
        ]);

    Widget buttonSection = Column(
        //width: MediaQuery.of(context).size.width +30,

        children: <Widget>[
          new ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: dataneg == null ? 0 : dataneg.length,
              itemBuilder: (BuildContext context, int index) {
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            data[index]["CAR_NOMBRE"],
                                            style: TextStyle(),
                                          ),
                                          padding:
                                              EdgeInsets.only(bottom: 15.0),
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
                                  itemCount:
                                      data_serv == null ? 0 : data_serv.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            data_serv[index]["SERV_NOMBRE"],
                                            style: TextStyle(),
                                          ),
                                          padding:
                                              EdgeInsets.only(bottom: 15.0),
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

                _alertHorario(BuildContext context) async {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Horario',
                            style: TextStyle(
                              fontSize: 25.0,
                            ),
                          ),
                          content: Container(
                              width: double.maxFinite,
                              height: 150.0,
                              child: ListView.builder(
                                  itemCount:
                                      data_hor == null ? 0 : data_hor.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            data_hor[index]["NEG_HORARIO"],
                                            style: TextStyle(),
                                          ),
                                          padding:
                                              EdgeInsets.only(bottom: 15.0),
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

                _mapa() async {
                  final url = dataneg[index]["NEG_MAP"];
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }

                String mapac = dataneg[index]["NEG_MAP"];

                return new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: <Widget>[
                        FloatingActionButton(
                          child: Icon(FontAwesomeIcons.feather),
                          onPressed: () => _alertCar(context),
                          backgroundColor: Color(0xff773E42),
                          heroTag: "bt1",
                          elevation: 0.0,
                        ),
                        Text(
                          'Caracteristicas',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        FloatingActionButton(
                          child: Icon(FontAwesomeIcons.conciergeBell),
                          onPressed: () => _alertSer(context),
                          backgroundColor: Color(0xff773E42),
                          heroTag: "bt2",
                          elevation: 0.0,
                        ),
                        Text(
                          'Servicios',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        FloatingActionButton(
                          child: Icon(FontAwesomeIcons.clock),
                          onPressed: () => _alertHorario(context),
                          backgroundColor: Color(0xff773E42),
                          heroTag: "bt3",
                          elevation: 0.0,
                        ),
                        Text(
                          'Horarios',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        FloatingActionButton(
                          child: Icon(FontAwesomeIcons.mapMarkerAlt),
                          onPressed: _mapa,
                          backgroundColor: Color(0xff773E42),
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
              }),
        ]);

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
              final url =
                  "https://m.uber.com/ul/?action=setPickup&client_id=5qCx0VeV1YF9ME3qt2kllkbLbp0hfIdq&pickup=my_location&dropoff[formatted_address]=Cabo%20San%20Lucas%2C%20B.C.S.%2C%20M%C3%A9xico&dropoff[latitude]=$lat&dropoff[longitude]=$long";
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            }

            String latc = dataneg[0]["NEG_MAP_LAT"];
            String resv = dataneg[0]["NEG_RESERVA"];
            String recom = dataneg[0]["NEG_RECOMPENSAS"];
            String food = dataneg[0]["NEG_DOMICILIO"];
            print(recom);
            return Column(
              children: [
                new Row(
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
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
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
                          color: Color(0xff773E42),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Text('Reservar ',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              new Icon(
                                FontAwesomeIcons.calendarAlt,
                                color: Colors.white,
                              )
                            ],
                          )),
                  ],
                ),
                if (recom == 'TRUE')
                  RaisedButton(
                      onPressed: () {
                        String id_negocio = dataneg[0]["ID_NEGOCIO"];
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new Mis_promos_manejador(
                                      publicacion:
                                          new Publicacion('', id_negocio),
                                    )));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                      color: Colors.orange,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text('Recompensas ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          new Icon(
                            FontAwesomeIcons.gift,
                            color: Colors.white,
                          )
                        ],
                      )),
                if (food == 'TRUEX')
                  RaisedButton(
                      onPressed: () {
                        String id_negocio = dataneg[0]["ID_NEGOCIO"];
                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new Menu_manejador(
                                        manejador: new Users(id_negocio))));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                      color: Color(0xff60032D),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text('Cabofood ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          new Icon(
                            FontAwesomeIcons.utensilSpoon,
                            color: Colors.white,
                          )
                        ],
                      )),
              ],
            );
          }),
    ]);

    Widget resenasection = Column(

        // height:  MediaQuery.of(context).size.height,
        children: <Widget>[
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
          // width: MediaQuery.of(context).size.width, padding: const EdgeInsets.all(20),
          height: 65.0,
          child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: dataneg == null ? 0 : dataneg.length,
              itemBuilder: (BuildContext context, int index) {
                facebook() async {
                  final url = dataneg[index]["NEG_FACEBOOK"];
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }

                web() async {
                  final url = dataneg[index]["NEG_WEB"];
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }

                instagram() async {
                  final url = dataneg[index]["NEG_INSTAGRAM"];
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }

                telefono() async {
                  final tel = dataneg[index]["NEG_TEL"];
                  final url = "tel: $tel";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }

                correo() async {
                  final mail = dataneg[index]["NEG_CORREO"];
                  final url = "mailto: $mail";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }

                return new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(width: 30),
                    dataneg[index]["NEG_INSTAGRAM"] != null
                        ? FloatingActionButton(
                            child: Icon(FontAwesomeIcons.instagram),
                            onPressed: instagram,
                            backgroundColor: Color(0xff773E42),
                            heroTag: "bt1",
                            elevation: 0.0,
                          )
                        : FloatingActionButton(
                            child: Icon(FontAwesomeIcons.instagram),
                            onPressed: null,
                            backgroundColor: Colors.grey,
                            heroTag: "bt1",
                            elevation: 0.0,
                          ),
                    Expanded(
                        child: SizedBox(
                      width: 5.0,
                    )),
                    dataneg[index]["NEG_FACEBOOK"] != null
                        ? FloatingActionButton(
                            child: Icon(FontAwesomeIcons.facebook),
                            onPressed: facebook,
                            backgroundColor: Color(0xff773E42),
                            heroTag: "bt3",
                            elevation: 0.0,
                          )
                        : FloatingActionButton(
                            child: Icon(FontAwesomeIcons.facebook),
                            onPressed: null,
                            backgroundColor: Colors.grey,
                            heroTag: "bt3",
                            elevation: 0.0,
                          ),
                    Expanded(
                        child: SizedBox(
                      width: 5.0,
                    )),
                    dataneg[index]["NEG_WEB"] != null
                        ? FloatingActionButton(
                            child: Icon(FontAwesomeIcons.globeAmericas),
                            onPressed: web,
                            backgroundColor: Color(0xff773E42),
                            heroTag: "bt4",
                            elevation: 0.0,
                          )
                        : FloatingActionButton(
                            child: Icon(FontAwesomeIcons.globeAmericas),
                            onPressed: null,
                            backgroundColor: Colors.grey,
                            heroTag: "bt4",
                            elevation: 0.0,
                          ),
                    Expanded(
                        child: SizedBox(
                      width: 5.0,
                    )),
                    dataneg[index]["NEG_TEL"] != null
                        ? FloatingActionButton(
                            child: Icon(FontAwesomeIcons.phone),
                            onPressed: telefono,
                            backgroundColor: Color(0xff773E42),
                            heroTag: "bt5",
                            elevation: 0.0,
                          )
                        : FloatingActionButton(
                            child: Icon(FontAwesomeIcons.phone),
                            onPressed: null,
                            backgroundColor: Colors.grey,
                            heroTag: "bt5",
                            elevation: 0.0,
                          ),
                    Expanded(
                        child: SizedBox(
                      width: 5.0,
                    )),
                    dataneg[index]["NEG_CORREO"] != null
                        ? FloatingActionButton(
                            child: Icon(FontAwesomeIcons.envelope),
                            onPressed: correo,
                            backgroundColor: Color(0xff773E42),
                            heroTag: "bt6",
                            elevation: 0.0,
                          )
                        : FloatingActionButton(
                            child: Icon(FontAwesomeIcons.envelope),
                            onPressed: null,
                            backgroundColor: Colors.grey,
                            heroTag: "bt6",
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
                  border: Border.all(color: Color(0xff773E42))),
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Padding(
                      child: Text(
                        data_list[index]["PUB_TITULO"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff773E42),
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
        );
      },
    );

    String latc = dataneg[0]["NEG_MAP_LAT"];
    String resv = dataneg[0]["NEG_RESERVA"];

    return new Scaffold(
      body: ListView(
        //shrinkWrap: true,
        physics: BouncingScrollPhysics(),

        children: [
          Column(
            children: <Widget>[
              logo,
              SizedBox(
                height: 15.0,
              ),
              titleSection,
              textSection,
              SizedBox(
                height: 10.0,
              ),
              buttonSection,
              SizedBox(
                height: 10.0,
              ),
              ubersection
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
                'Galería de imagenes',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              )),
              SizedBox(
                height: 15.0,
              ),
            ],
          )),
          Container(
            child: carrusel,
            height: MediaQuery.of(context).size.height / 1.8,
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
                Center(
                    child: Text(
                  'Publicaciones',
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                )),
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
              Center(
                  child: Text(
                'Comentarios',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              )),
              SizedBox(
                height: 15.0,
              ),
            ],
          )),
          resenasection,
          SizedBox(
            height: 15.0,
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            child: RaisedButton(
                onPressed: () {
                  initiateFacebookLogin();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
                color: Color(0xff4267b2),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text('COMENTARIO CON FACEBOOK ',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    new Icon(
                      FontAwesomeIcons.facebookSquare,
                      color: Colors.white,
                    )
                  ],
                )),
          ),
        ],
      ),
      appBar: new AppBar(
        title: new Text('Regresar'),
      ),
    );
  }
}
