import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;



class Maps extends StatefulWidget {
Publicacion publicacion;
  @override
  _Buscador createState() => _Buscador();
}

class _Buscador extends State<Maps> {
  
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 10.0,
  );

  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
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