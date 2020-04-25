import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas_ing/empresa_detalle.dart';
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/services.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';


class Publicacion_detalle_fin_ing extends StatefulWidget {

  List data;
  final Publicacion publicacion;
  final Empresa empresa;
  Publicacion_detalle_fin_ing({Key key, @required this.publicacion, this.empresa}) : super(
      key: key);


  @override

  _Publicacion_detalle_fin_ing createState() => new _Publicacion_detalle_fin_ing();
}

class _Publicacion_detalle_fin_ing extends State<Publicacion_detalle_fin_ing> {
  List data;
  List datacar;
  List dataneg;
  List data_pub;




  

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/ing/list_negocios_api.php?ID=${widget.publicacion.id_n}"),


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

  Future<String> getNeg() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/ing/list_negocios_api.php?ID=${widget.publicacion.id_n}"),

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
          "http://cabofind.com.mx/app_php/APIs/ing/insert_recomendacion_publicacion.php?MOD=${iosInfo.model}&BOOT=${iosInfo.utsname.nodename},${iosInfo.identifierForVendor}&VERSION=${iosInfo.systemName}&IDIOMA=${currentLocale}&ID=${widget.publicacion.id_p}&SO=iOS"),
            //"http://cabofind.com.mx/app_php/APIs/ing/insert_recomendacion_publicacion.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=${currentLocale},&ID=${widget.publicacion.id}&SO=Android"),

        headers: {
          "Accept": "application/json"
        }
    );
  
  }
/*


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
            "http://cabofind.com.mx/app_php/APIs/ing/insert_recomendacion_publicacion.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=${currentLocale},&ID=${widget.publicacion.id_p}&SO=Android"),

        headers: {
          "Accept": "application/json"
        }
    );
  
  }


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
            "http://cabofind.com.mx/app_php/APIs/ing/insert_visita_publicacion.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=${currentLocale}&ID=${widget.publicacion.id_p}&SO=Android"),

          //"http://cabofind.com.mx/app_php/list_negocios.php?"),


        headers: {
          "Accept": "application/json"
        }
    );
}
*/

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
    "http://cabofind.com.mx/app_php/APIs/ing/insert_visita_publicacion.php?MOD=${iosInfo.model}&BOOT=${iosInfo.utsname.nodename},${iosInfo.identifierForVendor}&VERSION=${iosInfo.systemName}&IDIOMA=${currentLocale}&ID=${widget.publicacion.id_p}&SO=iOS"),



        headers: {
          "Accept": "application/json"
        }
    );
}

  Future<String> getPub() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/ing/list_publicaciones_api_single.php?ID=${widget.publicacion.id_n}&ID_P=${widget.publicacion.id_p}"),
        //"http://cabofind.com.mx/app_php/list_negocios.php?"),


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
    this.getData();
    this.getNeg();
    //this.insertPublicacionAndroid();
    this.insertPublicacioniOS();
    this.getPub();


  }
  @override

  Widget build(BuildContext context){

    void showShortToast() {
      Fluttertoast.showToast(
          msg: "You have recommended this publication",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          timeInSecForIosWeb: 1);
    }
    
    Widget videosection = Container(
  width: 250.00,
     child: new ListView.builder(
     shrinkWrap: true,
     physics: BouncingScrollPhysics(),
     itemCount: data_pub == null ? 0 : data_pub.length,
       itemBuilder: (BuildContext context, int index) {

  return new  RaisedButton(  
                                       onPressed: () {  
                                         FlutterYoutube.playYoutubeVideoByUrl(
                                         apiKey: "AIzaSyAmNDqJm2s5Fpualsl_VF6LhG733knN0BY",
                                         videoUrl: data_pub[index]["PUB_VIDEO"],
                                         autoPlay: false, //default falase
                                         fullScreen: false //default false
                                       ); 
                                       },   
                                       shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),  
                                       color: Colors.red, 
                                       child: new Row (
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,

                                          children: <Widget>[
                                            new Text('WATCH VIDEO ', style: TextStyle(fontSize: 20, color: Colors.white)), 
                                            new Icon(FontAwesomeIcons.youtube, color: Colors.white,)
                                          ],
                                        )
                                       );
       }
     )
   );
   
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
                          Image.network(data_pub[index]["GAL_FOTO_ING"],
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 1.5,
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
                                  onPressed: (){showShortToast();insertRecomendacioniOS();},
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
                                    data_pub[index]["PUB_TITULO_ING"],  
                                    style: TextStyle(  
                                        fontWeight: FontWeight.bold,  
                                        fontSize: 23.0
                                    ),  
                                  ),  
                                ), 
                                
  
                                Center(
                                  child: Text(  
                                    data_pub[index]["CAT_NOMBRE_ING"],  
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
                                    Center(  
                                    //padding: const EdgeInsets.only(left:20.0,bottom: 20.0,),  
                                    child: Text(  
                                      data_pub[index]["PUB_DETALLE_ING"],
                                      style: TextStyle(fontSize: 20.0,  
                                      ),  
                                    ),
                                  ), 
                                  //YoutubePlayer.convertUrlToId( data_pub[index]["PUB_VIDEO"],), 
                                      Column(  
                                        children: <Widget>[  
                                         videosection,

                                          RaisedButton(  
                                          onPressed: () {  
                                              String id_sql = data_pub[index]["ID_NEGOCIO"];  
                                              Navigator.push(context, new MaterialPageRoute  
                                                (builder: (context) => new Empresa_det_fin_ing(empresa: new Empresa(id_sql))  
                                              )  
                                              );  //Color(0xff01969a),
                                          },   
                                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),  
                                          color: Color(0xff01969a), 
                                          child: new Row (
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,

                                          children: <Widget>[
                                            new Text('VENDOR INFO', style: TextStyle(fontSize: 20, color: Colors.white)), 
                                            new Icon(FontAwesomeIcons.infoCircle, color: Colors.white,)
                                          ],
                                        )
                    
                                          ), 
                                          SizedBox(height: 5.0,),  
                                                  ],  
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
          title: new  Text( 'Back',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0

            ),

          ),

        )
    );
  }


  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}










