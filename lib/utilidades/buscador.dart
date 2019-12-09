import 'dart:convert';
import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/paginas/empresa_detalle_buscador.dart';
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
      home: Buscador(),
    );
  }
}

class Buscador extends StatefulWidget {
Publicacion publicacion;
  @override
  _Buscador createState() => _Buscador();
}

class Note {
  String id_n;
  String title;
  String foto;
  String sub;

  String cat;


  Note(this.title, this.foto,this.id_n,this.sub,this.cat);

  Note.fromJson(Map<String, dynamic> json) {
    id_n = json['NEG_ETIQUETAS'];
    title = json['NEG_NOMBRE'];
    foto = json['GAL_FOTO'];
    sub = json['NEG_LUGAR'];
    cat = json['SUB_NOMBRE'];
  }
}

class _Buscador extends State<Buscador> {

  List<Note> _notes = List<Note>();
  List<Note> _notesForDisplay = List<Note>();

  Future<List<Note>> fetchNotes() async {
    var url = 'http://cabofind.com.mx/app_php/consultas_negocios/esp/list_negocios_bus.php';
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
  List data_neg;


  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/list_negocios_bus.php"),
           // "http://cabofind.com.mx/app_php/APIs/ing/list_negocios_api.php?ID=${widget.publicacion.id_n}"),

          //"http://cabofind.com.mx/app_php/APIs/ing/list_negocios_api.php?ID=${_notesForDisplay[0].id_n}"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          data = json.decode(
              response.body);
        });
    
    return "Success!";
  }

  Future<String> getDataName() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_negocios_api.php?ID=${widget.publicacion.id_n}"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
              data_neg = json.decode(
              response.body);
        });
    print(
        data_neg[0]["NEG_NOMBRE"]);
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
    this.getDataName();
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
/*
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Buscar...'
        ),

        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _notesForDisplay = _notes.where((note) {
              var noteTitle = note.title.toLowerCase();
              //var noteTitle2 = note.id_n.toLowerCase();

              return noteTitle.contains(text);
              // noteTitle2.contains(text);
            }).toList();
          });
         },
      ),
*/

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

              String id_sql = data[index]["ID_NEGOCIO"];
              




              Navigator.push(context, new MaterialPageRoute
                (builder: (context) => new Empresa_det_fin(empresa: new Empresa(id_sql))
              )
              );

      },
    );
  }
}