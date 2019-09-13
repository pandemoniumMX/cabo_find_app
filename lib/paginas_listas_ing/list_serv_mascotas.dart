 import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/main.dart';
import 'package:cabofind/paginas_ing/empresa_detalle.dart';
import 'package:http/http.dart' as http;

import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(new MaterialApp(
    home: new ListaMascotas_ing(),

  ));
}

class ListaMascotas_ing extends StatefulWidget {
  @override
  _ListaOriental createState() => new _ListaOriental();

}

class _ListaOriental extends State<ListaMascotas_ing> {

  List data;
List databaja;

  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/ing/servicios/list_servicios_mascotas.php"),
       
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

  Future<String> getDatabaja() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/ing/servicios/list_servicios_mascotas_baja.php"),
       
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          databaja = json.decode(
              response.body);
        });
    print(
        databaja[0]["NEG_NOMBRE"]);


    return "Success!";
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
                        right: 0.0,
                        bottom: 160.0,
                        child: new FloatingActionButton(
                          child: new Image.asset(
                        "assets/premium.png",
                        fit: BoxFit.cover,
                        width: 50.0,
                        height: 50.0,

                      ),
                          backgroundColor: Colors.white,
                           onPressed: (){},

                        ),
                      ),
                            ]
              ),

               
                  Row(
                      children: <Widget>[

                        Padding(

                            child: Text(

                                data[index]["SUB_NOMBRE_ING"]),
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
            String nombre_sql = data[index]["NEG_NOMBRE"];
            String cat_sql = data[index]["CAT_NOMBRE_ING"];
            String subcat_sql = data[index]["SUB_NOMBRE_ING"];
            String foto_sql = data[index]["GAL_FOTO"];
            String etiquetas_sql = data[index]["NEG_ETIQUETAS"];
            String desc_sql = data[index]["NEG_DESCRIPCION_ING"];
            String mapa_sql = data[index]["NEG_MAP"];
            String fb_sql = data[index]["NEG_FACEBOOK"];
            String ins_sql = data[index]["NEG_INSTAGRAM"];
            String web_sql = data[index]["NEG_WEB"];
            String tel = data[index]["NEG_TEL"];
            String cor = data[index]["NEG_CORREO"];
            String hor = data[index]["NEG_HORARIO_ING"];




            Navigator.push(context, new MaterialPageRoute
              (builder: (context) => new Empresa_det_fin_ing(empresa: new Empresa(id_sql,nombre_sql,cat_sql,subcat_sql,foto_sql,etiquetas_sql,desc_sql,mapa_sql,fb_sql,ins_sql,web_sql,tel,cor,hor))
            )
            );

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

                  FadeInImage(

                    image: NetworkImage(databaja[index]["GAL_FOTO"]),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 220,

                    // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                    placeholder: AssetImage('android/assets/images/loading.gif'),
                    fadeInDuration: Duration(milliseconds: 200),

                  ),
                  Row(
                      children: <Widget>[

                        Padding(

                            child: Text(

                                databaja[index]["SUB_NOMBRE_ING"]),
                            padding: EdgeInsets.all(
                                1.0)),
                        Text(
                            " | "),
                        Padding(
                            child: new Text(
                                databaja[index]["NEG_NOMBRE"]),
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

          ),

          onTap: () {
            String id_sql = databaja[index]["ID_NEGOCIO"];
            String nombre_sql = databaja[index]["NEG_NOMBRE"];
            String cat_sql = databaja[index]["CAT_NOMBRE_ING"];
            String subcat_sql = databaja[index]["SUB_NOMBRE_ING"];
            String foto_sql = databaja[index]["GAL_FOTO"];
            String etiquetas_sql = databaja[index]["NEG_ETIQUETAS"];
            String desc_sql = databaja[index]["NEG_DESCRIPCION_ING"];
            String mapa_sql = databaja[index]["NEG_MAP"];
            String fb_sql = databaja[index]["NEG_FACEBOOK"];
            String ins_sql = databaja[index]["NEG_INSTAGRAM"];
            String web_sql = databaja[index]["NEG_WEB"];
            String tel = databaja[index]["NEG_TEL"];
            String cor = databaja[index]["NEG_CORREO"];
            String hor = databaja[index]["NEG_HORARIO_ING"];




            Navigator.push(context, new MaterialPageRoute
              (builder: (context) => new Empresa_det_fin_ing(empresa: new Empresa(id_sql,nombre_sql,cat_sql,subcat_sql,foto_sql,etiquetas_sql,desc_sql,mapa_sql,fb_sql,ins_sql,web_sql,tel,cor,hor))
            )
            );

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
