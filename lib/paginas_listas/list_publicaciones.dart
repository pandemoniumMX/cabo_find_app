import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/main.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:http/http.dart' as http;
import 'package:cabofind/utilidades/carousel_pro.dart';
import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';




class Publicaciones extends StatefulWidget {
   


  @override
  Publicacionesfull createState() => new Publicacionesfull();

}


class Publicacionesfull extends State<Publicaciones> {
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

  Future<String> getData_n() async {
    var response = await http.get(
        Uri.encodeFull(
             "http://cabofind.com.mx/app_php/list_publicaciones.php"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
              data_n = json.decode(
              response.body);
        });
    

    return "Success!";
  }
 Future<String> getCarrusel() async {
    var response = await http.get(
        Uri.encodeFull(
             "http://cabofind.com.mx/app_php/fotos.php"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
              data_c = json.decode(
              response.body);
        });
    

    return "Success!";
  }
 
  @override
  void initState() {
    super.initState(    
   
    );
    this.getData();
    this.getData_n();
    this.getCarrusel();


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

    Widget publicaciones =  Container(

      child:  ListView.builder(
        controller: _scrollController,
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

              String nombre_n = data_n[index]["NEG_NOMBRE"];
              String cat_n = data_n[index]["CAT_NOMBRE"];
              String sub_n = data_n[index]["SUB_NOMBRE"];
              String log_n = data_n[index]["GAL_FOTO"];
              String eti_n = data_n[index]["NEG_ETIQUETAS"];
              String desc_n = data_n[index]["NEG_DESCRIPCION"];
              String map_n = data_n[index]["NEG_MAP"];





              Navigator.push(context, new MaterialPageRoute
                (builder: (context) => new Publicacion_detalle_fin(
                publicacion: new Publicacion(nom,neg,cat,sub,gal,tit,det,fec),
                empresa: new Empresa(nombre_n, cat_n, sub_n, log_n, eti_n, desc_n, map_n),)
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
          height: MediaQuery.of(context).size.height - 120

      ),
     
       
      




    ],

    ),

    ),


    );


  }
}