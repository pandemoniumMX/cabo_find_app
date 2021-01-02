import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/pedidos_proceso_list.dart';
import 'package:cabofind/paginas/pedidos_nuevos_list.dart';
import 'package:cabofind/paginas/pedidos_terminado_list.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Pedidos_historial extends StatefulWidget {
  final Categoria pagina;

  const Pedidos_historial({Key key, this.pagina}) : super(key: key);
  @override
  _Pedidos_historialState createState() => _Pedidos_historialState();
}

class _Pedidos_historialState extends State<Pedidos_historial> {
  TabController controller;
  DateFormat dateFormat;
  List historial;
  List proximo;
  List enviado;

  Future<Map> _deleteCarrito(String idcc) async {
    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/cancelacion_carrito.php?ID=$idcc&CAN=3");
    //print(widget.negocio.correo);
    return json.decode(response.body);
    //widget.negocio.correo
  }

  Future<Map> _loadHistorial() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/list_pedidos_historial.php?IDF=$_mail2");
    //print(widget.negocio.correo);
    return json.decode(response.body);
    //widget.negocio.correo
  }

  Future<String> _cargarHistorial() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_pedidos_historial_api.php?IDF=$_mail2"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      historial = json.decode(response.body);
    });
  }

  Future<Map> _loadEnviado() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/load_historial_enviado.php?IDF=$_mail2");
    return json.decode(response.body);
  }

  Future<Map> _loadProximo() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/load_historial_prox.php?IDF=$_mail2");
    //print(widget.negocio.correo);
    return json.decode(response.body);
    //widget.negocio.correo
  }

  Future<String> _cargarProximo() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_pedidos_proximo_api.php?IDF=$_mail2"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      proximo = json.decode(response.body);
    });
  }

  Future<String> _cargarEnviado() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_pedidos_enviado_api.php?IDF=$_mail2"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      enviado = json.decode(response.body);
    });
  }

  Future<Null> _onRefresh() {
    Completer<Null> completer = new Completer<Null>();
    Timer timer = new Timer(new Duration(seconds: 1), () {
      _cargarEnviado();
      _cargarProximo();
      _cargarHistorial();

      setState(() {});
      completer.complete();
    });
    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    this._cargarHistorial();
    this._cargarProximo();
    this._cargarEnviado();
    dateFormat = DateFormat.yMMMMd('es').add_Hm();
  }

  Widget build(BuildContext context) {
    final tab = new TabBar(tabs: <Tab>[
      new Tab(
        text: 'PRÓXIMOS',
      ),
      new Tab(
        text: 'ENVIADOS',
      ),
      new Tab(
        text: 'HISTORIAL',
      ),
    ]);
    return DefaultTabController(
      initialIndex: widget.pagina.cat,
      length: 3,
      child: Scaffold(
        appBar: new PreferredSize(
            preferredSize: tab.preferredSize,
            child: new Card(
              elevation: 26.0,
              color: Color(0xff60032D),
              child: tab,
            )),
        body: TabBarView(
          children: [
            RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView(children: <Widget>[
                FutureBuilder(
                    future: _loadProximo(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('No tienes pedidos proximos'));
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: proximo == null ? 0 : proximo.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String idc = proximo[index]["ID_CARRITO"];
                                  String idn = proximo[index]["ID_NEGOCIO"];

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 150,
                                          imageUrl: proximo[index]["GAL_FOTO"],
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                      proximo[index]["CAR_ESTATUS"] == 'A'
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .utensilSpoon,
                                                        color:
                                                            Color(0xff192227),
                                                      ),
                                                    ),
                                                    Container(
                                                        child:
                                                            Text('En espera')),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        // return object of type Dialog
                                                        return AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                          title: new Text(
                                                              "Alerta"),
                                                          content: new Text(
                                                            "¿Seguro que desea cancelar?",
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          actions: <Widget>[
                                                            // usually buttons at the bottom of the dialog
                                                            new FlatButton(
                                                              child: new Text(
                                                                "Cerrar",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            new FlatButton(
                                                              child: new Text(
                                                                "Confirmar",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff192227)),
                                                              ),
                                                              onPressed: () {
                                                                _deleteCarrito(
                                                                    idc);
                                                                _cargarProximo();
                                                                setState(() {});

                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Row(
                                                    children: <Widget>[
                                                      Container(
                                                          child:
                                                              Text('Cancelar')),
                                                      Container(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        child: Icon(
                                                            FontAwesomeIcons
                                                                .trashAlt,
                                                            color: Colors.red),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          : proximo[index]["CAR_ESTATUS"] == 'B'
                                              ? Row(
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .utensilSpoon,
                                                        color:
                                                            Color(0xff192227),
                                                      ),
                                                    ),
                                                    Container(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        child: Text(
                                                            'En preparación')),
                                                  ],
                                                )
                                              : proximo[index]["CAR_ESTATUS"] ==
                                                      'E'
                                                  ? Row(
                                                      children: <Widget>[
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: Icon(
                                                            FontAwesomeIcons
                                                                .checkCircle,
                                                            color: Color(
                                                                0xff192227),
                                                          ),
                                                        ),
                                                        Container(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Text(
                                                                'Recoger')),
                                                      ],
                                                    )
                                                  : SizedBox(),
                                      Container(
                                          margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            'Fecha de pedido: ' +
                                                dateFormat.format(
                                                    DateTime.parse(
                                                        proximo[index]
                                                            ["CAR_FECHA"])),
                                            style: TextStyle(
                                                color: Colors.black54),
                                          )),
                                      Container(
                                          margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            'No. de pedido: ' +
                                                proximo[index]["ID_CARRITO"],
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Divider(),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Icon(
                                              FontAwesomeIcons.moneyBill,
                                              color: Color(0xff192227),
                                              size: 20,
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.all(5),
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                'Total MXN: \$' +
                                                    proximo[index]["Total"],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                      Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: RaisedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        new Lista_pedidosx(
                                                          carrito: new Costos(
                                                              idc, idn),
                                                        )));
                                          },
                                          color: Color(0xff192227),
                                          textColor: Colors.white,
                                          child: Text(
                                            'Ver detalle',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        thickness: 3,
                                      )
                                    ],
                                  );
                                });
                          }
                      }
                    })
              ]),
            ), //aqui termina pedidos proximos
            ListView(
              children: <Widget>[
                FutureBuilder(
                    future: _loadEnviado(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('No tienes pedidos enviados'));
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: enviado == null ? 0 : enviado.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String idc = enviado[index]["ID_CARRITO"];
                                  String idn = enviado[index]["ID_NEGOCIO"];

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 150,
                                          imageUrl: enviado[index]["GAL_FOTO"],
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Icon(
                                              FontAwesomeIcons.motorcycle,
                                              color: Color(0xff192227),
                                              size: 20,
                                            ),
                                          ),
                                          enviado[index]["CAR_ESTATUS"] == 'C'
                                              ? Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: Text('Enviado'))
                                              : SizedBox()
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Icon(
                                              FontAwesomeIcons.clock,
                                              color: Color(0xff192227),
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.all(10),
                                              child: Text(enviado[index]
                                                      ["CAR_TIEMPO"] +
                                                  ' Minutos aprox.'))
                                        ],
                                      ),
                                      Container(
                                          margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            'Fecha de envío: ' +
                                                dateFormat.format(DateTime
                                                    .parse(enviado[index]
                                                        ["CAR_FECHA_ENVIADO"])),
                                            style: TextStyle(
                                                color: Colors.black54),
                                          )),
                                      Container(
                                          margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            'No. de pedido: ' +
                                                enviado[index]["ID_CARRITO"],
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Divider(),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Icon(
                                              FontAwesomeIcons.moneyBill,
                                              color: Color(0xff192227),
                                              size: 20,
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.all(5),
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                'Total MXN: \$' +
                                                    enviado[index]["Total"],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                      Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: RaisedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        new Lista_enproceso(
                                                          carrito: new Costos(
                                                              idc, idn),
                                                        )));
                                          },
                                          color: Color(0xff192227),
                                          textColor: Colors.white,
                                          child: Text(
                                            'Ver detalle',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        thickness: 3,
                                      )
                                    ],
                                  );
                                });
                          }
                      }
                    })
              ],
            ),
            ListView(
              children: <Widget>[
                FutureBuilder(
                    future: _loadHistorial(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('No tienes pedidos anteriores'));
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount:
                                    historial == null ? 0 : historial.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String idc = historial[index]["ID_CARRITO"];
                                  String idn = historial[index]["ID_NEGOCIO"];
                                  String estatus =
                                      historial[index]["CAR_ESTATUS"];

                                  return estatus == 'D'
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 150,
                                                imageUrl: historial[index]
                                                    ["GAL_FOTO"],
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 10),
                                                  child: Icon(
                                                    FontAwesomeIcons
                                                        .checkCircle,
                                                    color: Color(0xff192227),
                                                  ),
                                                ),
                                                Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: Text(
                                                        'Pedido entregado'))
                                              ],
                                            ),
                                            Container(
                                                margin: EdgeInsets.all(5),
                                                padding: EdgeInsets.all(5),
                                                child: Text(
                                                  'Fecha de entrega: ' +
                                                      dateFormat.format(DateTime
                                                          .parse(historial[
                                                                  index][
                                                              "CAR_FECHA_ENTREGADO"])),
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                )),
                                            Container(
                                                margin: EdgeInsets.all(5),
                                                padding: EdgeInsets.all(5),
                                                child: Text(
                                                  'No. de pedido: ' +
                                                      historial[index]
                                                          ["ID_CARRITO"],
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 10),
                                                  child: Icon(
                                                    FontAwesomeIcons.userCheck,
                                                    color: Color(0xff192227),
                                                    size: 20,
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(5),
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(
                                                    'Entregado por: ' +
                                                        historial[index]
                                                            ["CAR_REPARTIDOR"],
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Divider(),
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 10),
                                                  child: Icon(
                                                    FontAwesomeIcons.moneyBill,
                                                    color: Color(0xff192227),
                                                    size: 20,
                                                  ),
                                                ),
                                                Container(
                                                    margin: EdgeInsets.all(5),
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(
                                                      'Total MXN: \$' +
                                                          historial[index]
                                                              ["Total"],
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ))
                                              ],
                                            ),
                                            Container(
                                              height: 40,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: RaisedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.push(
                                                      context,
                                                      new MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              new Lista_terminado(
                                                                carrito:
                                                                    new Costos(
                                                                        idc,
                                                                        idn),
                                                              )));
                                                },
                                                color: Color(0xff192227),
                                                textColor: Colors.white,
                                                child: Text(
                                                  'Ver detalle',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              thickness: 3,
                                            )
                                          ],
                                        )
                                      : estatus == 'F'
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 150,
                                                    imageUrl: historial[index]
                                                        ["GAL_FOTO"],
                                                    progressIndicatorBuilder: (context,
                                                            url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Icon(
                                                        FontAwesomeIcons.ban,
                                                        color:
                                                            Color(0xff192227),
                                                      ),
                                                    ),
                                                    Container(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        child: Text(
                                                            'Pedido cancelado'))
                                                  ],
                                                ),
                                                Container(
                                                    margin: EdgeInsets.all(5),
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(
                                                      'Fecha de cancelación: ' +
                                                          dateFormat.format(
                                                              DateTime.parse(
                                                                  historial[
                                                                          index]
                                                                      [
                                                                      "CAR_FECHA_ENTREGADO"])),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    )),
                                                Container(
                                                    margin: EdgeInsets.all(5),
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(
                                                      'No. de pedido: ' +
                                                          historial[index]
                                                              ["ID_CARRITO"],
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                Divider(),
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .moneyBill,
                                                        color:
                                                            Color(0xff192227),
                                                        size: 20,
                                                      ),
                                                    ),
                                                    Container(
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: Text(
                                                          'Total MXN: \$' +
                                                              historial[index]
                                                                  ["Total"],
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ))
                                                  ],
                                                ),
                                                Divider(
                                                  thickness: 3,
                                                )
                                              ],
                                            )
                                          : SizedBox();
                                });
                          }
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
