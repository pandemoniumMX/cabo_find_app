import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/preparing.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mi_direccion extends StatefulWidget {
  final Latlong ubicacion;

  Mi_direccion({Key key, this.ubicacion}) : super(key: key);
  @override
  _Mi_direccionState createState() => _Mi_direccionState();
}

class _Mi_direccionState extends State<Mi_direccion> {
  final _formKey = GlobalKey<FormState>();
  var _miciudad2 = '';
  double latn;
  double longn;
  double distanciafinal;
  TextEditingController calle = TextEditingController();
  TextEditingController colonia = TextEditingController();
  TextEditingController ciudad = TextEditingController();
  TextEditingController cp = TextEditingController();
  TextEditingController apartamento = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController instrucciones = TextEditingController();
  String _comboCiudad;
  String _currentPosition;
  String position;
  double lat;
  double long;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.900890, -109.942955),
    zoom: 13.0,
  );
  String _mapStyle;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _mapController;

  _getCurrentLocation() async {
    try {
      final geo.Geolocator geolocator = geo.Geolocator()
        ..forceAndroidLocationManager = true;
      geo.Position position = await geolocator.getLastKnownPosition(
          desiredAccuracy: geo.LocationAccuracy.best);
      final coordinates =
          new Coordinates(position.latitude, position.longitude);

      lat = coordinates.latitude;
      long = coordinates.longitude;

      http.Response response = await http.get(
          "https://maps.googleapis.com/maps/api/distancematrix/json?units=kilometer&origins=${widget.ubicacion.lat},${widget.ubicacion.long}&destinations=$lat,$long&key=AIzaSyA152PLBZLFqFlUMKQhMce3Z18OMGhPY6w");
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["rows"];
      print(data[0]['elements'][0]['distance']['text']);
      int distancia = data[0]['elements'][0]['distance']['value'];
      double subdistancia = distancia / 1000;
      print('DISTANCIA' + subdistancia.toString());

      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);

      print(addresses.first.locality); //ciudad
      print(addresses.first.addressLine); //calle,colonia y cp
      print(addresses.first.postalCode); //CP
      print(addresses.first.adminArea); //ESTADO
      // print(addresses.getRange(1, 3).first.addressLine);vo
      //print(addresses.single.adminArea);
      var cp2 = addresses.first.postalCode; //= cp
      var calle2 = addresses.getRange(1, 2).first.addressLine; //= calle.
      var ciudad2 = addresses.first.locality; //= ciudad
      var col2 = addresses.first.subLocality; //= colonia

      setState(() {
        distanciafinal = subdistancia;
        cp = new TextEditingController(text: cp2);
        calle = new TextEditingController(text: calle2);
        colonia = new TextEditingController(text: col2);
        ciudad = new TextEditingController(text: ciudad2);
        _miciudad2 = ciudad2;
        print(_miciudad2);
      });
    } on PlatformException {
      geo.Position position = null;
    }

    /*geo.Position position = await geo.Geolocator().getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.bestForNavigation);
    debugPrint('location: ${position.latitude}');
    //final coordinates = new Coordinates(position.latitude, position.longitude);*/
  }

  Future<String> _insertDireccion(String calle, String ciudad, String celular,
      String cp, String ref, String inst) async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/insert_direccion.php?IDF=$_mail2&CALLE=${calle}&CIUDAD=${ciudad}&CELULAR=${celular}&CP=${cp}&REF=${ref}&INST=${inst}&LAT=${lat}&LONG=${long}");
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    if (mounted)
      setState(() {
        _mapController = controller;
        controller.setMapStyle(_mapStyle);
      });
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
      // print(currentLocation);
    } on Exception {
      currentLocation = null;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 17.0,
      ),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
    _currentLocation();

    rootBundle.loadString('assets/map_style1.txt').then((string) {
      _mapStyle = string;
    });
  }

  @override
  void dispose() {
    calle.dispose();
    colonia.dispose();
    ciudad.dispose();
    tel.dispose();
    apartamento.dispose();
    instrucciones.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Regresar'),
        backgroundColor: Color(0xff60032D),
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  compassEnabled: false,
                  initialCameraPosition: _kGooglePlex,
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                ),
              )
            ],
          ),
          Divider(),
          Center(
            child: Text(
              'En caso de que no coincida tu ubicacion, regresa y vuelve a entrar :)',
              style: TextStyle(fontSize: 12, color: Colors.black38),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: TextFormField(
                          controller: calle,
                          enabled: true,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              focusColor: Color(0xffD3D7D6),
                              hoverColor: Color(0xffD3D7D6),
                              hintText: 'Calle'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Este campo no puede estar vacío';
                            } else if (value.length <= 14) {
                              return 'Requiere 15 dígitos';
                            }
                            return null;
                          },
                        )),
                    Icon(FontAwesomeIcons.road)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: TextFormField(
                          controller: ciudad,
                          enabled: false,
                          readOnly: true,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              focusColor: Color(0xffD3D7D6),
                              hoverColor: Color(0xffD3D7D6),
                              hintText: 'Ciudad'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Este campo no puede estar vacío';
                            } else if (value.length <= 4) {
                              return 'Requiere 5 dígitos';
                            }
                            return null;
                          },
                        )),
                    Icon(FontAwesomeIcons.city)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: TextFormField(
                          controller: cp,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              focusColor: Color(0xffD3D7D6),
                              hoverColor: Color(0xffD3D7D6),
                              hintText: 'Código Postal'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Este campo no puede estar vacío';
                            } else if (value.length <= 4) {
                              return 'Requiere 5 dígitos';
                            }
                            return null;
                          },
                        )),
                    Icon(FontAwesomeIcons.envelope)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: TextFormField(
                          controller: apartamento,
                          enabled: true,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              focusColor: Color(0xffD3D7D6),
                              hoverColor: Color(0xffD3D7D6),
                              hintText: 'Referencia/Casa/Hotel/Empresa'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Este campo no puede estar vacío';
                            } else if (value.length <= 3) {
                              return 'Requiere 4 dígitos';
                            }
                            return null;
                          },
                        )),
                    Icon(FontAwesomeIcons.building)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: TextFormField(
                          controller: tel,
                          enabled: true,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              focusColor: Color(0xffD3D7D6),
                              hoverColor: Color(0xffD3D7D6),
                              hintText: 'Número telefónico'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Este campo no puede estar vacío';
                            } else if (value.length <= 9) {
                              return 'Requiere 10 dígitos';
                            }
                            return null;
                          },
                        )),
                    Icon(FontAwesomeIcons.mobileAlt)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: TextField(
                          controller: instrucciones,
                          enabled: true,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            focusColor: Color(0xffD3D7D6),
                            hoverColor: Color(0xffD3D7D6),
                            hintText: 'Instrucciones de entrega',
                          ),
                        )),
                    Icon(FontAwesomeIcons.shippingFast)
                  ],
                )
              ],
            ),
          ),
          Divider()
        ],
      ),
      bottomNavigationBar: distanciafinal <= 8.0
          ? Container(
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  String call = calle.text;
                  String ciu = ciudad.text;
                  String tel1 = tel.text;
                  String cp1 = cp.text;
                  String apa = apartamento.text;
                  String inst = instrucciones.text;
                  print(inst);
                  if (_formKey.currentState.validate()) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          title: new Text("Alerta"),
                          content: new Text(
                            "¿Los datos son correctos?",
                            textAlign: TextAlign.center,
                          ),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            new FlatButton(
                              child: new Text(
                                "Cerrar",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            new FlatButton(
                              child: new Text(
                                "Confirmar",
                                style: TextStyle(color: Color(0xff773E42)),
                              ),
                              onPressed: () {
                                _insertDireccion(
                                    call, ciu, tel1, cp1, apa, inst);
                                setState(() {});
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new Preparing(
                                              negocio:
                                                  Users(widget.ubicacion.idn),
                                            )));
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                color: Color(0xff773E42),
                textColor: Colors.white,
                child: Text(
                  'Guardar dirección',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          : Container(
              height: 50,
              child: RaisedButton(
                onPressed: null,
                color: Colors.grey,
                textColor: Colors.white,
                child: Text(
                  'Distancia demasiado lejana :(',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
    );
  }
}

class Element {
  final String text;
  final String value;

  Element.fromJson(dynamic json)
      : text = json['text'] as String,
        value = json['value'] as String;

  @override
  String toString() => 'text: $text\nvalue: $value';
}
