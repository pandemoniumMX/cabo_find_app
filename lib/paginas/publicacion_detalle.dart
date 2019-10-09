import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/paginas_listas/list_publicaciones.dart';
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/services.dart';
//import 'package:custom_chewie/custom_chewie.dart';
import 'package:http/http.dart' as http;
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';



class Publicacion_detalle_fin extends StatefulWidget {

  List data;
  final Publicacion publicacion;
  final Empresa empresa;
  Publicacion_detalle_fin({Key key, @required this.publicacion, this.empresa}) : super(
      key: key);


  @override

  _Publicacion_detalles createState() => new _Publicacion_detalles();
}

class _Publicacion_detalles extends State<Publicacion_detalle_fin> {
  List data;
  List datacar;
  List dataneg;
  List data_pub;


  YoutubePlayerController _controller = YoutubePlayerController();
  var _idController = TextEditingController();
  var _seekToController = TextEditingController();
  double _volume = 100;
  bool _muted = false;
  String _playerStatus = "";
  String _errorCode = '0';


  void listener() {

    setState(() {
      _playerStatus = _controller.value.playerState.toString();
      _errorCode = _controller.value.errorCode.toString();
      print(_controller.value.toString());
    });
  }

  @override
  void deactivate() {
    // This pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_negocios_api.php?ID=${widget.publicacion.id_n}"),
          //"http://cabofind.com.mx/app_php/list_negocios.php?"),


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
/*
  Future<String> insertRecomendacioniOS() async {
    
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
          "http://cabofind.com.mx/app_php/APIs/esp/insert_recomendacion_publicacion.php?MOD=${iosInfo.model}&BOOT=${iosInfo.utsname.nodename},${iosInfo.utsname.sysname}&VERSION=${iosInfo.systemName}&IDIOMA=${currentLocale}&ID=${widget.publicacion.id}&SO=iOS"),
            //"http://cabofind.com.mx/app_php/APIs/ing/insert_recomendacion_publicacion.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=${currentLocale},&ID=${widget.publicacion.id}&SO=Android"),

        headers: {
          "Accept": "application/json"
        }
    );
  
  }
*/
Future<String> insertRecomendacion() async {
    
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
            "http://cabofind.com.mx/app_php/APIs/esp/insert_recomendacion_publicacion.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=${currentLocale},&ID=${widget.publicacion.id_p}&SO=Android"),

        headers: {
          "Accept": "application/json"
        }
    );
  
  }

//contador visita publicacion Android
  Future<String> insertPublicacionAndroid() async {

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
            "http://cabofind.com.mx/app_php/APIs/esp/insert_visita_publicacion.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=${currentLocale}&ID=${widget.publicacion.id_p}&SO=Android"),



        headers: {
          "Accept": "application/json"
        }
    );
}


/*
Future<String> insertPublicacioniOS() async {

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
            //"http://cabofind.com.mx/app_php/APIs/esp/insert_visita_publicacion.php?ID=${widget.publicacion.id}"),
            "http://cabofind.com.mx/app_php/APIs/esp/insert_visita_publicacion.php?MOD=${iosInfo.model}&BOOT=${iosInfo.utsname.nodename},${iosInfo.utsname.sysname}&VERSION=${iosInfo.systemName}&IDIOMA=${currentLocale}&ID=${widget.publicacion.id}&SO=iOS"),

          //"http://cabofind.com.mx/app_php/list_negocios.php?"),


        headers: {
          "Accept": "application/json"
        }
    );
}

*/

  Future<String> getNeg() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_negocios_api.php?ID=${widget.publicacion.id_n}"),


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


  Future<String> getPub() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_publicaciones_api.php?ID=${widget.publicacion.id_p}"),


        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
              data_pub = json.decode(
              response.body);
        });
    

    return "Success!";
  }



  @override
  void initState() {
    super.initState(

    );
    this.insertPublicacionAndroid();
    this.getData();
    this.getNeg();
    this.getPub();

  }

  // Declare a field that holds the Person data




  @override

  Widget build(BuildContext context){

    void showShortToast() {
      Fluttertoast.showToast(
          msg: "Has recomendado esta publicación",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          timeInSecForIos: 1);
    }

    Widget publicaciones =  ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
        itemCount: data_pub == null ? 0 : data_pub.length,
        itemBuilder: (BuildContext context, int index) {
       // final titulo =  data_pub[index]["PUB_TITULO"];
          return new ListTile(

            title: new Container(
                  padding: const EdgeInsets.only(top:5.0),
                  child: Column(
                      children: <Widget>[
                        Stack(
                        children: <Widget>[
                          Image.network(data_pub[index]["GAL_FOTO"],
                              width: MediaQuery.of(context).size.width,
                              height: 450,
                              fit: BoxFit.fill ),
                        Positioned(
                                right: 0.0,
                                bottom: 390.0,
                                child: new FloatingActionButton(
                                  child: new Image.asset(
                                    "assets/recomend.png",
                                fit: BoxFit.cover,
                                width: 50.0,
                                height: 50.0,
                              ),
                                  backgroundColor: Colors.black,
                                  onPressed: (){showShortToast();insertRecomendacion();},
                                ),
                              ),                                    ]
                      ),
                     SizedBox(height: 5.0,),  
                          
                        Row(  
                        children: [  
                          Expanded(  
                            child: Column(  
                              crossAxisAlignment: CrossAxisAlignment.start,  
                              children: [
  
                                Center(  
                                  child: Text(  
                                    data_pub[index]["PUB_TITULO"],  
                                    style: TextStyle(  
                                        fontWeight: FontWeight.bold,  
                                        fontSize: 23.0
                                    ),  
                                  ),  
                                ), 
                                
  
                                Center(
                                  child: Text(  
                                    data_pub[index]["CAT_NOMBRE"],  
                                    style: TextStyle(  
                                        fontWeight: FontWeight.bold,  
                                        fontSize: 15.0,  
                                        color: Color(0xff2E85DC) 
                                    ),  
                                  ),
                                ),  
                                SizedBox(height: 5.0,),     
                                Column(  
                                  children: <Widget>[
                                    Container(  
                                    padding: const EdgeInsets.only(left:20.0,bottom: 20.0,),  
                                    child: Text(  
                                      data_pub[index]["PUB_DETALLE"],
                                      style: TextStyle(fontSize: 20.0,  
                                      ),  
                                    ),
                                  ),  
                                      Column(  
                                        children: <Widget>[  
                                         SizedBox(height: 5.0,),    
                                          Center(child: Text('Video promocional',style: TextStyle(fontSize: 23.0,color: Colors.blueAccent ),)),  
                                          SizedBox(height: 5.0,),  
                                          YoutubePlayer(  
                                            context: context,  
                                            videoId: YoutubePlayer.convertUrlToId( data_pub[index]["PUB_VIDEO"],),  
                                            autoPlay: false,  
                                            width: MediaQuery.of(context).size.width,  
                                            showVideoProgressIndicator: true,  
                                            videoProgressIndicatorColor: Colors.blue,  
                                            progressColors: ProgressColors(  
                                              playedColor: Colors.blue,  
                                              handleColor: Colors.blueAccent,  
                                            ),  
                                            onPlayerInitialized: (controller) {  
                                              _controller = controller;  
                                              _controller.addListener(listener);  
                                            },  
                                          ),  
                                          SizedBox(height: 5.0,),  
                                                  ],  
                                                ),
              Container(  
                padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),  
                child: RaisedButton(  
                  onPressed: () {  
                      String id_sql = data_pub[index]["ID_NEGOCIO"];  
                      Navigator.push(context, new MaterialPageRoute  
                        (builder: (context) => new Empresa_det_fin(empresa: new Empresa(id_sql))  
                      )  
                      );  
                  },   
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),  
                  color: Colors.blue,  
                  child: Text('Más información', style: TextStyle(fontSize: 20, color: Colors.white)),   
                  ),  
                  ),  
                              ],  
                              ),   
                              ],  
                            ), 
                          ), 
                          ],  
                      ),
                    ],
                  ),
                ),
          );
        },
      );
    





    return new Scaffold(

        body: ListView(
          //scrollDirection: Axis.horizontal,
          children: [           
         
            

             Column(
              children: <Widget>[publicaciones],
             // height:1000.0,

            )



          ],
        ),
        appBar: new AppBar(
          title: new Text( 'Volver',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
                ),
                ),

        )
    );
  }

  


}










