import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/main.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas_ing/publicacion_detalle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class Eventos_ing_grid extends StatefulWidget {
  @override
  Publicacionesfull createState() => new Publicacionesfull();
}

class Publicacionesfull extends State<Eventos_ing_grid> {
  ScrollController _scrollController = new ScrollController();
  int _ultimoItem = 0;
  List<int> _listaNumeros = new List();

  List data;
  List databaja;
  List data_n;
  List data_c;
  DateFormat dateFormat;

  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/ing/list_eventos.php"),
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
    dateFormat = new DateFormat.MMMMd('EN');
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Events'),
      ),
      body: Container(
          //height: 500,
          child: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return data.isNotEmpty
              ? Container(
                  height: 150,
                  padding: EdgeInsets.all(5),
                  child: InkWell(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: 150,
                            width: 200,
                            imageUrl: data[index]["GAL_FOTO_ING"],
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Container(
                              margin: EdgeInsets.only(top: 1),
                              child: Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    child: Text(data[index]["NEG_NOMBRE"],
                                        style: new TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  Flexible(
                                    child: Text(data[index]["PUB_TITULO_ING"],
                                        style: new TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w300,
                                        )),
                                  ),
                                  Row(
                                    children: [
                                      Text('Date: ',
                                          style: new TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      Text(
                                          dateFormat.format(DateTime.parse(
                                              data[index]["PUB_FECHA_LIMITE"])),
                                          overflow: TextOverflow.ellipsis,
                                          style: new TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    onTap: () {
                      String id_n = data[index]["ID_NEGOCIO"];
                      String id = data[index]["ID_PUBLICACION"];

                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  new Publicacion_detalle_fin_ing(
                                    publicacion: new Publicacion(id_n, id),
                                  )));
                    },
                  ),
                )
              : Center(child: Text('Proximamente'));
        },
      )),
    );
  }
}
