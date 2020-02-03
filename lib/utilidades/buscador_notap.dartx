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
    await http.get("http://cabofind.com.mx/app_php/consultas_negocios/esp/list_negocios.php");
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
                itemBuilder: (context, index) {
                  final b = _search[index];

                                      return ListTile(
                        title: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              b.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),

                           

                          ],
                        ),
                                        onTap: () {

                                          String id_sql = data[index]["ID_NEGOCIO"];
                                          




                                          Navigator.push(context, new MaterialPageRoute
                                            (builder: (context) => new Empresa_det_fin(empresa: new Empresa(id_sql))
                                          )
                                          );

                                        },
                  );
                },
              )
                  : ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  final a = _list[index];
                  return ListTile(
                      //padding: EdgeInsets.all(10.0),
                      title: Column(
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

                        ],
                      ),
                      onTap: () {

                    String id_sql = data[index]["ID_NEGOCIO"];
                   



                    Navigator.push(context, new MaterialPageRoute
                      (builder: (context) => new Empresa_det_fin(empresa: new Empresa(id_sql))
                    )
                    );

                  },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}