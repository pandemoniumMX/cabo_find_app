import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  Completer<GoogleMapController> _controller = Completer();
  

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.900890, -109.942955),
    zoom: 13.0,
  );
  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List data;
  Future<String> getCar() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_maps_latlng.php"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          data = json.decode(
              response.body);
        });


    return "Success!";
  }

  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
          title: new Text( 'Mapas',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
                ),
                ),
                
                ),
                             
        
        
        endDrawer: new Drawer(


        child: ListView(
          scrollDirection: Axis.vertical,

          children: <Widget>[              
            new ListTile(
              title: new Text('Restaurantes'),
              leading: Icon(Icons.restaurant),
              
              

              onTap: () {
                
              },

            ),
            new ListTile(
              title: new Text('Vida nocturna'),
              leading: Icon(FontAwesomeIcons.glassCheers),

              onTap: () {
                
              },
            ),
            new ListTile(
              title: new Text('¿Que hacer?'),
              leading: Icon(Icons.beach_access),

              onTap: () {
               
              },
            ),
            new ListTile(
              title: new Text('Compras'),
              leading: Icon(FontAwesomeIcons.shoppingCart),

              onTap: () {
                
              },
            ),
            new ListTile(
              title: new Text('Servicios'),
              leading: Icon(Icons.build),

              onTap: () {
                
              },
            ),
            new ListTile(
              title: new Text('Salud'),
              leading: Icon(FontAwesomeIcons.heartbeat),

              onTap: () {
                
              },
            ),

            new ListTile(
              title: new Text('Educación'),
              leading: Icon(FontAwesomeIcons.graduationCap),

              onTap: () {
                
              },
            ),

            new ListTile(
              title: new Text('Acerca de nosotros'),
              leading: Icon(Icons.record_voice_over),

              onTap: () {
                Navigator.of(context).pop();
                
              },
            ),
            
          ],
        ),
      ),
      
      body: 
        GoogleMap(
        myLocationEnabled: true,
        rotateGesturesEnabled: true,
        scrollGesturesEnabled: true,
        tiltGesturesEnabled: true,
        zoomGesturesEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);

        },
        myLocationButtonEnabled: true,

      ),
      
    );
    _alertCar(BuildContext context) async {
     return ListView.builder(
                     itemCount: data == null ? 0 : data.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: <Widget>[
                           Container(child: Text(data[index]["CAR_NOMBRE"],style: TextStyle(),),padding: EdgeInsets.only(bottom:15.0),) ,
                         ],
                       );
                     }
                 );
  }
  
}}

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