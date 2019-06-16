import 'dart:async';
import 'dart:convert';
import 'package:cabofind/empresa_detalle.dart';
import 'package:cabofind/publicaciones.dart';
import 'package:http/http.dart' as http;
import 'package:cabofind/classes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

<<<<<<< HEAD
=======
class Publicacion_detalle extends StatefulWidget {
@override
_Publicacion_detalle createState() => new _Publicacion_detalle();
}


class _Publicacion_detalle extends State<Publicacion_detalle> {
  String url = 'https://randomuser.me/api/?results=15';
  List data;



  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/list_vida_antros.php"),

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


>>>>>>> parent of dfdad5f... cambios estrucutra empresa detalle

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
  final Publicacion publicacion;
  final Empresa empresa;


  // In the constructor, require a Person
  Publicacion_detalle_fin({Key key, @required this.publicacion, this.empresa}) : super(
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
                    '${publicacion.titulo}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        fontSize: 20.0

                    ),
                  ),

                ),
                Text(
                  '${publicacion.titulo}-${publicacion.fec}',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),

              ],
            ),
          ),
          /*3*/
/*
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
          */

        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget textSection = Center(

      child: Text(
        '${publicacion.det}',
        softWrap: true,
      ),


    );

    Widget boton = Container(
      padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
      child: RaisedButton(

        //child: Text(‘Send data to the second page’),
        onPressed: () {
          //int id = '${empresa.id}';
          String nombre = '${empresa.nombre}';
          String cat = '${empresa.cat}';
          String subs = '${empresa.subs}';
          String logo = '${empresa.logo}';
          String etiquetas = '${empresa.etiquetas}';
          String desc = '${empresa.desc}';
          String maps = '${empresa.maps}';




          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new Empresa_det_fin(empresa: Empresa(nombre, cat, subs, logo, etiquetas, desc, maps)),

            )
          );
        },
      ),

    );


    return new Scaffold(

        body: ListView(
          //scrollDirection: Axis.horizontal,
          children: [
            Image.network('${publicacion.logo}',width: MediaQuery.of(context).size.width,height: 300,fit: BoxFit.cover ),
            //Image.asset('android/assets/images/img1.jpg',width: 600,height: 240,fit: BoxFit.cover,),
            //loading,
            titleSection,
            textSection,
            boton,


          ],
        ),
        appBar: new AppBar(
          title: new Text(
    '${publicacion.nombre}',
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