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



class Publicacion_detalle_fin_push extends StatefulWidget {


  @override

  _Publicacion_detalles createState() => new _Publicacion_detalles();
}

class _Publicacion_detalles extends State<Publicacion_detalle_fin_push> {
  
  
  List data;
  List datacar;
  List dataneg;


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
            "http://cabofind.com.mx/app_php/APIs/esp/list_negocios_api.php?ID=${'arg'}"),
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
    print(
        data[0]["NEG_DESCRIPCION"]);

    return "Success!";
  }

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
            "http://cabofind.com.mx/app_php/APIs/esp/insert_recomendacion_publicacion.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=${currentLocale},&ID=${'arg'}&SO=Android"),

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
            //"http://cabofind.com.mx/app_php/APIs/esp/insert_visita_publicacion.php?ID=${widget.publicacion.id}"),
            "http://cabofind.com.mx/app_php/APIs/esp/insert_visita_publicacion.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=${currentLocale}&ID=${'arg'}&SO=Android"),

          //"http://cabofind.com.mx/app_php/list_negocios.php?"),


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
            "http://cabofind.com.mx/app_php/APIs/esp/list_negocios_api.php?ID=${'arg'}"),
        //"http://cabofind.com.mx/app_php/list_negocios.php?"),


        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
              dataneg = json.decode(
              response.body);
        });
    print(
        dataneg[0]["NEG_NOMBRE"]);

    return "Success!";
  }



  @override
  void initState() {
    super.initState(

    );
    this.insertPublicacionAndroid();
    this.getData();
    this.getNeg();

  }

  // Declare a field that holds the Person data




  @override

  Widget build(BuildContext context){

final arg = ModalRoute.of(context).settings.arguments;

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
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {

          return new ListTile(


            title: new Container(
                  padding: const EdgeInsets.only(top:5.0),
                  child: Row(
                    children: [
                      Expanded(
                        /*1*/
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*2*/
                            Center(
                              child: Text(
                                arg,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23.0

                                ),
                              ),

                            ),
                            
                            Center(
                              //  padding: const EdgeInsets.only(bottom: 10,left: 150.0),
                              child: Text(
                                arg,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    color: Color(0xff2E85DC)

                                ),
                              ),

                            ),
                            SizedBox(
                              height: 5.0,
                            ),

                            Column(
                              children: <Widget>[

                                Container(

                                padding: const EdgeInsets.only(left:20.0,bottom: 20.0,),
                                child: Text(
                                  arg,
                                  //softWrap: true,
                                  style: TextStyle(fontSize: 20.0,

                                  ),
                                ),

                              ),
                                Container(
                                  child:
                                  Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Center(child: Text('Video promocional',style: TextStyle(fontSize: 23.0,color: Colors.blueAccent ),)),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      YoutubePlayer(
                                        context: context,
                                        //videoId: widget.publicacion.vid,
                                        videoId: YoutubePlayer.convertUrlToId("${arg}"),
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
                                      SizedBox(
                                        height: 5.0,
                                                ),
                                              ],
                                            ),

                                          ),

            Container(
              padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
              child: RaisedButton(

                //child: Text(‘Send data to the second page’),
                onPressed: () {

                  String id_sql = data[index]["ID_NEGOCIO"];
                  String nombre_sql = data[index]["NEG_NOMBRE"];
                  String cat_sql = data[index]["CAT_NOMBRE"];
                  String subcat_sql = data[index]["SUB_NOMBRE"];
                  String foto_sql = data[index]["GAL_FOTO"];
                  String etiquetas_sql = data[index]["NEG_ETIQUETAS"];
                  String desc_sql = data[index]["NEG_DESCRIPCION"];
                  String mapa_sql = data[index]["NEG_MAP"];
                  String fb_sql = data[index]["NEG_FACEBOOK"];
                  String ins_sql = data[index]["NEG_INSTAGRAM"];
                  String web_sql = data[index]["NEG_WEB"];
                  String tel = data[index]["NEG_TEL"];
                  String cor = data[index]["NEG_CORREO"];
                  String hor = data[index]["NEG_HORARIO"];




                  Navigator.push(context, new MaterialPageRoute
                    (builder: (context) => new Empresa_det_fin(empresa: new Empresa(id_sql,nombre_sql,cat_sql,subcat_sql,foto_sql,etiquetas_sql,desc_sql,mapa_sql,fb_sql,ins_sql,web_sql,tel,cor,hor))
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
                      /*3*/


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
         
                Stack(
                children: <Widget>[

                   Image.network(arg
                ,width: MediaQuery.of(context).size.width,height: 450,fit: BoxFit.fill ),              
                Positioned(
                        right: 0.0,
                        bottom: 390.0,
                        child: new FloatingActionButton(
                          child: new Image.asset(
                        "assets/rating.png",
                        fit: BoxFit.cover,
                        width: 50.0,
                        height: 50.0,

                      ),
                          backgroundColor: Colors.black,
                           onPressed: (){showShortToast();insertRecomendacion();},

                        ),
                      ),
                            ]
              ),
                
            //Image.asset('android/assets/images/img1.jpg',width: 600,height: 240,fit: BoxFit.cover,),
            //loading,
            //titleSection,
            //textSection,
            //video,
             //boton,
             Column(
              children: <Widget>[publicaciones],
             // height:1000.0,

            )



          ],
        ),
        appBar: new AppBar(
          title: new Text(arg,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0

            ),

          ),

        )
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }


  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}









