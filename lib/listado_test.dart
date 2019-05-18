import 'dart:async';
import 'dart:convert';

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

class HomePageState extends State<Listviewx> {

  List data;

  Future<String> getData() async {
    var response = await http.get(
      Uri.encodeFull("http://192.168.1.106/cabofind/app_php/get_slider.php"),
      headers: {
        "Accept": "application/json"
      }
    );

    this.setState(() {
      data = json.decode(response.body);
    });
    print(data[1]["GAL_FOTO"]);
     //print(data[2]["GAL_FOTO"]);
    
    
    
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: 
            new Image.network(data[index]["GAL_FOTO"]),

          );
          
        },
      ),
    );
  }
}