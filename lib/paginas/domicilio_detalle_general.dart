import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cabofind/main_ing.dart';
import 'package:cabofind/main_lista.dart';
import 'package:cabofind/notificaciones/push_publicacion_android.dart';
import 'package:cabofind/paginas/anuncios.dart';
//import 'package:cabofind/notificaciones/push_publicacion_android.dart';
import 'package:cabofind/paginas/descubre.dart';
import 'package:cabofind/paginas/educacion.dart';
import 'package:cabofind/paginas/maps.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas/publicacion_detalle_estatica.dart';
import 'package:cabofind/paginas/publicaciones.dart';
//import 'package:cabofind/paginas/publicacion_detalle_push.dart';
import 'package:cabofind/paginas/salud.dart';
import 'package:cabofind/paginas_ing/promociones.dart';
import 'package:cabofind/paginas_listas/list_eventos_grid.dart';
import 'package:cabofind/paginas_listas/list_promociones.dart';
import 'package:cabofind/paginas_listas/list_publicaciones_grid.dart';
import 'package:cabofind/paginas_listas/list_recomendado_grid.dart';
import 'package:cabofind/paginas_listas/list_visitado.dart';
import 'package:cabofind/paginas_listas/list_visitado_grid.dart';
import 'package:cabofind/paginas_listas_ing/list_publicaciones.dart' as prefix0;
import 'package:cabofind/utilidades/banderasicon_icons.dart' as banderax;
import 'package:cabofind/utilidades/buscador.dart';
import 'package:cabofind/utilidades/buscador_2.dart';

import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/paginas_listas/list_publicaciones.dart';
import 'package:cabofind/utilidades/calculadora.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:cabofind/utilidades/notificaciones.dart';
import 'package:cabofind/utilidades/rutas.dart';
import 'package:cabofind/weather/weather/weather_builder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cabofind/paginas/acercade.dart';
import 'package:cabofind/paginas/restaurantes.dart';
import 'package:cabofind/paginas/vida_nocturna.dart';
import 'package:cabofind/paginas/servicios.dart';
import 'package:cabofind/paginas/compras.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:geocoder/geocoder.dart';
//import 'package:geolocator/geolocator.dart';



FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void fcmSubscribe() {
  _firebaseMessaging.unsubscribeFromTopic('All');
    _firebaseMessaging.subscribeToTopic('Todos');
  }
  

//void main() => runApp(new Myapp());

class Myapp extends StatelessWidget {
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
        debugShowCheckedModeBanner:false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xff01969a),
          //primaryColor: Colors.blue,
          accentColor: Colors.black26,
        ),
        
        home: new Container(
            child:           new Domicilio_general()
        )



    );
  }
}



class Domicilio_general extends StatefulWidget {
  final Empresa empresa;
  @override

  Domicilio_general({Key key, @required this.empresa}) : super(
    key: key);
  _MyHomePageState createState() => new _MyHomePageState();


}



class _MyHomePageState extends State<Domicilio_general> {
  Completer<GoogleMapController> _controller = Completer();

  TextEditingController pedido =  TextEditingController();
  TextEditingController nombre =  TextEditingController();
  TextEditingController numero =  TextEditingController();

  String _displayValue = "";



  

   Map userProfile;

 List _cities  =
  ["👍", "👎"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  bool isLoggedIn=false;
  List data;
  List data_serv;
  List dataneg;
  List data_list;
  List data_carrusel;
  List data_hor;
  List logos;
  List descripcion;
  List data_resena;

void getLocation(ubicacion) async {
   
 
        }


Future<String> getPedido(pedido, nombre, numero) async {
  LocationData currentLocation;
   var location = new Location();
   try {
     currentLocation = await location.getLocation();
     print(currentLocation);
     } on Exception {
       currentLocation = null;
       }
      

    print(currentLocation.latitude);
    print(currentLocation.longitude);
    if (currentLocation != null){

final _latitud = currentLocation.latitude;
final _longitud = currentLocation.longitude;


final _ubicacion = "https://maps.apple.com/?q=$_latitud,$_longitud";
  
final _pedido = pedido.text;
final _nombre = nombre.text;
final _numero = numero.text;
final _servicio = dataneg[0]["NEG_ETIQUETAS"];

var response = await http.get(
        Uri.encodeFull(
        'http://cabofind.com.mx/app_php/APIs/esp/insert_pedido.php?NOM=${_nombre}&NUM=${_numero}&PEDIDO=${_pedido}&TIPO=${_servicio}'),

        headers: {
          "Accept": "application/json"
        }
    ); 
var whatsappUrl ="whatsapp://send?phone=526242353535,text=Servicio 'Ahí Voy Cabo' con Cabofind, tipo de servicio 'Comida' a nombre de: $_nombre, detalle del pedido: $_pedido. enviar a la siguiente ubicación: $_ubicacion  ";
await canLaunch(whatsappUrl)? launch(whatsappUrl):print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
//
//await FlutterOpenWhatsapp.sendSingleMessage("526242353535","Servicio 'Ahí Voy Cabo' con Cabofind, tipo de servicio 'Comida' a nombre de: $_nombre, detalle del pedido: $_pedido. enviar a la siguiente ubicación: $_ubicacion  ");

 
    }
        }



  Future<String> getInfo() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_domicilio.php?ID=${widget.empresa.id_nm}"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          dataneg = json.decode(
              response.body);
        });


    return "Success!";
  }

  
 

  Future<String> getCar() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_caracteristicas_api.php?ID=${widget.empresa.id_nm}"),

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


  Future<String> getSer() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_servicios_api.php?ID=${widget.empresa.id_nm}"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
              data_serv = json.decode(
              response.body);
        });


    return "Success!";
  }



  Future<String> getHorarios() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_horarios_api.php?ID=${widget.empresa.id_nm}"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
              data_hor = json.decode(
              response.body);
        });


    return "Success!";
  }


  
//contador de visitas android


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

        headers: {
          "Accept": "application/json"
        }
    );
    this.setState(
            () {
          data_carrusel = json.decode(
              response.body);
        });
    return "Success!";
  }
  
  



  void initState() {
     
   
    super.initState();
    this.getCar();
    this.getSer();
    this.getCarrusel();
    this.getHorarios();
    this.getInfo();   
    //this.getLocation(context);
    //this._currentLocation();
   
  
   // this.insertVisitaiOS;

  }


  
void onLoginStatusChange(bool isLoggedIn){
  setState(() {
   this.isLoggedIn=isLoggedIn; 
   
  });
}

void showResena() {
      Fluttertoast.showToast(
          msg: "Pedido enviado exitosamente",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          timeInSecForIos: 1);
    }

 

      @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    pedido.dispose();
    nombre.dispose();
    super.dispose();
  }

void hacerpedido() async{
      bool _hasInputError = false;
      final _formKey = GlobalKey<FormState>();

    return showDialog(
         context: context,
         builder: (context) {
           return Form(
             key:_formKey ,
              child: AlertDialog(
               title: Text('HACER PEDIDO',style: TextStyle(fontSize: 25.0,),),
               content: Container(
                   width: MediaQuery.of(context).size.width,
                   height:MediaQuery.of(context).size.height / 2,
                   child:Column(
                children: <Widget>[ 
                //Text('TU NOMBRE'),
                TextFormField(    
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Este campo no puede estar vacío';
                    } else if (value.length <=3) {
                      return 'Requiere minimi 4 letras';

                    }
                    return null;
                  },           
                  decoration: new InputDecoration(
                          labelText: "TU NOMBRE",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                            ),
                          ),
                          //fillColor: Colors.green
                        ),           
                  keyboardType: TextInputType.text, 
                  controller: nombre,
                  maxLines: 1, 
                  ),
                  SizedBox(height:10.0), 
                  TextFormField(    
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Este campo no puede estar vacío';
                    } else if (value.length <=9) {
                      return 'Requiere 10 dígitos';

                    }
                    return null;
                  },            
                  decoration: new InputDecoration(
                          labelText: "TU CELULAR",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                            ),
                          ),
                          //fillColor: Colors.green
                        ),   
                  keyboardType: TextInputType.phone,    
                  inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly], 
                     
                  controller: numero,
                  maxLines: 1, 
                  ),   
                SizedBox(height:10.0),
                Expanded(
                    child: TextFormField(   
                    validator: (value) {
                    if (value.isEmpty) {
                      return 'Este campo no puede estar vacío';
                    } else if (value.length <=14) {
                      return 'Requiere minimo 15 letras';

                    }
                    return null;
                  },             
                    controller: pedido,
                    maxLines: 10, 
                    decoration: new InputDecoration(
                            labelText: "DESCRIBIR TU PEDIDO",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(
                              ),
                            ),
                            //fillColor: Colors.green
                          ),
                         
                    ),
                ),
                 
                  ],
                   )
                   
               ),
               actions: <Widget>[
                 new FlatButton(
                   child: new Text('Cancelar'),
                   onPressed: () {
                     Navigator.of(context).pop();
                   },
                 ),
                 new FlatButton(
                   child: new Text('Enviar'),
                   onPressed: (){ 
                     if (_formKey.currentState.validate()) {

                     getPedido(pedido,nombre, numero);                      
                     showResena();                    
                     Navigator.of(context).pop();                    
                  }
                   
                   },
                 )
               ],
             ),
           );
         });}


 Widget build(BuildContext context){


   
      
 Widget carrusel =   new CarouselSlider.builder(      
 autoPlay: true,
 height: 500.0,
 aspectRatio: 16/9,
 viewportFraction: 0.9,
 autoPlayInterval: Duration(seconds: 3),
 autoPlayCurve: Curves.fastOutSlowIn,
 itemCount: data_carrusel == null ? 0 : data_carrusel.length,
 itemBuilder: (BuildContext context, int index)  =>
   Container(
       child:FadeInImage(
 
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
 

    
    Widget titleSection = Container (
      height: 60.0,
      child: ListView.builder(
        shrinkWrap: false,
        physics: BouncingScrollPhysics(),
        itemCount: dataneg == null ? 0 : dataneg.length,
        itemBuilder: (BuildContext context, int index) {    

         return  new Column(
          children:[
            Row(
              mainAxisAlignment: 
              MainAxisAlignment.center,            
              children: [

                   Text(
                    dataneg[0]["NEG_NOMBRE"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                       //color: Colors.blue[500],
                    ),
                  ),               

              ],
            ),
         
          ],       
        );
       },
      
      )
    
    );

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
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30.0) ),
          child: Text(
          dataneg[index]["NEG_DESCRIPCION"],        
          maxLines: 20,
          softWrap: true,
          textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
        ),
      );
       }
      )
      ]
    );

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
       }
      )
      ]
    );


   Widget buttonSection = Column(
     //width: MediaQuery.of(context).size.width +30,

     children: <Widget>[
        new ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: dataneg == null ? 0 : dataneg.length,
       itemBuilder: (BuildContext context, int index) {

_alertCobertura(BuildContext context) async {
     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(             
             title: Text('Costo de cobertura nocturna',style: TextStyle(fontSize: 25.0,),),
             content: FadeInImage(

                    image: NetworkImage("http://cabofind.com.mx/assets/galeria/cobertura.png"),
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,

                    // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                    placeholder: AssetImage('android/assets/images/loading.gif'),
                    fadeInDuration: Duration(milliseconds: 200),

                  ),
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


   _alertCar(BuildContext context) async {
     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Menú',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: double.maxFinite,
                 height: 300.0,
                 child: ListView.builder(
                     itemCount: data == null ? 0 : data.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: <Widget>[
                           Container(child: Text(data[index]["CAR_NOMBRE_MENU"],style: TextStyle(fontSize: 20.0,),),padding: EdgeInsets.only(bottom:15.0),) ,
                         ],
                       );
                     }
                 )
             ),
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
             title: Text('Tiendas',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: double.maxFinite,
                 height: 300.0,
                 child: ListView.builder(
                     itemCount: data_serv == null ? 0 : data_serv.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: <Widget>[
                           Container(child: Text(data_serv[index]["SERV_NOMBRE_MENU"],style: TextStyle(fontSize: 20.0,),),padding: EdgeInsets.only(bottom:15.0),) ,
                         ],
                       );
                     }
                 )
             ),
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
             title: Text('Costos',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: double.maxFinite,
                 height: 150.0,
                 child: ListView.builder(
                     itemCount: data_hor == null ? 0 : data_hor.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: <Widget>[
                           Container(child: Text(data_hor[index]["NEG_HORARIO"],style: TextStyle(),),padding: EdgeInsets.only(bottom:15.0),) ,
                         ],
                       );
                     }
                 )
             ),
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
      final url =  dataneg[index]["NEG_MAP"];
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     } 
    }    

      String mapac =  dataneg[index]["NEG_MAP"];

      return new  Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.listUl), onPressed:() => _alertCar(context),backgroundColor:Color(0xff01969a),heroTag: "bt1",elevation: 0.0,),
             Text('Menú', style: TextStyle(color: Colors.black),),
           ],
         ),

         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.storeAlt), onPressed:() => _alertSer(context),backgroundColor:Color(0xff01969a),heroTag: "bt2",elevation: 0.0,),
             Text('Tiendas', style: TextStyle(color: Colors.black),),

           ],
         ),
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.dollarSign), onPressed:()  => _alertHorario(context),backgroundColor:Color(0xff01969a),heroTag: "bt3",elevation: 0.0,),
             Text('Costos', style: TextStyle(color: Colors.black),),

           ],
         ),
         
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.mapMarkerAlt), onPressed: () => _alertCobertura(context),backgroundColor:Color(0xff01969a),heroTag: "bt4",elevation: 0.0,),             
             Text('Ver cobertura', style: TextStyle(color: Colors.black),),

           ],
         ),
       ],
     );

       }
     ),

     
     ]
   );

Widget ubersection = Column(
     //width: MediaQuery.of(context).size.width +30,

     children: <Widget>[
        new ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: dataneg == null ? 0 : dataneg.length,
       itemBuilder: (BuildContext context, int index) {

 
    _uber() async {
      final lat = dataneg[index]["NEG_MAP_LAT"];
      final long = dataneg[index]["NEG_MAP_LONG"];
      final url = "https://m.uber.com/ul/?action=setPickup&client_id=5qCx0VeV1YF9ME3qt2kllkbLbp0hfIdq&pickup=my_location&dropoff[formatted_address]=Cabo%20San%20Lucas%2C%20B.C.S.%2C%20M%C3%A9xico&dropoff[latitude]=$lat&dropoff[longitude]=$long";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     } 
    } 

String latc = dataneg[index]["NEG_MAP_LAT"];
if (latc != null){
  return new  Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [         
                     
         
         RaisedButton(

                  onPressed: (){_uber();},  

                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
                  color: Colors.black,  
                  
                  child: new Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,

                    children: <Widget>[
                      new Text('Solicitar Uber ', style: TextStyle(fontSize: 20, color: Colors.white)), 
                      new Icon(FontAwesomeIcons.uber, color: Colors.white,)
                    ],
                  )
                  
                ),
       ],
     );
}
      

       }
     ),
     ]
   );  

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
                              width: 50,
                              height: 50,
                              fit: BoxFit.fill ),     
                      Text(   
                      data_resena[index]["COM_NOMBRES"], 
                      style: TextStyle(fontSize: 12.0,),  
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
                  child: FloatingActionButton(child: Icon(FontAwesomeIcons.timesCircle), 
                  onPressed:() { }, 
                  backgroundColor:Colors.red, heroTag: "bt1",),
                )
                ,


                
              ],
            ),             
                    ],  
                    ),     
                    );                    
  
         }
  
        ),
      ]
    );  

  Widget social() { 
    return Container (
     // width: MediaQuery.of(context).size.width,
      //padding: const EdgeInsets.all(20),
      height: 65.0,

      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: dataneg == null ? 0 : dataneg.length,
       itemBuilder: (BuildContext context, int index) {
         

    

   facebook() async {
     final url =  dataneg[index]["NEG_FACEBOOK"];
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

   web() async {
     final url =  dataneg[index]["NEG_WEB"];
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

   instagram() async {
     final url =  dataneg[index]["NEG_INSTAGRAM"];
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

   telefono() async {
     final tel = dataneg[index]["NEG_TEL"];
     final url =  "tel: $tel";
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
         FloatingActionButton(child: Icon(FontAwesomeIcons.instagram), onPressed: instagram,backgroundColor:Color(0xff01969a),heroTag: "bt1",elevation: 0.0,),
         Expanded(child: SizedBox(width: 5.0,)),
         FloatingActionButton(child: Icon(FontAwesomeIcons.facebook), onPressed: facebook,backgroundColor:Color(0xff01969a),heroTag: "bt3",elevation: 0.0,),
         Expanded(child: SizedBox(width: 5.0,)),
         FloatingActionButton(child: Icon(FontAwesomeIcons.globeAmericas), onPressed: web,backgroundColor:Color(0xff01969a),heroTag: "bt4",elevation: 0.0,),
         Expanded(child: SizedBox(width: 5.0,)),
         FloatingActionButton(child: Icon(FontAwesomeIcons.phone), onPressed: telefono,backgroundColor:Color(0xff01969a),heroTag: "bt5",elevation: 0.0,),
         Expanded(child: SizedBox(width: 5.0,)),
         FloatingActionButton(child: Icon(FontAwesomeIcons.envelope), onPressed: correo,backgroundColor:Color(0xff01969a),heroTag: "bt6",elevation: 0.0,),
         Expanded(child: SizedBox(width: 5.0,)),

         ],
         );      
      }
      )
      
      
    );
  }

    return new Scaffold(

      body: ListView(
        //shrinkWrap: true,
       physics: BouncingScrollPhysics(),

          children: [
            Column(

              children: <Widget>[
               

                logo,
                SizedBox(height: 15.0,),
                titleSection,
                textSection,
                SizedBox(height: 10.0,),

                buttonSection,
                SizedBox(height: 10.0,),
                ubersection,



              ],
            ),

            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                 Center(child: Text('Galería de imagenes',style: TextStyle(fontSize: 20.0,color: Colors.blueAccent ),)),
                  SizedBox(
                    height: 15.0,
                  ),

                ],
              )

            ),

            Container(
              child: carrusel,
              height: MediaQuery.of(context).size.height / 1.8,

            ),

            

            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 0.0,
                  ),
                 //Center(child: Text('Redes sociales y contacto',style: TextStyle(fontSize: 20.0,color: Colors.blueAccent ),)),
                  SizedBox(
                    height: 0.0,
                  ),
                 //social(),

                ],
              )

            ),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 0.0,
                  ),
                  //Center(child: Text('Publicaciones',style: TextStyle(fontSize: 20.0,color: Colors.blueAccent ),)),
                ],
              ),
              height: 50.0,

            ),
            

            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 0.0,
                  ),
                 //Center(child: Text('Reseñas',style: TextStyle(fontSize: 20.0,color: Colors.blueAccent ),)),
                  SizedBox(
                    height: 0.0,
                  ),

                ],
              )

            ),
           //usando resenasection,

            SizedBox(
                    height: 15.0,
                  ),

            Container(
  
                padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
  
                child: RaisedButton(
                  onPressed: (){hacerpedido();},  
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
                  color: Color(0xff4267b2),  
                  child: new Row (
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,

                                          children: <Widget>[
                                            new Text('HACER PEDIDO ', style: TextStyle(fontSize: 20, color: Colors.white)), 
                                            new Icon(FontAwesomeIcons.motorcycle, color: Colors.white,)
                                          ],
                                        )
                ),
              ),



          ],

        ),

        appBar: new AppBar(
          title: new Text( 'Regresar'),
        ),

    );
  }

 

 
}