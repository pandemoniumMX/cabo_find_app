import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/main.dart';
import 'package:cabofind/paginas/login.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas_ing/publicacion_detalle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Manejador_promociones extends StatefulWidget {
  final Categoria cat;

  Manejador_promociones({Key key, @required this.cat}) : super(key: key);

  @override
  Publicacionesfull createState() => new Publicacionesfull();
}

class Publicacionesfull extends State<Manejador_promociones> {
  ScrollController _scrollController = new ScrollController();
  int _ultimoItem = 0;
  List<int> _listaNumeros = new List();

  List data;
  List data_n;
  List data_c;
  DateFormat dateFormat;

  //final List<Todo> todos;
  Future<String> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getString('stringLenguage');
    prefs.getString('stringCity');
    String _city = prefs.getString('stringCity');
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/list_promociones_manejador.php?CAT=${widget.cat.cat}&CITY=$_city"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> insertRecomendacion(id_c) async {
    String currentLocale;
    try {
      currentLocale = await Devicelocale.currentLocale;
      print(currentLocale);
    } on PlatformException {
      print("Error obtaining current locale");
    }

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _id = "";

    _id = login.getString("stringID");
    _status = login.getString("stringLogin") ?? '';
    _mail = login.getString("stringMail") ?? '';
    print(_mail);
    print(id_c);
    if (_status == "True") {
      showPromo();

      var response = await http.get(
          Uri.encodeFull(
              "http://cabofind.com.mx/app_php/APIs/esp/insert_recomendacion_publicacion.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader},${androidInfo.fingerprint}&VERSION=${androidInfo.product}&IDIOMA=${currentLocale}&ID=${id_c}&SO=Android&IDF=${_id}"),
          headers: {"Accept": "application/json"});

      //CircularProgressIndicator(value: 5.0,);

    } else {
      //CircularProgressIndicator(value: 5.0,);

      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (BuildContext context) => Login()));
    }
  }

  void showPromo() {
    Fluttertoast.showToast(
        msg: "Agregado a promos!",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Color(0xffF4A32C),
        textColor: Colors.white,
        timeInSecForIos: 1);
  }

  @override
  void initState() {
    super.initState();
    this.getData();
    dateFormat = new DateFormat.MMMMd('es');
  }

  void dispose() {
    super.dispose();
    // data.clear();
  }

  Widget build(BuildContext context) {
    Widget error = Center(
      heightFactor: 15.00,
      child: Text(
        'Proximamente :)',
        style: TextStyle(fontSize: 25),
      ),
    );

    Widget lista = ListView.builder(
      shrinkWrap: true,
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        return data.isNotEmpty
            ? Container(
                height: 150,
                padding: EdgeInsets.all(5),
                child: InkWell(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          height: 150,
                          width: 180,
                          imageUrl: data[index]["GAL_FOTO"],
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Container(
                            margin: EdgeInsets.only(top: 1),
                            child: Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Text(data[index]["NEG_NOMBRE"],
                                      style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ),
                                Flexible(
                                  child: Text(data[index]["PUB_TITULO"],
                                      style: new TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w300,
                                      )),
                                ),
                                Row(
                                  children: [
                                    Text('Expira: ',
                                        style: new TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Text(
                                        dateFormat.format(DateTime.parse(
                                            data[index]["PUB_FECHA_LIMITE"])),
                                        overflow: TextOverflow.ellipsis,
                                        style: new TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  onTap: () {
                    String id_n = data[index]["ID_NEGOCIO"];
                    String id = data[index]["ID_PUBLICACION"];

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Publicacion_detalle_fin(
                                  publicacion: new Publicacion(id_n, id),
                                )));
                  },
                ),
              )
            : error;
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Promociones'),
      ),
      body: Container(
          //height: 500,
          child: Column(
        children: [data.isNotEmpty ? lista : error],
      )),
    );
  }
}