import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/anuncios_detalle.dart';
import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/main.dart';
import 'package:cabofind/paginas_ing/anuncios_detalle.dart';
import 'package:http/http.dart' as http;

import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new Lista_anun_inmueble_ing(),
  ));
}

class Lista_anun_inmueble_ing extends StatefulWidget {
  @override
  _ListaAcuaticas createState() => new _ListaAcuaticas();
}

class _ListaAcuaticas extends State<Lista_anun_inmueble_ing> {
  List data;
  List databaja;

  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/ing/anuncios/list_anuncios_inmuebles.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> getDatabaja() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/ing/anuncios/list_anuncios_inmuebles_baja.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      databaja = json.decode(response.body);
    });

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
    this.getDatabaja();
  }

  @override
  void dispose() {
    // _audioPlayer?.dipose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Widget listado = ListView.builder(
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
                  border: Border.all(color: Colors.lightBlueAccent)),
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Stack(children: <Widget>[
                    FadeInImage(
                      image: NetworkImage(data[index]["GAL_FOTO_ING"]),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 220,

                      // placeholder: AssetImage('android/assets/images/loading.gif'),
                      placeholder:
                          AssetImage('android/assets/images/loading.gif'),
                      fadeInDuration: Duration(milliseconds: 200),
                    ),
                    Positioned(
                      right: 0.0,
                      bottom: 160.0,
                      child: new FloatingActionButton(
                        child: new Image.asset(
                          "assets/premium1.png",
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 50.0,
                        ),
                        backgroundColor: Colors.transparent,
                        onPressed: () {},
                      ),
                    ),
                  ]),
                  Row(children: <Widget>[
                    Padding(
                        child: Text(
                          data[index]["ANUN_LUGAR"],
                          overflow: TextOverflow.ellipsis,
                        ),
                        padding: EdgeInsets.all(1.0)),
                    Text(" | "),
                    Padding(
                        child: new Text(
                          data[index]["ANUN_PRECIO_USD"],
                          overflow: TextOverflow.ellipsis,
                        ),
                        padding: EdgeInsets.all(1.0)),
                    Text(" | "),
                    Flexible(
                      child: new Text(
                        data[index]["ANUN_ESTADO_ING"],
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
            String id_sql = data[index]["ID_ANUNCIOS"];
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Anuncios_detalle_ing(
                        anuncio: new Anuncios_clase(id_sql))));
          },
          //A Navigator is a widget that manages a set of child widgets with
          //stack discipline.It allows us navigate pages.
          //Navigator.of(context).push(route);
        );
      },
    );

    Widget listadobaja = ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: databaja == null ? 0 : databaja.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: new Card(
            elevation: 5.0,
            child: new Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.lightBlueAccent)),
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  FadeInImage(
                    image: NetworkImage(databaja[index]["GAL_FOTO_ING"]),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 220,

                    // placeholder: AssetImage('android/assets/images/loading.gif'),
                    placeholder:
                        AssetImage('android/assets/images/loading.gif'),
                    fadeInDuration: Duration(milliseconds: 200),
                  ),
                  Row(children: <Widget>[
                    Padding(
                        child: Text(
                          databaja[index]["ANUN_LUGAR"],
                          overflow: TextOverflow.ellipsis,
                        ),
                        padding: EdgeInsets.all(1.0)),
                    Text(" | "),
                    Padding(
                        child: new Text(
                          databaja[index]["ANUN_PRECIO_USD"],
                          overflow: TextOverflow.ellipsis,
                        ),
                        padding: EdgeInsets.all(1.0)),
                    Text(" | "),
                    Flexible(
                      child: new Text(
                        databaja[index]["ANUN_ESTADO_ING"],
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
            String id_sql = databaja[index]["ID_ANUNCIOS"];
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Anuncios_detalle_ing(
                        anuncio: new Anuncios_clase(id_sql))));
          },
          //A Navigator is a widget that manages a set of child widgets with
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
              children: <Widget>[listado, listadobaja],
            ),
          ],
        ),
      ),
    );
  }
}
