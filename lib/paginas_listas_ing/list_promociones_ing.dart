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

class Promociones_ing extends StatefulWidget {
  @override
  _Promociones_ing createState() => new _Promociones_ing();
}

class _Promociones_ing extends State<Promociones_ing> {
  ScrollController _scrollController = new ScrollController();
  int _ultimoItem = 0;
  List<int> _listaNumeros = new List();

  List data;
  List databaja;
  List data_n;
  List data_c;

  //final List<Todo> todos;
  Future<String> getDatas() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/ing/list_promociones.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getDatas();
  }

  Widget build(BuildContext context) {
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
            String id = data[index]["ID_PUBLICACION"];

            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Publicacion_detalle_fin_ing(
                          publicacion: new Publicacion(id_n, id),
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
