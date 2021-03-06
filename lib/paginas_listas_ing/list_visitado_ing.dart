import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/main.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas_ing/publicacion_detalle.dart';
import 'package:http/http.dart' as http;

import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';

class Recomendado_visitado_ing extends StatefulWidget {
  @override
  Promocionesfull createState() => new Promocionesfull();
}

class Promocionesfull extends State<Recomendado_visitado_ing> {
  ScrollController _scrollController = new ScrollController();
  int _ultimoItem = 0;
  List<int> _listaNumeros = new List();

  List data;
  List databaja;
  List data_n;
  List data_c;

  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/ing/list_visitado.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Widget build(BuildContext context) {
    final Widget carrusel = Container(
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            padding: EdgeInsets.only(left: 5.0, right: 1.0),
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

    Widget publicaciones = ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: new Card(
            elevation: 5.0,
            child: new Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black)),
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    child: new Text(
                      data[index]["PUB_TITULO_ING"],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                    padding: EdgeInsets.all(1.0),
                  ),
                  FadeInImage(
                    image: NetworkImage(data[index]["GAL_FOTO_ING"]),
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                    // placeholder: AssetImage('android/assets/images/loading.gif'),
                    placeholder:
                        AssetImage('android/assets/images/loading.gif'),
                    fadeInDuration: Duration(milliseconds: 200),
                  ),
                  Row(children: <Widget>[
                    Padding(
                        child: Text(data[index]["CAT_NOMBRE_ING"]),
                        padding: EdgeInsets.all(1.0)),
                    Text(" | "),
                    Padding(
                        child: new Text(data[index]["NEG_NOMBRE"]),
                        padding: EdgeInsets.all(1.0)),
                    Text(" | "),
                    Flexible(
                      child: new Text(
                        data[index]["CIU_NOMBRE"],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),

          onTap: () {
            String id_n = data[index]["ID_NEGOCIO"];
            String id_p = data[index]["ID_PUBLICACION"];

            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Publicacion_detalle_fin_ing(
                          publicacion: new Publicacion(id_n, id_p),
                        )));
          },
          //A Navigator is a widget that manages a set of child widgets with
          //stack discipline.It allows us navigate pages.
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
              children: <Widget>[publicaciones],
            ),
          ],
        ),
      ),
    );
  }
}
