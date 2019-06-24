import 'dart:convert';
import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
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
      home: Buscador_ing(),
    );
  }
}

class Buscador_ing extends StatefulWidget {

  @override
  _Buscador_ing createState() => _Buscador_ing();
}

class Note {
  String title;
  String foto;

  Note(this.title, this.foto);

  Note.fromJson(Map<String, dynamic> json) {
    title = json['NEG_NOMBRE'];
    foto = json['GAL_FOTO'];

  }
}

class _Buscador_ing extends State<Buscador_ing> {

  List<Note> _notes = List<Note>();
  List<Note> _notesForDisplay = List<Note>();

  Future<List<Note>> fetchNotes() async {
    var url = 'http://cabofind.com.mx/app_php/list_negocios.php';
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
            "http://cabofind.com.mx/app_php/list_negocios.php"),
       
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

  _searchBar() {

    return Padding(

      padding: const EdgeInsets.all(8.0),

      child: TextField(
        decoration: InputDecoration(
            hintText: 'Search...'
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
    return ListTile(
      leading: CircleAvatar(

        backgroundImage: NetworkImage(data[index]["GAL_FOTO"])


      ),
      title: Text(
        _notesForDisplay[index].title,
        style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold
        ),

      ),



      onTap: () {

       // int id_sql = data[index]["ID_NEGOCIO"];
              String id_sql = data[index]["ID_NEGOCIO"];
              String nombre_sql = data[index]["NEG_NOMBRE"];
              String cat_sql = data[index]["CAT_NOMBRE"];
              String subcat_sql = data[index]["SUB_NOMBRE"];
              String foto_sql = data[index]["GAL_FOTO"];
              String etiquetas_sql = data[index]["NEG_ETIQUETAS"];
              String desc_sql = data[index]["NEG_DESCRIPCION"];
              String mapa_sql = data[index]["NEG_MAP"];
              String fb_sql = data[index]["NEG_FACEBOOK"];
              String ins_sql = data[index]["NEG_INSTAGRAM"];
              String web_sql = data[index]["NEG_WEB"];






              Navigator.push(context, new MaterialPageRoute
                (builder: (context) => new Empresa_det_fin(empresa: new Empresa(id_sql,nombre_sql,cat_sql,subcat_sql,foto_sql,etiquetas_sql,desc_sql,mapa_sql,fb_sql,ins_sql,web_sql))
              )
              );

      },
    );
  }
}