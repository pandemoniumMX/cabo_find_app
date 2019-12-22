import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Maps(),
    );
  }
}

class Maps extends StatefulWidget {
Publicacion publicacion;
  @override
  _Buscador createState() => _Buscador();
}

class _Buscador extends State<Maps> {
  
  
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;
  
_getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }


  
  
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return new Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null) Text(_currentAddress),
              
            FlatButton(
              child: Text("Get location"),
              onPressed: () {
                _getCurrentLocation();
              },
            ),
          ],
=======
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: <Widget>[
          GoogleMap(  
              initialCameraPosition: CameraPosition(target: LatLng(22.8962225,-109.9680177),  
              zoom: 12.0, 
              ),
              mapType: MapType.normal,
  
            ),
],
<<<<<<< HEAD
>>>>>>> parent of 7c89907... Fix app funcionando sin mapas
=======
>>>>>>> parent of 7c89907... Fix app funcionando sin mapas
        ),
      ),
    
    );
  }

  
}
/*
class _Buscador extends State<Maps> {

  GoogleMapController mapController;

  String buscarDireccion;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
         children: <Widget>[
           GoogleMap(
             onMapCreated: onMapCreated,
             

                           initialCameraPosition:CameraPosition(target: LatLng(26.8206, 30.8025)),
                        ),
                        Positioned(
                          top: 30.0,
                          right: 15.0,
                          left: 15.0,
                          child: Container(
                            height: 50.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Ingrese Direccion a Buscar',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                                suffixIcon: IconButton(
                                  icon: IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: barraBusqueda,
                                    iconSize: 30.0,
                                  )
                                ),                                
                              ),
                              onChanged: (val) {
                                setState(() {
                                 buscarDireccion = val; 
                                });
                              }
                            ),
                          ),
                        )
                      ],
                    ),
                 );
               }


          //Funcion que creamos para busqueda por direccion
          barraBusqueda() {
            Geolocator().placemarkFromAddress(buscarDireccion).then((result) {
              mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  target:
                      LatLng(result[0].position.latitude, result[0].position.longitude),
                  zoom: 10.0)));
            });
          }
             
               void onMapCreated(controller) {
                 setState(() {
                  mapController = controller; 
                 });
  }
}
*/