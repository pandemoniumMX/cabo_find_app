import 'dart:convert';
import 'package:cabofind/utilidades/classes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'empresa_detalle.dart';
import 'login3.dart';

class Mis_reservaciones extends StatefulWidget {
  @override
  _Mis_reservacionesState createState() => _Mis_reservacionesState();
}

class _Mis_reservacionesState extends State<Mis_reservaciones> {
  List data;
  DateFormat dateFormat;
  DateFormat hourFormat;
  DateFormat dateFecha;
  DateTime now = DateTime.now();

  String _mail2 = "";

  Future<String> _logcheck() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    setState(() {
      _mail2 = login.getString("stringID");
    });

    return "Success!";
  }

  Future<String> _loadReservaciones() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/list_usuarios_reservaciones.php?IDF=$_mail2");
    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> updateReservacion(
      String idr, String estatus, String idn,String tipo) async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/update_reservacion.php?IDR=$idr&ESTATUS=$estatus&IDF=$_mail2&IDN=$idn&TIPO=$tipo"),
        headers: {"Accept": "application/json"});
  }

  @override
  void initState() {
    super.initState();
    this._logcheck();

    this._loadReservaciones();
    initializeDateFormatting('es');
    dateFormat = new DateFormat.MMMMd('es');
    hourFormat = new DateFormat.Hm();
    dateFecha = new DateFormat('yyyy-MM-dd hh:mm');
  }

  @override
  Widget build(BuildContext context) {
    _borrar(idr, idn) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type AlertDialog
          return AlertDialog(
            title: new Text("Borrar reservación"),
            content: new Text("¿Seguro que desea borrar?"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Cerrar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                  color: Colors.black,
                  child: new Text("Sí"),
                  onPressed: () {
                    updateReservacion(idr, 'D', idn,'C');
                    setState(() {
                      _loadReservaciones();
                    });
                    Navigator.pop(context);
                  }),
            ],
          );
        },
      );
    }

    _cancelar(idr, idn) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type AlertDialog
          return AlertDialog(
            title: new Text("Cancelar reservación"),
            content: new Text("¿Seguro que desea cancelar?"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Cerrar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                  color: Colors.black,
                  child: new Text("Sí"),
                  onPressed: () {
                    updateReservacion(idr, 'B', idn,'B');
                    setState(() {
                      _loadReservaciones();
                    });

                    Navigator.of(context).pop();
                  }),
            ],
          );
        },
      );
    }

    Widget error = Center(
      heightFactor: 20.00,
      child: Text(
        'No has hecho reservaciones',
        style: TextStyle(fontSize: 25),
      ),
    );

    Widget reservaciones = ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        String idr = data[index]["ID_RESERVACION"];
        String hora = data[index]["RES_HORA"];
        String fecha = data[index]["RES_FECHA"];
        String estatus = data[index]["RES_ESTATUS"];
        String idn = data[index]["negocios_ID_NEGOCIO"];
        DateTime hora1 = hourFormat.parse(hora);
        String apertura = DateFormat('h:mm a').format(hora1);
        String formattedTime = dateFecha.format(now);

        DateTime fecha1 = dateFecha.parse(formattedTime); //hora local
        DateTime fecha2 = dateFecha.parse(fecha); //hora consulta
        return _mail2 != null
            ? Column(
                children: <Widget>[
                  Card(
                    elevation: 2.0,
                    child: new Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Center(
                              child: QrImage(
                                data: idr,
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        new Text(
                                          'Lugar ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(data[index]["NEG_NOMBRE"],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        new Text(
                                          'Fecha',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        new Text(
                                            dateFormat.format(DateTime.parse(
                                                data[index]["RES_FECHA"])),
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w900,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        new Text(
                                          'Hora',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        new Text(apertura.toString(),
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w900,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        new Text(
                                          '# Número',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        new Text(
                                            data[index]["RES_PERSONAS"] +
                                                ' Personas',
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w900,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Reservación: ',
                                  style: TextStyle(fontSize: 18),
                                ),
                                estatus == 'A'
                                    ? Text('Pendiente',
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w900,
                                        ))
                                    : estatus == 'B'
                                        ? Text('Cancelada',
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.red,
                                              fontWeight: FontWeight.w900,
                                            ))
                                        : estatus == 'C'
                                            ? Text('Aprobada',
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w900,
                                                ))
                                            : SizedBox(),
                                estatus == 'A'
                                    ? InkWell(
                                        onTap: () {
                                          _cancelar(idr, idn);
                                        },
                                        child: Icon(
                                          FontAwesomeIcons.minusCircle,
                                          color: Colors.red,
                                        ),
                                      )
                                    : estatus == 'B'
                                        ? InkWell(
                                            onTap: () {
                                              _borrar(idr, idn);
                                            },
                                            child: Icon(
                                              FontAwesomeIcons.trash,
                                              color: Colors.red,
                                            ),
                                          )
                                        : SizedBox()
                              ],
                            ),
                          ),
                          RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            new Empresa_det_fin(
                                                empresa: new Empresa(idn))));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0)),
                              color: Color(0xff60032D),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(' Ver negocio ',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                  new Icon(
                                    FontAwesomeIcons.eye,
                                    color: Colors.white,
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : 
             Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new Login_esp()));
        ;
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Regresar'),
      ),
      body: data.isEmpty ? error : reservaciones,
    );
  }
}