import 'dart:convert';

import 'package:cabofind/utilidades/classes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'list_manejador_menus.dart';

class List_restaurantes_cat extends StatefulWidget {
  final Users manejador;

  const List_restaurantes_cat({Key key, this.manejador}) : super(key: key);
  @override
  _List_restaurantes_catState createState() => _List_restaurantes_catState();
}

class _List_restaurantes_catState extends State<List_restaurantes_cat> {
  DateTime now = DateTime.now();
  DateFormat dateFormat;
  List data;

  Future<String> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('stringLenguage');
    prefs.getString('stringCity');
    String _city = prefs.getString('stringCity');
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_domicilio_rest_cat.php?ID=${widget.manejador.correo}&CITY=$_city"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  void initState() {
    getData();
    dateFormat = new DateFormat.Hm();
  }

  @override
  Widget build(BuildContext context) {
    Widget listado = StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        String id_n = data[index]["ID_NEGOCIO"];
        String hora = data[index]["HOR_APERTURA"];
        String estatus = data[index]["HOR_ESTATUS"];
        String horaclose = data[index]["HOR_CIERRE"];
        String formattedTime = DateFormat('h:mm a').format(now);
        DateTime hora1 = dateFormat.parse(hora);
        DateTime horacerrar = dateFormat.parse(horaclose);
        DateTime hora2 = new DateFormat("h:mm a").parse(formattedTime);

        //DateTime apertura2 = new DateFormat("kk:mm:ss").parse(hora);
        String apertura = DateFormat('h:mm a').format(hora1);
        print(hora1);
        print(formattedTime);
        return estatus == 'B' //testing ==B
            ? new InkWell(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5.0),
                          margin: EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: FadeInImage(
                              image: NetworkImage(data[index]['GAL_FOTO']),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              // placeholder: AssetImage('android/assets/images/loading.gif'),
                              placeholder: AssetImage(
                                  'android/assets/images/loading.gif'),
                              fadeInDuration: Duration(milliseconds: 200),
                            ),
                          ),
                        ),
                        Container(
                          //  margin: EdgeInsets.all(50),
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: Colors.black26,
                          ),
                          child: Center(
                            child: Text(
                              'Cerrado',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                    Center(
                      child: new Text(data[index]['NEG_NOMBRE'],
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            //  backgroundColor: Colors.black45
                          )),
                    ),
                  ],
                ),
              )
            : hora1.isBefore(hora2) && horacerrar.isAfter(hora2) //correcto
                // : hora1 != null //testing
                ? new InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new Menu_manejador(
                                      manejador: new Users(id_n))));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5.0),
                          margin: EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              imageUrl: data[index]["GAL_FOTO"],
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                        Center(
                          child: new Text(data[index]['NEG_NOMBRE'],
                              style: new TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                //  backgroundColor: Colors.black45
                              )),
                        ),
                      ],
                    ),
                  )
                : new InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5.0),
                              margin: EdgeInsets.all(5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: FadeInImage(
                                  image: NetworkImage(data[index]['GAL_FOTO']),
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  // placeholder: AssetImage('android/assets/images/loading.gif'),
                                  placeholder: AssetImage(
                                      'android/assets/images/loading.gif'),
                                  fadeInDuration: Duration(milliseconds: 200),
                                ),
                              ),
                            ),
                            Container(
                              //  margin: EdgeInsets.all(50),
                              height: 50,
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                color: Colors.black26,
                              ),
                              child: Center(
                                child: Text(
                                  'Hora de apertura: ' + apertura.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            )
                          ],
                        ),
                        Center(
                          child: new Text(data[index]['NEG_NOMBRE'],
                              style: new TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                //  backgroundColor: Colors.black45
                              )),
                        ),
                      ],
                    ),
                  );
        //  : SizedBox();
      },
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );

    Widget error = Center(
      child: Text(
        'Proximamente :)',
        style: TextStyle(fontSize: 25),
      ),
    );
    Future<bool> cargando() async {
      http.Response response = await http.get("http://api.openrates.io/latest");
      return json.decode(response.body);
    }

    return new Scaffold(
        appBar: AppBar(
          title: Text('Regresar'),
        ),
        body: data.isEmpty ? error : listado);
  }
}