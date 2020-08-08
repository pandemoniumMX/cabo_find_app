import 'dart:convert';
import 'package:cabofind/utilidades/classes.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cabofind/paginas/cupones_detalle.dart';

class Recompensa_detalle extends StatefulWidget {
  final Publicacion2 publicacion;

  Recompensa_detalle({Key key, @required this.publicacion}) : super(key: key);
  @override
  _Recompensa_detalleState createState() => _Recompensa_detalleState();
}

class _Recompensa_detalleState extends State<Recompensa_detalle> {
  List data;
  List cupon;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_recompensas_usuario_api.php?ID_N=${widget.publicacion.id_n}&ID_R=${widget.publicacion.id_r}&CORREO=${widget.publicacion.mail}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  Future<Map> updatePuntos(
      String idr, String idu, String total, String idn) async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/update_puntos_c.php?ID_R=${idr}&ID_U=${idu}&TOTAL=${total}&ID_N=${idn}"),
        headers: {"Accept": "application/json"});
  }

  Future<Map> insertData(
      String idr, String idu, String total, String idn) async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insert_cupon_cf.php?ID_R=${idr}&ID_U=${idu}&TOTAL=${total}&ID_N=${idn}"),
        headers: {"Accept": "application/json"});

    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new Cupones_detalles(
                  publicacion: new Publicacion(idr, idn),
                )));

    this.setState(() {
      cupon = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();

    this.getData();
  }

  Widget build(BuildContext context) {
    void _confirmacion() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Alerta"),
            content: new Text(
              "¿Seguro que desea continuar? Tendrás 7 días para la recompensa :)",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Cerrar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Confirmar"),
                onPressed: () {
                  String id_re = data[0]["ID_RECOMPENSA"];
                  String id_n = data[0]["negocios_ID_NEGOCIO"];

                  String total = data[0]["REC_META"];
                  String id_u = data[0]["ID_USU"];
                  print(id_u);
                  print(total);

                  insertData(id_re, id_u, total, id_n);
                  updatePuntos(id_re, id_u, total, id_n);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Widget _botonrecompensa = Column(children: <Widget>[
      new ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            var _total = int.parse(data[index]["PUN_TOTAL"]);
            var _meta = int.parse(data[index]["REC_META"]);
            print('Puntos totales: ' + data[index]["PUN_TOTAL"]);
            print(_meta);
//print(_meta);

            return new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _total >= _meta
                    ? RaisedButton(
                        onPressed: () {
                          _confirmacion();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        color: Colors.orange,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(' Obtener recompensa',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            new Icon(
                              FontAwesomeIcons.gift,
                              color: Colors.white,
                            ),
                          ],
                        ))
                    : RaisedButton(
                        onPressed: null,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        color: Color(0xff4267b2),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(' Necesitas más puntos ',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            new Icon(
                              FontAwesomeIcons.frown,
                              color: Colors.white,
                            ),
                          ],
                        )),
              ],
            );
          }),
    ]);

    return Scaffold(
      appBar: AppBar(title: Text('Regresar')),
      body: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                FadeInImage(
                  image: NetworkImage(data[index]["GAL_FOTO"]),
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
                                data[index]["NEG_LUGAR"],
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
                                color: Colors.black),
                            softWrap: true,
                            maxLines: 5,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            data[index]["REC_DESCRIPCION"],
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          _botonrecompensa
                        ],
                      ),
                    ),
                  ),
                ),
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
