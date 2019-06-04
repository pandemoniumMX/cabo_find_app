import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cabofind/carousel_pro.dart';
import 'package:cabofind/empresa_detalle.dart';
import 'package:cabofind/listado_test.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(new MaterialApp(
    home: new Publicaciones(),

  ));
}

class Publicaciones extends StatefulWidget {
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
        // "https://cabofind.com.mx/app_php/get_slider.php"),

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

    print(
        data[2]["GAL_FOTO"]);

    return "Success!";
  }

  @override
  void initState() {
    super.initState(
    );
    this.getData(
    );
  }
  Widget loading = Center(
    child: new CircularProgressIndicator(),

  );



  Widget build(BuildContext context) {

    return new Scaffold(

      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {

          return new ListTile(


            title: new Card(

              elevation: 5.0,
              child: new Container(


                decoration: BoxDecoration(
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

                            data[index]["PUB_TITULO"]),
                        padding: EdgeInsets.all(
                            1.0)

                    ),
                    Padding(

                      child: Image.network(
                        data[index]["GAL_FOTO"],
                        fit: BoxFit.cover,
                        height: 180.0,
                        width: 400.0,
                      ),
                      padding: EdgeInsets.only(
                          bottom: 10.0),
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
              int id_sql = data[index]["ID_NEGOCIO"];

              String nombre_sql = data[index]["NEG_NOMBRE"];
              String cat_sql = data[index]["CAT_NOMBRE"];
              String subcat_sql = data[index]["SUB_NOMBRE"];
              String foto_sql = data[index]["GAL_FOTO"];
              String etiquetas_sql = data[index]["NEG_ETIQUETAS"];
              String desc_sql = data[index]["NEG_DESCRIPCION"];
              String mapa_sql = data[index]["NEG_MAP"];




              Navigator.push(context, new MaterialPageRoute
                (builder: (context) => new Empresa_det_fin(person: new Person(id_sql,nombre_sql,cat_sql,subcat_sql,foto_sql,etiquetas_sql,desc_sql,mapa_sql))
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
  }
}