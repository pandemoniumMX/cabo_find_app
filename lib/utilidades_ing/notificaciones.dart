import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas_ing/publicacion_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:location/location.dart' as LocationManager;
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';


//void main() => runApp(Maps());



class Notificaciones_ing extends StatefulWidget {
  Notificaciones_ing({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Notificaciones_ing> {
  List data;


  @override
  void initState() {
    super.initState();
     this.getCar();
  }

 

  Future<String> getCar() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/notificaciones.php"),

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
      appBar: AppBar(
        title: Text("Notifications"),
        
        centerTitle: true,
      ),
      body: ListView.builder(
       shrinkWrap: true,
      physics: BouncingScrollPhysics(),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {

          return new ListTile(


            title: new Card(

              elevation: 5.0,
              child: new Container(


                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10.0),
                  border: Border.all(
                  color: Colors.lightBlueAccent)
                ),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),

                child: Column(

                  children: <Widget>[

                    Center(

                                  child: Text(
                                  data[index]["PUB_TITULO_ING"],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize:30.0,),
                                  ),),
                                  //SizedBox(height:5),

                    
                                Center(
                                  child: Text(
                                  data[index]["PUB_DETALLE_ING"],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize:15.0,),
                                  maxLines: 5, 
                                  ),
                                ),

                               SizedBox(height:10),
                          Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                data[index]["PUB_FECHA"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize:10.0,),
                                maxLines: 1,),
                          ),
                  ],

                ),

              ),

            ),

            onTap: () {
              String id_sql = data[index]["ID_PUBLICACION"];
              String id_n = data[index]["ID_NEGOCIO"];

              Navigator.push(context, new MaterialPageRoute
                (builder: (context) => new Publicacion_detalle_fin_ing(publicacion: new Publicacion(id_n,id_sql),)));

            },
            //A Navigator is a widget that manages a set of child widgets with
            //stack discipline.It allows us navigate pages.
            //Navigator.of(context).push(route);
          );

        },

    )
    );

    

  }

  

  
  

}