import 'dart:convert';
import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/paginas/empresa_detalle_buscador.dart';
import 'package:cabofind/paginas_ing/empresa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(Appx());

class Appx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Buscador_ing(),
    );
  }
}

class Buscador_ing extends StatefulWidget {
  Publicacion publicacion;
  @override
  _Buscador_ing createState() => _Buscador_ing();
}

class Note {
  String id_n;
  String id_etiquetas;

  String title;
  String foto;
  String sub;

  String cat;
  String id;

  Note(this.title, this.foto, this.id_n, this.sub, this.cat, this.id,
      this.id_etiquetas);

  Note.fromJson(Map<String, dynamic> json) {
    id_n = json['NEG_ETIQUETAS'];
    title = json['NEG_NOMBRE'];
    foto = json['GAL_FOTO'];
    sub = json['NEG_LUGAR'];
    cat = json['SUB_NOMBRE_ING'];
    id = json['ID_NEGOCIO'];
    id_etiquetas = json['NEG_ETIQUETAS_ING'];
  }
}

class _Buscador_ing extends State<Buscador_ing> {
  List<Note> _notes = List<Note>();
  List<Note> _notesForDisplay = List<Note>();

  Future<List<Note>> fetchNotes() async {
    var url =
        'http://cabofind.com.mx/app_php/consultas_negocios/esp/list_negocios_bus_ing.php';
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

  Future<String> getDataName() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_negocios_api.php?ID=${widget.publicacion.id_n}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data_neg = json.decode(response.body);
    });
    print(data_neg[0]["NEG_NOMBRE"]);
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

    this.getDataName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search Cabofind'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return index == 0 ? _searchBar() : _listItem(index - 1);
          },
          itemCount: _notesForDisplay.length + 1,
        ));
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: 'Search...'),
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
          backgroundImage: NetworkImage(
        _notesForDisplay[index].foto,
      )),
      title: Text(
        _notesForDisplay[index].title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        _notesForDisplay[index].sub,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        _notesForDisplay[index].cat,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        String id_sql = _notesForDisplay[index].id;

        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    new Empresa_det_fin_ing(empresa: new Empresa(id_sql))));
      },
    );
  }
}
