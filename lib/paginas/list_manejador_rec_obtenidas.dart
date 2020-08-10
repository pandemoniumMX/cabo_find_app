import 'dart:convert';
import 'package:cabofind/paginas/cupones_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'cupones_detalle_ob.dart';

class Mis_promos_manejador_obtenidas extends StatefulWidget {
  @override
  _Mis_promos_manejador_obtenidasState createState() =>
      _Mis_promos_manejador_obtenidasState();
}

class _Mis_promos_manejador_obtenidasState
    extends State<Mis_promos_manejador_obtenidas> {
  List data;

  Future<Map> _loadUserx() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_cupones_api_single2.php?IDF=$_mail2"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });
  }

  Future<Map> _loaduser() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/list_cupones_api.php?IDF=$_mail2");
    return json.decode(response.body);
  }

  void initState() {
    super.initState();
    this._loadUserx();
  }

  @override
  Widget build(BuildContext context) {
    Widget estructura = FutureBuilder(
        future: _loaduser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                    'Aún no obtienes ninguna recompensa',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext context, int index) {
                    //print(data[0]["REC_TITULO"]);

                    return ListTile(
                      title: new Card(
                        elevation: 5.0,
                        child: new Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  FadeInImage(
                                    image:
                                        NetworkImage(data[index]["GAL_FOTO"]),
                                    fit: BoxFit.fill,
                                    width:
                                        MediaQuery.of(context).size.width * .20,
                                    height: MediaQuery.of(context).size.height *
                                        .10,
                                    placeholder: AssetImage(
                                        'android/assets/images/loading.gif'),
                                    fadeInDuration: Duration(milliseconds: 200),
                                  ),
                                  Text(data[index]["REC_TITULO"],
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      )),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          new Icon(
                                            FontAwesomeIcons.gift,
                                            color: Colors.orange,
                                            size: 20,
                                          ),
                                          new Text(
                                            'Obtenido',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        String id_re = data[index]["ID_CUPONES"];
                        String id_n = data[index]["negocios_ID_NEGOCIO"];

                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new Cupones_detalles_ob(
                                      publicacion: new Publicacion(id_re, id_n),
                                    )));
                      },
                    );
                  },
                );
              }
          }
        });
    return Scaffold(
        appBar: AppBar(title: Text('Regresar')),
        body: ListView(
          //addAutomaticKeepAlives: true,
          children: [estructura],
        ));
  }
}
