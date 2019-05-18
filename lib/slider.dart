import 'dart:convert';

import 'package:cabofind/carousel_pro.dart';
import 'package:cabofind/main.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class ImageCarousel extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    // TODO: implement build
    return new Scaffold(


      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context,snapshot){
          if(snapshot.hasError)
            print(snapshot.error);
          return snapshot.hasData
              ?new ItemList(list: snapshot.data,)
              :new Center(
            child: new CircularProgressIndicator(),
          );
        },
      ),
    );
  }
  Future<List> getData() async{

    final response=await http.get("http://192.168.1.106/cabofind/app_php/get_slider.php");
    return json.decode(response.body);

  }

}
class ItemList extends StatelessWidget{

  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
      itemCount: list==null?0:list.length,
      itemBuilder: (context,i){
        return new ListTile(
          title: new Text(list[i]['NEG_NOMBRE']),
          subtitle: new Text(list[i]['NEG_RAZONSOCIAL']),
          leading: new Icon(Icons.http
        ),

          onTap:()=> Navigator.of(context).push(
              new MaterialPageRoute(
               // builder: (BuildContext context)=>new Details(list: list,index: i),

              )
          ),
        );
      },
    );
  }
}


