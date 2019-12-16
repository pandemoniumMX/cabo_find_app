import 'dart:convert';
import 'package:cabofind/paginas/anuncios_detalle.dart';
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
      home: Buscador_market(),
    );
  }
}

class Buscador_market extends StatefulWidget {
Publicacion publicacion;
  @override
  _Buscador createState() => _Buscador();
}

class Note {
  String id_n;
      String id_etiquetas;

  String title;
  String foto;
  String sub;

  String cat;
  String id;



  Note(this.title, this.foto,this.id_n,this.sub,this.cat,this.id, this.id_etiquetas);

  Note.fromJson(Map<String, dynamic> json) {
    id_n = json['ANUN_ETIQUETAS'];
    title = json['ANUN_TITULO'];
    foto = json['GAL_FOTO'];
    sub = json['ANUN_LUGAR'];
    cat = json['ANUN_CATEGORIA'];
    id = json['ID_ANUNCIOS'];


  }
}

class _Buscador extends State<Buscador_market> {

  List<Note> _notes = List<Note>();
  List<Note> _notesForDisplay = List<Note>();

  Future<List<Note>> fetchNotes() async {
    var url = 'http://cabofind.com.mx/app_php/consultas_negocios/esp/list_anuncios_bus.php';
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




  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
        _notesForDisplay = _notes;
      });
    });
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text('Buscador Marketplace'),
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
            hintText: 'Buscar en marketplace...'
        ),

        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _notesForDisplay = _notes.where((note) {
             // var noteTitle = note.title.toLowerCase();
              var noteTitle = note.id_n.toLowerCase();

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

        backgroundImage: NetworkImage(_notesForDisplay[index].foto,)


      ),
      title: Text(
        _notesForDisplay[index].title,
        style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        _notesForDisplay[index].sub,
        style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        _notesForDisplay[index].cat,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),








      onTap: () {

              String id_sql = _notesForDisplay[index].id;
              




              Navigator.push(context, new MaterialPageRoute
                (builder: (context) => new Anuncios_detalle(anuncio: new Anuncios_clase(id_sql))
              )
              );

      },
    );
  }
}