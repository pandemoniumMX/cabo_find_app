import 'dart:async';
import 'dart:convert';

import 'package:cabofind/carousel_pro.dart';
import 'package:cabofind/empresa_detalle.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
    home: new Listviewx(),

  ));
}

class Listviewx extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();

}
class Person {
  final String nombre;
  final String etiquetas;
  final String logo;
  final String desc;
  final String maps;
  final String subs;
  final String cat;




  Person(this.nombre,this.etiquetas,this.logo,this.desc,this.maps, this.subs,this.cat);
}
class HomePageState extends State<Listviewx> {

  List data;

  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/get_slider.php"),
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
                            color: Colors.orange)),
                    padding: EdgeInsets.all(
                        20.0),
                    margin: EdgeInsets.all(
                        20.0),

                    child: Column(

                      children: <Widget>[

                        Padding(

                          child: Image.network(

                              data[index]["GAL_FOTO"]
                          ),
                          padding: EdgeInsets.only(
                              bottom: 8.0),
                        ),
                        Row(
                            children: <Widget>[

                              Padding(

                                  child: Text(

                                      data[index]["NEG_NOMBRE"]),
                                  padding: EdgeInsets.all(
                                      1.0)),
                              Text(
                                  " | "),
                              Padding(
                                  child: new Text(
                                      data[index]["NEG_ETIQUETAS"]),
                                  padding: EdgeInsets.all(
                                      1.0)),
                            ]),
                      ],

                    ),

                  ),

                ),

                onTap: () {
                  String nombre_sql = data[index]["NEG_NOMBRE"];
                  String etiquetas_sql = data[index]["NEG_ETIQUETAS"];
                  String foto_sql = data[index]["GAL_FOTO"];
                  String desc_sql = data[index]["NEG_DESCRIPCION"];
                  String mapa_sql = data[index]["NEG_MAP"];
                  String subcat_sql = data[index]["SUB_NOMBRE"];
                  String cat_sql = data[index]["CAT_NOMBRE"];





                  Navigator.push(context, new MaterialPageRoute
                    (builder: (context) => new Empresa_det_fin(person: new Person(nombre_sql,etiquetas_sql,foto_sql,desc_sql,mapa_sql,subcat_sql,cat_sql))
                  )
                  );

                         },
                //A Navigator is a widget that manages a set of child widgets with
                //stack discipline.It allows us navigate pages.
                //Navigator.of(context).push(route);
              );

                  },
    ),

    );
  }
}
