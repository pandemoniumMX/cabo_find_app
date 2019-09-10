import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/main.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:http/http.dart' as http;

import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';




class Promociones_grid extends StatefulWidget {
   


  @override
  Publicacionesfull createState() => new Publicacionesfull();

}


class Publicacionesfull extends State<Promociones_grid> {
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


      return new Scaffold(

    body: Container(
     // height: MediaQuery.of(context).size.height,
    child: new  StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount:data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) => new Container(
          //color: Colors.white,
        child: InkWell(
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
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.38,

                // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                placeholder: AssetImage('android/assets/images/loading.gif'),
                fadeInDuration: Duration(milliseconds: 200),

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
        ),

      ),

      staggeredTileBuilder: (int index) =>
      new StaggeredTile.count(2, index.isEven ? 3 : 3),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    ),

    ),


    );


  }
}