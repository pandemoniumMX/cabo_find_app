import 'dart:convert';
import 'package:cabofind/utilidades/classes.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'empresa_detalle.dart';

class Cupones_detalles_ob extends StatefulWidget {
  final Publicacion publicacion;

  Cupones_detalles_ob({Key key, @required this.publicacion}) : super(key: key);
  @override
  _Recompensa_detalleState createState() => _Recompensa_detalleState();
}

class _Recompensa_detalleState extends State<Cupones_detalles_ob> {
  List data;
  DateFormat dateFormat;

  Future<String> getData() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_cupones_api_single_ob.php?IDF=$_mail2&ID_R=${widget.publicacion.id_n}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  @override
  void initState() {
    super.initState();

    this.getData();
    //dateFormat = new DateFormat.MMMd('es');
    dateFormat = new DateFormat.yMMMd('es');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Regresar')),
      body: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            String _qrencryp = data[index]["CUP_CODIGO"];

            return Column(
              children: [
                FadeInImage(
                  image: NetworkImage(data[index]["REC_FOTO"]),
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .35,
                  placeholder: AssetImage('android/assets/images/loading.gif'),
                  fadeInDuration: Duration(milliseconds: 200),
                ),

                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: DottedBorder(
                    color: Colors.black,
                    strokeWidth: 1,
                    strokeCap: StrokeCap.butt,
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text(
                            data[index]["NEG_NOMBRE"],
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Icon(
                                FontAwesomeIcons.locationArrow,
                                color: Colors.black87,
                                size: 12,
                              ),
                              Text(
                                '  ',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              Text(
                                data[index]["CIU_NOMBRE"],
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black87),
                              ),
                            ],
                          ),
                          Text(
                            data[index]["REC_TITULO"],
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff60032D)),
                            softWrap: true,
                            maxLines: 5,
                            textAlign: TextAlign.center,
                          ),
                          Center(
                            child: QrImage(
                              data: _qrencryp,
                              version: QrVersions.auto,
                              size: 200.0,
                            ),
                          ),
                          Text(
                            'Canjéa hoy mismo tu recompensa!',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Vencimiento: ',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  dateFormat.format(DateTime.parse(
                                      data[index]["CUP_FECHA_CADUCIDAD"])),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.orange),
                                  textAlign: TextAlign.center,
                                )
                              ]),
                          RaisedButton(
                              onPressed: () {
                                String id_sql = data[0]["negocios_ID_NEGOCIO"];
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            new Empresa_det_fin(
                                                empresa: new Empresa(id_sql))));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0)),
                              color: Color(0xff192227),
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
                ),
                //_botonrecompensa,
                Text(
                  'Términos y condiciones',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                Center(
                    child: Text(
                  data[index]["REC_TERMINOS"],
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                )),
              ],
            );
          }),
    );
  }
}
