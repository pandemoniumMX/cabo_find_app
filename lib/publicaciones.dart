import 'dart:async';
import 'dart:convert';

import 'package:cabofind/main.dart';
import 'package:cabofind/publicacion_detalle.dart';
import 'package:cabofind/slider_backup.dart';
import 'package:http/http.dart' as http;

import 'package:cabofind/carousel_pro.dart';
import 'package:cabofind/empresa_detalle.dart';
import 'package:cabofind/classes.dart';
import 'package:flutter/material.dart';




class Publicaciones extends StatefulWidget {
  Widget build(BuildContext context){
    return ListView(
      children: <Widget>[
        slider,

      ],
    );

  }
  @override
  Publicacionesfull createState() => new Publicacionesfull();

}


class Publicacionesfull extends State<Publicaciones> {

  List data;

  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/list_publicaciones.php"),
       
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
        data[1]["NEG_NOMBRE"]);

    return "Success!";
  }
  /*
  Future<String> getData1() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/list_vida_bares.php"),
       
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
        data[1]["NEG_NOMBRE"]);

    return "Success!";
  }
*/
  @override
  void initState() {
    super.initState(
    );
    this.getData();
//    this.getData1();

  }


  Widget build(BuildContext context) {

    Widget publicaciones =  Container(

      child:  ListView.builder(
        shrinkWrap: false,
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
                        color: Colors.blue)),
                padding: EdgeInsets.all(
                    10.0),
                margin: EdgeInsets.all(
                    10.0),

                child: Column(

                  children: <Widget>[

                    Padding(

                        child: Text(

                            data[index]["PUB_TITULO"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20.0,


                          ),

                        ),
                        padding: EdgeInsets.all(
                            1.0)
                    ),

                    FadeInImage(

                      image: NetworkImage(data[index]["GAL_FOTO"]),
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: 250,

                      // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                      placeholder: AssetImage('android/assets/images/loading.gif'),
                      fadeInDuration: Duration(milliseconds: 200),
                     
                      ),
                     
                    
                    Row(
                        children: <Widget>[

                          Padding(

                              child: Text(

                                  data[index]["CAT_NOMBRE"]),
                              padding: EdgeInsets.all(
                                  1.0)),
                          Text(
                              " | "),
                          Padding(
                              child: new Text(
                                  data[index]["NEG_NOMBRE"]),
                              padding: EdgeInsets.all(
                                  1.0)),
                          Text(
                              " | "),
                          Padding(
                              child: new Text(
                                  data[index]["NEG_LUGAR"]),
                              padding: EdgeInsets.all(
                                  1.0)),



                        ]),
                  ],

                ),

              ),

            ),

            onTap: () {
              String nom = data[index]["NEG_NOMBRE"];
              String neg = data[index]["NEG_LUGAR"];
              String cat = data[index]["CAT_NOMBRE"];
              String sub = data[index]["SUB_NOMBRE"];
              String gal = data[index]["GAL_FOTO"];
              String tit = data[index]["PUB_TITULO"];
              String det = data[index]["PUB_DETALLE"];
              String fec = data[index]["PUB_FECHA"];




              Navigator.push(context, new MaterialPageRoute
                (builder: (context) => new Publicacion_detalle_fin(publicacion: new Publicacion(nom,neg,cat,sub,gal,tit,det,fec))
              )
              );


            },
            //A Navigator is a widget that manages a set of child widgets with
            //stack discipline.It allows us navigate pages.
            //stack discipline.It allows us navigate pages.
            //Navigator.of(context).push(route);
          );

        },
      ),
    );

      return new Scaffold(

    body: Container(
     // height: MediaQuery.of(context).size.height,
    child: new ListView(
      
    // shrinkWrap: true,
    //physics: BouncingScrollPhysics(),
    children: [
      Container(
        
        child: publicaciones,
         // height: MediaQuery.of(context).size.height
          height: MediaQuery.of(context).size.height + 20

      ),




    ],
    ),

    ),


    );


  }
}