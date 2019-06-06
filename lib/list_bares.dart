import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cabofind/carousel_pro.dart';
import 'package:cabofind/empresa_detalle.dart';
import 'package:cabofind/listado_test.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(new MaterialApp(
    home: new ListaBares(),

  ));
}

class ListaBares extends StatefulWidget {
  @override
  ListaBaresFull createState() => new ListaBaresFull();

}

class ListaBaresFull extends State<ListaBares> {

  List data;

  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/fotos.php"),
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
  }
}