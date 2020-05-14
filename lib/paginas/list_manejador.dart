import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/main.dart';
import 'package:cabofind/paginas/login.dart';
import 'package:cabofind/paginas/usuario.dart';
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




class Lista_Manejador_esp extends StatefulWidget {

  final Lista_manejador manejador;

  Lista_Manejador_esp({Key key, @required this.manejador}) : super(
    key: key);

  @override
  _ListaAcuaticas createState() => new _ListaAcuaticas();

}

class _ListaAcuaticas extends State<Lista_Manejador_esp> {

List data;
List databaja;
GlobalKey _toolTipKey = GlobalKey();


  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/list_manejador_baja.php?CAT=${widget.manejador.id_cat}&SUB=${widget.manejador.id_sub}"),  
       
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

  Future<String> getDatabaja() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/list_manejador.php?CAT=${widget.manejador.id_cat}&SUB=${widget.manejador.id_sub}"),       
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          databaja = json.decode(
              response.body);
        });
    
    return "Success!";
  }

  Future<String> insertFavorite(id_n) async {

    String currentLocale;
    try {
      currentLocale = await Devicelocale.currentLocale;
      print(currentLocale);
    } on PlatformException {
      print("Error obtaining current locale");
    }
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
             
 final SharedPreferences login = await SharedPreferences.getInstance();
 String _status = "";
 String _mail ="";
 _status = login.getString("stringLogin")?? '';
 _mail = login.getString("stringMail")?? '';
 print(_status);
 print(_mail);
 //String id = data[0]["ID_NEGOCIO"];
 print(id_n);
  // if (prefs.getString(_idioma) ?? 'stringValue' == "espanol")
  if (_status == "True") {
      showFavorites();

      var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insert_recomendacion_negocio.php?MOD=${iosInfo.model}&BOOT=${iosInfo.utsname.nodename},${iosInfo.identifierForVendor},&VERSION=${iosInfo.systemName}}&IDIOMA=${currentLocale}&ID=${id_n}&SO=iOS&CORREO=${_mail}"),
            //"http://cabofind.com.mx/app_php/APIs/esp/insert_recomendacion_negocio.php?MOD=${iosInfo.model}&BOOT=${iosInfo.utsname.nodename},${iosInfo.identifierForVendor}&VERSION=${iosInfo.systemName}&IDIOMA=${currentLocale}"),

        headers: {
          "Accept": "application/json"
        }
    );

      //CircularProgressIndicator(value: 5.0,);
      
    }
    else
    {
     //CircularProgressIndicator(value: 5.0,);
     
      Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => Login()
                        )
                        );            
     
  }    
  }

  void showFavorites() {
      Fluttertoast.showToast(
          msg: "Agregado a favoritos!",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Color(0xffED393A),
          textColor: Colors.white,
          timeInSecForIosWeb: 1);
    }


  @override
  void initState() {
    super.initState(
    );

    this.getData();
this.getDatabaja();
  }
  @override
void dispose() {
 // _audioPlayer?.dipose();
  super.dispose();
}
  




  Widget build(BuildContext context) {

    Widget listado = ListView.builder(
       shrinkWrap: true,
      physics: BouncingScrollPhysics(),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
String id_n = data[index]["ID_NEGOCIO"];
          return new ListTile(


            title: new Card(

              elevation: 5.0,
              child: new Container(


                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10.0),
                    border: Border.all(
                        color: Colors.lightBlueAccent)
                ),
                padding: EdgeInsets.all(
                    10.0),
                margin: EdgeInsets.all(
                    10.0),

                child: Column(
                  children: <Widget>[

                    Stack(
                children: <Widget>[

                   FadeInImage(

                      image: NetworkImage(data[index]["GAL_FOTO"]),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 220,

                      // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                      placeholder: AssetImage('android/assets/images/loading.gif'),
                      fadeInDuration: Duration(milliseconds: 200),

                    ),
                  
                Positioned(
                        right: -8.0,
                        bottom: 170.0,
                        child: new FloatingActionButton(
                          child: new Image.asset(
                        "assets/premium1.png",
                        fit: BoxFit.cover,
                        width: 35.0,
                        height: 35.0,

                      ),
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          onPressed: (){
                          final dynamic tooltip = _toolTipKey.currentState;
                          tooltip.ensureTooltipVisible();},

                        ),
                      ),
                      Tooltip(
                                key: _toolTipKey,
                                message: 'Establecimiento destacado',
                                verticalOffset: -10,
                                preferBelow: true,
                                
                                
                              ),

                Positioned(
                        right: -8.0,
                        bottom: -8.0,
                        child: new FloatingActionButton(
                          child: new Image.asset(
                        "assets/corazon2.png",
                        fit: BoxFit.cover,
                        width: 35.0,
                        height: 35.0,
                        

                      ),
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                           

                        ),
                      ), 
                Positioned(
                                right: -8,
                                bottom: -8,
                                child: new FloatingActionButton(                                
                                 child: new Text( data[index]["NEG_RECOMENDACIONES"],
                                 style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0, color: Colors.black)),
                                 elevation: 0.0,
                                 backgroundColor: Colors.transparent,
                                 onPressed: (){insertFavorite(id_n);
                                 getData();
                                 getDatabaja();
                                 },
                                ),
                              ),  

                            ]
              ),
                    Row(
                        children: <Widget>[

                          Padding(

                              child: Text(

                                  data[index]["SUB_NOMBRE"],
                                overflow: TextOverflow.ellipsis,),
                              padding: EdgeInsets.all(
                                  1.0)),
                          Text(
                              " | "),
                          Padding(
                              child: new Text(
                                  data[index]["NEG_NOMBRE"],
                                overflow: TextOverflow.ellipsis,),
                              padding: EdgeInsets.all(
                                  1.0)),
                          Text(
                              " | "),
                          Flexible(
                            child: new Text(
                              data[index]["NEG_LUGAR"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,),


                          ),

                        ]),
                  ],

                ),

              ),

            ),

            onTap: () {
              String id_sql = data[index]["ID_NEGOCIO"];

              Navigator.push(context, new MaterialPageRoute
                (builder: (context) => new Empresa_det_fin(empresa: new Empresa(id_sql))));

            },
            //A Navigator is a widget that manages a set of child widgets with
            //stack discipline.It allows us navigate pages.
            //Navigator.of(context).push(route);
          );

        },

    );

    Widget listadobaja = ListView.builder(
       shrinkWrap: true,
      physics: BouncingScrollPhysics(),
        itemCount: databaja == null ? 0 : databaja.length,
        itemBuilder: (BuildContext context, int index) {
String id_n = databaja[index]["ID_NEGOCIO"];
          return new GestureDetector(


            child: new Container(


              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(10.0),
                  border: Border.all(
                      color: Colors.lightBlueAccent)
              ),
              padding: EdgeInsets.all(
                  10.0),
              margin: EdgeInsets.all(
                  10.0),

              child: Column(

                children: <Widget>[

                  Stack(
              children: <Widget>[

                 FadeInImage(

                    image: NetworkImage(databaja[index]["GAL_FOTO"]),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 220,

                    // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                    placeholder: AssetImage('android/assets/images/loading.gif'),
                    fadeInDuration: Duration(milliseconds: 200),

                  ),

              Positioned(
                      right: -8.0,
                      bottom: -8.0,
                      child: new FloatingActionButton(
                        child: new Image.asset(
                      "assets/corazon2.png",
                      fit: BoxFit.cover,
                      width: 35.0,
                      height: 35.0,

                    ),
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                         onPressed: (){},

                      ),
                    ),
              Positioned(
                              
                              right: -8,
                              bottom: -8,
                              child: new FloatingActionButton(
                                
                               child: new Text(databaja[index]["NEG_RECOMENDACIONES"],
                               style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0, color: Colors.black)),
                               elevation: 0.0,
                               backgroundColor: Colors.transparent,
                               onPressed: (){insertFavorite(id_n);
                               getData();
                               getDatabaja();
                               },
                               
                              ),
                            ),              
                          ]
            ),
                  Row(
                      children: <Widget>[

                        Padding(

                            child: Text(

                                databaja[index]["SUB_NOMBRE"],
                              overflow: TextOverflow.ellipsis,),
                            padding: EdgeInsets.all(
                                1.0)),
                        Text(
                            " | "),
                        Padding(
                            child: new Text(
                                databaja[index]["NEG_NOMBRE"],
                              overflow: TextOverflow.ellipsis,),
                            padding: EdgeInsets.all(
                                1.0)),
                        Text(
                            " | "),
                        Flexible(
                          child: new Text(
                            databaja[index]["NEG_LUGAR"],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,),


                        ),

                      ]),
                ],

              ),

            ),

            onTap: () {
              String id_sql = databaja[index]["ID_NEGOCIO"];
              Navigator.push(context, new MaterialPageRoute
                (builder: (context) => new Empresa_det_fin(empresa: new Empresa(id_sql))));

            },
            //A Navigator is a widget that manages a set of child widgets with
            //stack discipline.It allows us navigate pages.
            //Navigator.of(context).push(route);
          );

        },

    );
    return new Scaffold(

      body: Container(
        // height: MediaQuery.of(context).size.height,
        child: new ListView(

          children: [

            Column(

              children: <Widget>[listado,listadobaja],

            ),

          ],
        ),
      ),
    );






  }
}