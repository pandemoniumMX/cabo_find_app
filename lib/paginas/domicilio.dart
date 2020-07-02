import 'dart:convert';
import 'package:cabofind/utilidades/classes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'list_manejador_menus.dart';
import 'menu.dart';

class Domicilio extends StatefulWidget {
  @override
  _DomicilioState createState() => _DomicilioState();
}

class _DomicilioState extends State<Domicilio> {
  List data;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_domicilio_rest.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Regresar'),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            String id_n = data[index]["ID_NEGOCIO"];
            print(id_n);
            return new InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new Menu_manejador(manejador: new Users(id_n))));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    margin: EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: FadeInImage(
                        image: NetworkImage(data[index]['GAL_FOTO']),
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                        placeholder:
                            AssetImage('android/assets/images/loading.gif'),
                        fadeInDuration: Duration(milliseconds: 200),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: new Text(data[index]['NEG_NOMBRE'],
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                          //  backgroundColor: Colors.black45
                        )),
                  ),
                  Divider()
                ],
              ),
            );
          },
        ));
  }
}
