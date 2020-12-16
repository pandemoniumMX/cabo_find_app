import 'dart:convert';

import 'package:cabofind/paginas/preparing.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Carrito extends StatefulWidget {
  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  List data;
  DateFormat dateFormat;
  DateTime now = DateTime.now();

  Future<String> _loadCarrito() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = login.getString("stringID");

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_carrito.php?IDF=$_mail2"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._loadCarrito();
    dateFormat = new DateFormat.Hm();
  }

  @override
  Widget build(BuildContext context) {
    Widget error = Center(
      child: Text(
        'Carrito vacío',
        style: TextStyle(fontSize: 25),
      ),
    );
    return Scaffold(
      body: data == null
          ? error
          : ListView.builder(
              //scrollDirection: Axis.horizontal,
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                String idn = data[index]["ID_NEGOCIO"];
                String hora = data[index]["HOR_APERTURA"];
                String estatus = data[index]["HOR_ESTATUS"];
                String horaclose = data[index]["HOR_CIERRE"];
                String formattedTime = DateFormat('h:mm a').format(now);
                DateTime hora1 = dateFormat.parse(hora);
                DateTime hora2 = new DateFormat("h:mm a").parse(formattedTime);
                DateTime horacerrar = dateFormat.parse(horaclose);

                String apertura = DateFormat('h:mm a').format(hora1);
                return InkWell(
                  onTap: () {
                    hora1.isBefore(hora2) && horacerrar.isAfter(hora2)
                        ? Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new Preparing(
                                      negocio: Users(idn),
                                    )))
                        : Fluttertoast.showToast(
                            msg: "No disponible, intenta más tarde",
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Color(0xffED393A),
                            textColor: Colors.white,
                          );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                fit: BoxFit.fitWidth,
                                width: 150,
                                height: 100,
                                imageUrl: data[index]["GAL_FOTO"],
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                data[index]["NEG_NOMBRE"],
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            /*Column(children: [
                        Text('Pedidos'),
                        SizedBox(
                          height: 10,
                        ),
                        Text(data[index]["Total"])
                      ])*/
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
