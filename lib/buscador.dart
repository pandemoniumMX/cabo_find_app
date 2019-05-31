import 'dart:convert';

import 'package:cabofind/empresa_detalle.dart';
import 'package:cabofind/listado_test.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePagex(),
    );
  }
}

class HomePagex extends StatefulWidget {

  @override
  _HomePagex createState() => _HomePagex();
}

class Note {
  String title;
  String text;

  Note(this.title, this.text);

  Note.fromJson(Map<String, dynamic> json) {
    title = json['NEG_NOMBRE'];
    text = json['NEG_ETIQUETAS'];

  }
}

class _HomePagex extends State<HomePagex> {

  List<Note> _notes = List<Note>();
  List<Note> _notesForDisplay = List<Note>();

  Future<List<Note>> fetchNotes() async {
    var url = 'http://cabofind.com.mx/app_php/get_empresas.php';
    var response = await http.get(url);

    var notes = List<Note>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Note.fromJson(noteJson));
      }
    }
    return notes;
  }

  List data;

  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/get_slider.php"),
        // "https://cabofind.com.mx/app_php/get_slider.php"),

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
  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
        _notesForDisplay = _notes;
      });
    });
    super.initState();

    super.initState(
    );
    this.getData(
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text('Buscador CaboFind'),
        ),

        body: ListView.builder(

          itemBuilder: (context, index) {

             return index == 0 ?  _searchBar() : _listItem(index-1);

          },
          itemCount: _notesForDisplay.length+1,
        )

        );

  }

  Widget loading = Center(
    child: new CircularProgressIndicator(),

  );

  _searchBar() {

    return Padding(

      padding: const EdgeInsets.all(8.0),

      child: TextField(
        decoration: InputDecoration(
            hintText: 'Buscar...'
        ),

        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _notesForDisplay = _notes.where((note) {
              var noteTitle = note.title.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
         },
      ),


    );
      }


  _listItem(index) {
    return new ListTile(

    title: new Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _notesForDisplay[index].title,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              _notesForDisplay[index].text,
              style: TextStyle(


                  color: Colors.grey.shade600
              ),
            ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 0.0, bottom: 0.0, left: 260.0, right: 0.0),

                child: Image.network(

                  data[index]["GAL_FOTO"],
                  width: 200.0,
                  height: 100.0,
                ),

              ),
            ],

          )

          ],
        ),
      ),

    ),
      onTap: () {

        int id_sql = data[index]["ID_NEGOCIO"];

        String nombre_sql = data[index]["NEG_NOMBRE"];
        String etiquetas_sql = data[index]["NEG_ETIQUETAS"];
        String foto_sql = data[index]["GAL_FOTO"];
        String desc_sql = data[index]["NEG_DESCRIPCION"];
        String mapa_sql = data[index]["NEG_MAP"];
        String subcat_sql = data[index]["SUB_NOMBRE"];
        String cat_sql = data[index]["CAT_NOMBRE"];


        Navigator.push(context, new MaterialPageRoute
          (builder: (context) => new Empresa_det_fin(person: Person(id_sql,nombre_sql,etiquetas_sql,foto_sql,desc_sql,mapa_sql,subcat_sql,cat_sql))
        )

        );

      },
    );
  }
}