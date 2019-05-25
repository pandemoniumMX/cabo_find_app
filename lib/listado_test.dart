import 'dart:async';
import 'dart:convert';

import 'package:cabofind/carousel_pro.dart';
import 'package:cabofind/descubre.dart';
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
  final String name;
  final String age;
  final String foto;


  Person(this.name, this.age,this.foto);
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
                              data[index]["GAL_FOTO"]),
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
                  String idempresa = data[index]["NEG_NOMBRE"];
                  String userName2 = data[index]["NEG_ETIQUETAS"];
                  String foto = data[index]["GAL_FOTO"];

                  Navigator.push(context, new MaterialPageRoute
                    (builder: (context) => new Empresa_det_fin(person: new Person(idempresa,userName2,foto))
                  )
                  );
                },
                //A Navigator is a widget that manages a set of child widgets with
                //stack discipline.It allows us navigate pages.
                //Navigator.of(context).push(route);
              );
            }
        )

    );
  }
}
