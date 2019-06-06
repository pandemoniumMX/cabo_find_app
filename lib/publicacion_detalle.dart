import 'dart:async';
import 'dart:convert';
import 'package:cabofind/empresa_detalle.dart';
import 'package:cabofind/publicaciones.dart';
import 'package:http/http.dart' as http;
import 'package:cabofind/listado_test.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Publicacion_detalle extends StatefulWidget {
@override
_Publicacion_detalle createState() => new _Publicacion_detalle();
}


class _Publicacion_detalle extends State<Publicacion_detalle> {
  String url = 'https://randomuser.me/api/?results=15';
  List data;
  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var extractdata = json.decode(response.body);
      data = extractdata["results"];
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
  void initState() {
    this.makeRequest();
  }
}



class Publicacion_detalle_fin extends StatelessWidget {
  List data;

  Widget setupAlertDialoadContainer() {

    return Container(
        height: 300.0, // Change as per your requirement
        width: 300.0,
        child: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, i) {
              return new ListTile(
                title: new Text(data[i]["name"]),
              );
            }
        )
    );
  }

  // Declare a field that holds the Person data
  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Lista de caracteristicas'),
            content: setupAlertDialoadContainer()

          );
        });
  }
  // Declare a field that holds the Person data
  final Publicacion public;

  // In the constructor, require a Person
  Publicacion_detalle_fin({Key key, @required this.public}) : super(
      key: key);
  @override



 Widget build(BuildContext context){
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    '${public.nombre}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        fontSize: 20.0

                    ),
                  ),

                ),
                Text(
                  '${public.cat}-${public.subs}',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),

              ],
            ),
          ),
          /*3*/

          Text(
            'Rango de precios:',
            style: TextStyle(
              color: Colors.blue[500],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('101'),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget textSection = Container(
      padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
      child: Text(
        '${public.desc}',
        softWrap: true,
      ),

    );

    return new Scaffold(

        body: ListView(
          //scrollDirection: Axis.horizontal,
          children: [
            Image.network('${public.logo}',width: 400,height: 300, ),
            //Image.asset('android/assets/images/img1.jpg',width: 600,height: 240,fit: BoxFit.cover,),
            //loading,
            titleSection,
            textSection,


          ],
        ),
        appBar: new AppBar(
          title: new Text(
    '${public.nombre}',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0

    ),

        ),

    )
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}