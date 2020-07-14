import 'dart:async';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mi_direccion extends StatefulWidget {
  @override
  _Mi_direccionState createState() => _Mi_direccionState();
}

class _Mi_direccionState extends State<Mi_direccion> {
  final _formKey = GlobalKey<FormState>();
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
        .getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.best);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    //  await Geocoder.local.findAddressesFromQuery('22.914517');

    print(addresses.first.locality); //ciudad
    print(addresses.first.addressLine); //calle,colonia y cp
    print(addresses.first.postalCode); //CP
    print(addresses.first.adminArea); //ESTADO
    // print(addresses.getRange(1, 3).first.addressLine);
    //print(addresses.single.adminArea);

    var cp2 = addresses.first.postalCode; //= cp
    var calle2 = addresses.getRange(1, 2).first.addressLine; //= calle.
    var ciudad2 = addresses.first.locality; //= ciudad
    var col2 = addresses.first.subLocality; //= colonia

    //print(first.addressLine.); //colonia
    setState(() {
      //cp2 = cp.text;
      cp = new TextEditingController(text: cp2);
      calle = new TextEditingController(text: calle2);
      colonia = new TextEditingController(text: col2);
      ciudad = new TextEditingController(text: ciudad2);
    });

    //print("${first.featureName} : ${first.addressLine}");
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
      print(currentLocation);
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
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: RaisedButton(
        onPressed: () {
          final nombre1 = calle.text;
          final numero1 = ciudad.text;
          final correo1 = cp.text;
          if (_formKey.currentState.validate()) {}
        },
        color: Color(0xff01969a),
        textColor: Colors.white,
        child: Text('Confirmar dirección'),
      ),
      appBar: AppBar(
        title: Text('Regresar'),
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              /* Container(
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
              )*/
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
                          readOnly: true,
                          controller: cp,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          enabled: true,
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
                              hintText: 'Apartamento/Hotel/Empresa'),
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
    );
  }
}
