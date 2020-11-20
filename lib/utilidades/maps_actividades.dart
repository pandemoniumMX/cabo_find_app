import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:location/location.dart' as LocationManager;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'classes.dart';

//void main() => runApp(Maps());

class Maps_actividades extends StatefulWidget {
  Maps_actividades({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Maps_actividades> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.900890, -109.942955),
    zoom: 13.0,
  );
  List data;
  String _mapStyle;

  Iterable markers = [];
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _mapController;

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    if (mounted)
      setState(() {
        _mapController = controller;
        controller.setMapStyle(_mapStyle);
      });
  }

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style1.txt').then((string) {
      _mapStyle = string;
    });
    getData();
    this.getCar();
    _currentLocation();
  }

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('stringLenguage');
    prefs.getString('stringCity');
    String _city = prefs.getString('stringCity');
    try {
      final response = await http.get(
          'http://cabofind.com.mx/app_php/consultas_negocios/esp/mapas/actividades.php?CITY=$_city');

      final int statusCode = response.statusCode;

      if (statusCode == 201 || statusCode == 200) {
        List responseBody = json.decode(response.body);
        //List results = responseBody["results"];

        Iterable _markers = Iterable.generate(
            responseBody == null ? 0 : responseBody.length, (index) {
          String lat = responseBody[index]["NEG_MAP_LAT"];
          String long = responseBody[index]["NEG_MAP_LONG"];
          String nom = responseBody[index]["NEG_NOMBRE"];
          String sub = responseBody[index]["SUB_NOMBRE"];
          String id_sql = responseBody[index]["ID_NEGOCIO"];
          String icon = responseBody[index]["SUB_ICONO"];

          var lat1 = double.parse(lat);
          var long1 = double.parse(long);
          //Map result = results[index];
          //Map location = result["geometry"]["location"];
          //LatLng latLngMarker = LatLng(result["lat"], result["lng"]);
          LatLng latLngMarker = LatLng(lat1, long1);
          // print(lat);
          return Marker(
              markerId: MarkerId("marker$index"),
              icon: BitmapDescriptor.fromAsset(icon),
              position: latLngMarker,
              infoWindow: InfoWindow(
                  title: nom,
                  snippet: sub,
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Empresa_det_fin(
                                empresa: new Empresa(id_sql))));
                  }),
              onTap: () {});
        });

        setState(() {
          markers = _markers;
        });
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getCar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('stringLenguage');
    prefs.getString('stringCity');
    String _city = prefs.getString('stringCity');
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/mapas/actividades.php?CITY=$_city"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
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
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: false,
            markers: Set.from(
              markers,
            ),
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
          ),
          Container(
            height: 180,
            width: 150,
            child: Card(
              color: const Color(0xFFFFFF).withOpacity(0.8),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      FadeInImage(
                        image: ExactAssetImage('assets/ship.png'),
                        fit: BoxFit.cover,
                        width: 25,
                        height: 25,
                        // placeholder: AssetImage('android/assets/images/loading.gif'),
                        placeholder:
                            AssetImage('android/assets/images/loading.gif'),
                        fadeInDuration: Duration(milliseconds: 200),
                      ),
                      Text('  Acuáticas')
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      FadeInImage(
                        image: ExactAssetImage('assets/bike.png'),
                        fit: BoxFit.cover,
                        width: 25,
                        height: 25,
                        // placeholder: AssetImage('android/assets/images/loading.gif'),
                        placeholder:
                            AssetImage('android/assets/images/loading.gif'),
                        fadeInDuration: Duration(milliseconds: 200),
                      ),
                      Text('  Terrestres')
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      FadeInImage(
                        image: ExactAssetImage('assets/parachutist.png'),
                        fit: BoxFit.cover,
                        width: 25,
                        height: 25,
                        // placeholder: AssetImage('android/assets/images/loading.gif'),
                        placeholder:
                            AssetImage('android/assets/images/loading.gif'),
                        fadeInDuration: Duration(milliseconds: 200),
                      ),
                      Text('  Aéreas')
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      FadeInImage(
                        image: ExactAssetImage('assets/museum.png'),
                        fit: BoxFit.cover,
                        width: 25,
                        height: 25,
                        // placeholder: AssetImage('android/assets/images/loading.gif'),
                        placeholder:
                            AssetImage('android/assets/images/loading.gif'),
                        fadeInDuration: Duration(milliseconds: 200),
                      ),
                      Text('  Sitios')
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      FadeInImage(
                        image: ExactAssetImage('assets/beach.png'),
                        fit: BoxFit.cover,
                        width: 25,
                        height: 25,
                        // placeholder: AssetImage('android/assets/images/loading.gif'),
                        placeholder:
                            AssetImage('android/assets/images/loading.gif'),
                        fadeInDuration: Duration(milliseconds: 200),
                      ),
                      Text('  Playas')
                    ],
                  ),
                ],
              ),
            ),
          ),
          _buildContainer(),
        ],
      ),
    );
  }

  Future<void> _gotoLocation(String lat, String long) async {
    var lat1 = double.parse(lat);
    var long1 = double.parse(long);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat1, long1),
      zoom: 30,
      tilt: 40.0,
      bearing: 45.0,
    )));
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.0),
        height: 160.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  SizedBox(width: 15.0),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: _boxes(
                      data[index]["GAL_FOTO"],
                      data[index]["NEG_MAP_LAT"],
                      data[index]["NEG_MAP_LONG"],
                      data[index]["NEG_NOMBRE"],
                      data[index]["CAT_NOMBRE"],
                      data[index]["SUB_NOMBRE"],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget _boxes(String _image, String lat, String long, String restaurantName,
      String catnom, String subnom) {
    //var lat1 = double.parse(lat);
    //var long1 = double.parse(long);
    return GestureDetector(
      onTap: () {
        var lat1 = double.parse(lat);
        var long1 = double.parse(long);
        _gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(
                          _image, lat, long, restaurantName, catnom, subnom),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String _image, String lat, String long,
      String restaurantName, String catnom, String subnom) {
    _uber() async {
      final lat1 = lat;
      final long1 = long;
      final url =
          "https://m.uber.com/ul/?action=setPickup&client_id=5qCx0VeV1YF9ME3qt2kllkbLbp0hfIdq&pickup=my_location&dropoff[formatted_address]=Cabo%20San%20Lucas%2C%20B.C.S.%2C%20M%C3%A9xico&dropoff[latitude]=$lat1&dropoff[longitude]=$long1";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            restaurantName,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Text(
              catnom,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            ))
          ],
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          subnom,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
        SizedBox(height: 5.0),
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
                new Text('Solicitar Uber ',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                new Icon(
                  FontAwesomeIcons.uber,
                  color: Colors.white,
                )
              ],
            )),
      ],
    );
  }
}
