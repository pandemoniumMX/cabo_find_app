import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Buscador2 extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class Posts {
  final String id_nm;
  final String nombre;
  final String cat;
  final String subs;
  final String logo;
  final String etiquetas;
  final String desc;
  final String maps;
  final String fb;
  final String inst;
  final String web;
  final String tel;
  final String cor;
  final String hor;

  Posts({this.id_nm,this.nombre,this.cat,this.subs,this.logo,this.etiquetas, this.desc,this.maps, this.fb,this.inst,this.web,this.tel,this.cor,this.hor});


 //Posts({this.userId, this.id, this.title, this.body});

  factory Posts.formJson(Map <String, dynamic> json){
    return new Posts(
       id_nm: json['ID_NEGOCIO'],
       nombre: json['NEG_NOMBRE'],
       etiquetas: json['NEG_ETIQUETAS'],
       cat: json['CAT_NOMBRE'],
    );
  }
}

class _HomeState extends State<Buscador2> {
  List<Posts> _list = [];
  List<Posts> _search = [];
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
          _list.add(Posts.formJson(i));
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
      if (f.id_nm.contains(text) || f.etiquetas.toString().contains(text))
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
                              return ListTile(title: Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        b.nombre,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                    ],
                                  )),);

                             
                              
                            },
                          )
                        : ListView.builder(
                            itemCount: _list.length,
                            itemBuilder: (context, i) {

                              final a = _list[i];

                              return ListTile(
                            title:  Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        a.nombre,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(a.cat),
                                    ],
                                  )
                                  
                                  ),
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