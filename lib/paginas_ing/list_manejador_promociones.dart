import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/main.dart';
import 'package:cabofind/paginas/login.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas_ing/login.dart';
import 'package:cabofind/paginas_ing/publicacion_detalle.dart';
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';




class Manejador_promociones_ing extends StatefulWidget {
   
  final Categoria cat;

  Manejador_promociones_ing({Key key, @required this.cat}) : super(
    key: key);

  @override
  Publicacionesfull createState() => new Publicacionesfull();

}


class Publicacionesfull extends State<Manejador_promociones_ing> {
  ScrollController _scrollController = new ScrollController();
  int _ultimoItem =0;
  List<int> _listaNumeros = new List();

  List data;
  List databaja;
  List data_n;
  List data_c;


  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/ing/list_promociones_manejador.php?CAT=${widget.cat.cat}"),

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

  Future<String> insertRecomendacion(id_c) async {
    
       String currentLocale;
    try {
      currentLocale = await Devicelocale.currentLocale;
      print(currentLocale);
    } on PlatformException {
      print("Error obtaining current locale");
    }

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail ="";
    _status = login.getString("stringLogin")?? '';
    _mail = login.getString("stringMail")?? '';
    print(_mail);
    print(id_c);
      if (_status == "True") {
          showPromo();

      var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insert_recomendacion_publicacion.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=${currentLocale}&ID=${id_c}&SO=Android&CORREO=${_mail}"),

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
                        builder: (BuildContext context) => Login_ing()
                        )
                        );            
     
  }  


  
  }

void showPromo() {
      Fluttertoast.showToast(
          msg: "Added to deals!",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Color(0xffF4A32C),
          textColor: Colors.white,
          timeInSecForIos: 1);
    }

  @override
  void initState() {
    super.initState(

    );
    this.getData();


  }


  Widget build(BuildContext context) {


      return new Scaffold(
appBar: new AppBar(
      title: new Text('Deals'),
    ),
    body: Container(
     // height: MediaQuery.of(context).size.height,
    child: new  StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount:data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        String id_c = data[index]["ID_PUBLICACION"];
        return Container(
        decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10.0),

                  border: Border.all(
                      color: Colors.blue)),
              padding: EdgeInsets.all(
                  1.0),
              margin: EdgeInsets.all(
                  1.0),
        child: InkWell(
                  child: Column(

            children: <Widget>[


              Stack(
                                children: <Widget>[
    Padding(
  
                    child: new Text(
  
                      data[index]["PUB_TITULO_ING"],
  
                      overflow: TextOverflow.ellipsis,
  
                      maxLines: 1,
  
                      style: TextStyle(
  
                        fontWeight: FontWeight.bold,
  
                        color: Colors.black,
  
                        fontSize: 20.0,
  
                      ),),
  
                    padding: EdgeInsets.all(1.0),
  
                  ),
],
              ),

              Expanded(
                  child: Stack(
                                        children: <Widget>[
    FadeInImage(
  
                      image: NetworkImage(data[index]["GAL_FOTO_ING"]),
  
                      fit: BoxFit.cover,
  
                      width: MediaQuery.of(context).size.width,                    
  
                      height: MediaQuery.of(context).size.height,                    
  
                      placeholder: AssetImage('android/assets/images/loading.gif'),
  
                      fadeInDuration: Duration(milliseconds: 200),
  
                  ),
                  Positioned(
                      right: -9.0,
                      bottom: 0.0,
                      child: new FloatingActionButton(
                        child: new Image.asset(
                      "assets/fire2.png",
                      fit: BoxFit.cover,
                      width: 50.0,
                      height: 50.0,
                      
                      

                    ),
                        backgroundColor: Colors.transparent,
                         elevation: 0.0,

                      ),
                    ), 
              Positioned(
                              right: -9,
                              bottom: -10,
                              child: new FloatingActionButton(
                              
                               child: new Text( data[index]["PUB_RECOMENDACIONES"],
                               style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0, color: Colors.black)),
                               elevation: 0.0,
                              backgroundColor: Colors.transparent,
                               onPressed: (){insertRecomendacion(id_c);
                               getData();
                               
                               },
                              ),
                            ), 
],
                  ),
              ),
              Row(
                  children: <Widget>[
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
          onTap: () {
            String id_n = data[index]["ID_NEGOCIO"];
            String id = data[index]["ID_PUBLICACION"];
           


            Navigator.push(context, new MaterialPageRoute
              (builder: (context) => new Publicacion_detalle_fin_ing(
              publicacion: new Publicacion(id_n,id),
            )
            )
            );


          },
        ),
      );
      },

      staggeredTileBuilder: (int index) =>
      new StaggeredTile.count(2, index.isEven ? 3 : 3),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    ),

    ),


    );


  }
}