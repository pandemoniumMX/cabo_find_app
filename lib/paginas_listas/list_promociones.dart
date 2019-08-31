import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/main.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:http/http.dart' as http;

import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';




class Promociones extends StatefulWidget {
   


  @override
  Promocionesfull createState() => new Promocionesfull();

}


class Promocionesfull extends State<Promociones> {
  ScrollController _scrollController = new ScrollController();
  int _ultimoItem =0;
  List<int> _listaNumeros = new List();
  
  List data;
  List data_n;
  List data_c;


  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/list_promociones.php"),
       
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
        data[0]["NEG_NOMBRE"]);

    return "Success!";
  }


 
  @override
  void initState() {
    super.initState(    
   
    );
    this.getData();


  }

 
  Widget build(BuildContext context) {

 final Widget carrusel =   Container(
   child: new ListView.builder(

     scrollDirection: Axis.horizontal,

     itemCount: data == null ? 0 : data.length,
     itemBuilder: (BuildContext context, int index) {

       return  new Container(
         padding: EdgeInsets.only( left: 5.0, right: 1.0),
         child: Column(
           children: <Widget>[
             Padding(
               child: Image.network(
                 data[index]["GAL_FOTO"],
                 fit: BoxFit.cover,
                 height: 400.0,
                 width: 400.0,
               ),
               padding: EdgeInsets.all(0.0),
             ),
           ],
         ),
       );
     },
   ),
 );


      Widget publicaciones =  ListView.builder(
      controller: _scrollController,
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
                      color: Colors.blue)),
              padding: EdgeInsets.all(
                  10.0),
              margin: EdgeInsets.all(
                  10.0),

              child: Column(

                children: <Widget>[

                  Padding(
                            child: new Text(
                              data[index]["PUB_TITULO"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20.0,
                                ),),
                    padding: EdgeInsets.all(1.0),
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

                              data[index]["CAT_NOMBRE"],
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
            String id_n = data[index]["ID_NEGOCIO"];
            String id = data[index]["ID_PUBLICACION"];
            String nom = data[index]["NEG_NOMBRE"];
            String lug = data[index]["NEG_LUGAR"];
            String cat = data[index]["CAT_NOMBRE"];
            String sub = data[index]["SUB_NOMBRE"];
            String gal = data[index]["GAL_FOTO"];
            String tit = data[index]["PUB_TITULO"];
            String det = data[index]["PUB_DETALLE"];
            String fec = data[index]["PUB_FECHA"];
            String vid = data[index]["PUB_VIDEO"];
            String tel = data[index]["NEG_TEL"];
            String cor = data[index]["NEG_CORREO"];


            Navigator.push(context, new MaterialPageRoute
              (builder: (context) => new Publicacion_detalle_fin(
              publicacion: new Publicacion(id_n,id,nom,lug,cat,sub,gal,tit,det,fec,vid,tel,cor),
            )
            )
            );


          },
          //A Navigator is a widget that manages a set of child widgets with
          //stack discipline.It allows us navigate pages.
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

           children: <Widget>[publicaciones],

         ),

    ],
    ),
    ),
    );
  }
}