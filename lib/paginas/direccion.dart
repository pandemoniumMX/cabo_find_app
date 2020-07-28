import 'dart:async';
import 'dart:convert';
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
  // final Ubicacion ubicacion;

  Mi_direccion({Key key}) : super(key: key);
  @override
  _Mi_direccionState createState() => _Mi_direccionState();
}

class _Mi_direccionState extends State<Mi_direccion> {
  final _formKey = GlobalKey<FormState>();
  var _miciudad2 = '';
  double latn;
  double longn;
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
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.900890, -109.942955),
    zoom: 13.0,
  );
  String _mapStyle;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _mapController;

  _getCurrentLocation() async {
    geo.Position position = await geo.Geolocator()
        .getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    print(coordinates.latitude);
    print(coordinates.longitude);

    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    //  await Geocoder.local.findAddressesFromQuery('22.914517');

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
      cp = new TextEditingController(text: cp2);
      calle = new TextEditingController(text: calle2);
      colonia = new TextEditingController(text: col2);
      ciudad = new TextEditingController(text: ciudad2);
      _miciudad2 = ciudad2;
      print(_miciudad2);
    });
  }

  Future<String> _insertDireccion(String calle, String ciudad, String celular,
      String cp, String ref, String inst) async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringMail");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/insert_direccion.php?CORREO=$_mail2&CALLE=${calle}&CIUDAD=${ciudad}&CELULAR=${celular}&CP=${cp}&REF=${ref}&INST=${inst}");
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
        backgroundColor: Color(0xffFF7864),
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
                          //  controller: cupon,
                          enabled: true,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              focusColor: Color(0xffD3D7D6),
                              hoverColor: Color(0xffD3D7D6),
                              hintText: 'Referencia/Hotel/Empresa'),
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
                          //  controller: cupon,
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
                          //  controller: cupon,
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
      bottomNavigationBar: _miciudad2 == 'Cabo San Lucas'
          ? Container(
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    String call = calle.text;
                    String ciu = ciudad.text;
                    String tel1 = tel.text;
                    String cp1 = cp.text;
                    String apa = apartamento.text;
                    String inst = instrucciones.text;
                    _insertDireccion(call, ciu, tel1, cp1, apa, inst);
                  }
                },
                color: Colors.green,
                textColor: Colors.white,
                child: Text(
                  'Confirmar dirección',
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
                  'Ciudad no disponible',
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
