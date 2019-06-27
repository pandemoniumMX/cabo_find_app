import 'dart:convert';

import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: Buscador_not(),
    debugShowCheckedModeBanner: false,
  ));
}

class Buscador_not extends StatefulWidget {
  @override
  _Buscador createState() => _Buscador();
}

class Note {
  String id_n;
  String title;
  String foto;

  Note(this.title, this.foto,this.id_n);

  Note.fromJson(Map<String, dynamic> json) {
    id_n = json['NEG_ETIQUETAS'];
    title = json['NEG_NOMBRE'];
    foto = json['GAL_FOTO'];
  }
}

class _Buscador extends State<Buscador_not> {
  Empresa empresa;
  List data;
  List<Note> _list = [];
  List<Note> _search = [];
  var loading = false;
  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });
    _list.clear();
    final response =
    await http.get("http://cabofind.com.mx/app_php/consultas_negocios/esp/list_negocios_bus.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(Note.fromJson(i));
          loading = false;
        }
      });
    }
  }

  TextEditingController controller = new TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _list.forEach((f) {
      if (f.title.contains(text) || f.id_n.toString().contains(text))
        _search.add(f);
    });

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.blue,
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                    controller: controller,
                    onChanged: onSearch,
                    decoration: InputDecoration(
                        hintText: "Search", border: InputBorder.none),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      controller.clear();
                      onSearch('');
                    },
                    icon: Icon(Icons.cancel),
                  ),
                ),
              ),
            ),
            loading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Expanded(
              child: _search.length != 0 || controller.text.isNotEmpty
                  ? ListView.builder(
                itemCount: _search.length,
                itemBuilder: (context, i) {
                  final b = _search[i];
                  return Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            b.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(b.id_n),
                          IconButton(
                            icon: ( Icon(Icons.star_border)),
                            color: Colors.red[500],
                            onPressed:() {
                              String id_sql = data[i]["ID_NEGOCIO"];
                              String nombre_sql = data[i]["NEG_NOMBRE"];
                              String cat_sql = data[i]["CAT_NOMBRE"];
                              String subcat_sql = data[i]["SUB_NOMBRE"];
                              String foto_sql = data[i]["GAL_FOTO"];
                              String etiquetas_sql = data[i]["NEG_ETIQUETAS"];
                              String desc_sql = data[i]["NEG_DESCRIPCION"];
                              String mapa_sql = data[i]["NEG_MAP"];
                              String fb_sql = data[i]["NEG_FACEBOOK"];
                              String ins_sql = data[i]["NEG_INSTAGRAM"];
                              String web_sql = data[i]["NEG_WEB"];
                              String tel = data[i]["NEG_TEL"];
                              String cor = data[i]["NEG_CORREO"];


                              Navigator.push(
                                  context, new MaterialPageRoute
                                (
                                  builder: (context) =>
                                  new Empresa_det_fin(
                                      empresa: new Empresa(
                                          id_sql,
                                          nombre_sql,
                                          cat_sql,
                                          subcat_sql,
                                          foto_sql,
                                          etiquetas_sql,
                                          desc_sql,
                                          mapa_sql,
                                          fb_sql,
                                          ins_sql,
                                          web_sql,
                                          tel,
                                          cor))
                              )
                              );
                            }
                            ,
                          ),

                        ],
                      ));
                },
              )
                  : ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, i) {
                  final a = _list[i];
                  return Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            a.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(a.title),
                          IconButton(
                            icon: ( Icon(Icons.star_border)),
                            color: Colors.red[500],
                            onPressed:() {
                              String id_sql = data[i]["ID_NEGOCIO"];
                              String nombre_sql = data[i]["NEG_NOMBRE"];
                              String cat_sql = data[i]["CAT_NOMBRE"];
                              String subcat_sql = data[i]["SUB_NOMBRE"];
                              String foto_sql = data[i]["GAL_FOTO"];
                              String etiquetas_sql = data[i]["NEG_ETIQUETAS"];
                              String desc_sql = data[i]["NEG_DESCRIPCION"];
                              String mapa_sql = data[i]["NEG_MAP"];
                              String fb_sql = data[i]["NEG_FACEBOOK"];
                              String ins_sql = data[i]["NEG_INSTAGRAM"];
                              String web_sql = data[i]["NEG_WEB"];
                              String tel = data[i]["NEG_TEL"];
                              String cor = data[i]["NEG_CORREO"];


                              Navigator.push(
                                  context, new MaterialPageRoute
                                (
                                  builder: (context) =>
                                  new Empresa_det_fin(
                                      empresa: new Empresa(
                                          id_sql,
                                          nombre_sql,
                                          cat_sql,
                                          subcat_sql,
                                          foto_sql,
                                          etiquetas_sql,
                                          desc_sql,
                                          mapa_sql,
                                          fb_sql,
                                          ins_sql,
                                          web_sql,
                                          tel,
                                          cor))
                              )
                              );
                            }
                            ,
                          ),
                        ],
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}