import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> with TickerProviderStateMixin {
  bool _isVisibleAsi = true;
  int leftDiceNumber = 0;
  int start = 0;
  Animation _control;
  AnimationController _controller;
  void throwDices() {
    Future.delayed(const Duration(seconds: 5));
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _control = Tween(begin: 0.0, end: pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String> _insertDado(String dado, String idn) async {
    print('numero de dado' + dado);
    var cara = int.parse(dado);
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");
    if (cara == 1) {
      var response = await http.get(
          Uri.encodeFull(
              "http://cabofind.com.mx/app_php/APIs/esp/insert_puntos_dado.php?IDF=$_mail2&IDN=${idn}&PUNTOS=15"),
          headers: {"Accept": "application/json"});
    } else if (cara == 2) {
      var response = await http.get(
          Uri.encodeFull(
              "http://cabofind.com.mx/app_php/APIs/esp/insert_puntos_dado.php?IDF=$_mail2&IDN=${idn}&PUNTOS=25"),
          headers: {"Accept": "application/json"});
    } else if (cara == 3) {
      var response = await http.get(
          Uri.encodeFull(
              "http://cabofind.com.mx/app_php/APIs/esp/insert_puntos_dado.php?IDF=$_mail2&IDN=${idn}&PUNTOS=35"),
          headers: {"Accept": "application/json"});
    } else if (cara == 4) {
      var response = await http.get(
          Uri.encodeFull(
              "http://cabofind.com.mx/app_php/APIs/esp/insert_puntos_dado.php?IDF=$_mail2&IDN=${idn}&PUNTOS=45"),
          headers: {"Accept": "application/json"});
    } else if (cara == 5) {
      var response = await http.get(
          Uri.encodeFull(
              "http://cabofind.com.mx/app_php/APIs/esp/insert_puntos_dado.php?IDF=$_mail2&IDN=${idn}&PUNTOS=55"),
          headers: {"Accept": "application/json"});
    } else if (cara == 6) {
      var response = await http.get(
          Uri.encodeFull(
              "http://cabofind.com.mx/app_php/APIs/esp/insert_puntos_dado.php?IDF=$_mail2&IDN=${idn}&PUNTOS=65"),
          headers: {"Accept": "application/json"});
    }
  }

  //DESACTIVADO
  Future<Map> _updateShare() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/update_share.php?IDF=$_mail2");
    return json.decode(response.body);
  }

  Future<Map> _insertShare() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/insert_share.php?IDF=$_mail2");
    return json.decode(response.body);
  }

  Future<Map> _checkNeg() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('stringLenguage');
    prefs.getString('stringCity');
    String _city = prefs.getString('stringCity');
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/list_neg_puntos_check.php?IDF=$_mail2&CITY=$_city");
    return json.decode(response.body);
  }

  Future<Map> _checkDado(String idn) async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/list_check_dados.php?IDF=$_mail2&ID=${idn}");
    return json.decode(response.body);
  }

  Future<Map> _checkCompartidas() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/list_check_share.php?IDF=$_mail2");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    _sucess(BuildContext context, nombre, ciudad) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Felicidades',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              content: Container(
                  width: double.maxFinite,
                  height: 100.0,
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Obtuviste puntos para:',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff60032D)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            nombre,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
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
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                            Text(
                              ciudad,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black87),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('Cerrar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(title: Text('Regresar')),
      body: Container(
        // color: Colors.black,
        child: Column(
          children: [
            Text(
              'Has un tiro y obten puntos',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Text(
              'para un negocio participante',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: 10),
            SizedBox(height: 10),
            AnimatedBuilder(
              animation: _controller,
              child: Container(
                color: Colors.black,
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          child: Image.asset('assets/dice$leftDiceNumber.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              builder: (BuildContext context, Widget child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
              },
            ),
            FutureBuilder(
                future: _checkNeg(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        return Text(
                          'Vuelve a intentarlo más tarde',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        );
                      } else if (snapshot.data['ID_NEGOCIO'] != null) {
                        String nombre = snapshot.data['NEG_NOMBRE'];
                        String _idnx = snapshot.data['ID_NEGOCIO'];
                        String ciudad = snapshot.data['CIU_NOMBRE'];
                        return //Text(snapshot.data['NEG_NOMBRE'],style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),);
                            FutureBuilder(
                                future: _checkDado(_idnx),
                                builder: (context, snapshot) {
                                  // String total_dados = snapshot.data['Total'];
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                    case ConnectionState.waiting:
                                      return Center(
                                          child: CircularProgressIndicator());
                                    default:
                                      if (snapshot.hasError) {
                                        return Column(
                                          children: [
                                            RaisedButton(
                                                onPressed: () {
                                                  _controller.isCompleted
                                                      ? _controller.reverse()
                                                      : _controller.forward();
                                                  throwDices();
                                                  _insertDado(
                                                      '$leftDiceNumber', _idnx);
                                                  //  _sucess(context, nombre, ciudad);
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Felicidades, obtuviste puntos para $nombre - $ciudad",
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      backgroundColor:
                                                          Color(0xff60032D),
                                                      textColor: Colors.white,
                                                      timeInSecForIos: 5);
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40.0)),
                                                color: Colors.white,
                                                child: new Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    new Text(
                                                        'Tirar dado de la suerte :) ',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.black)),
                                                    new Icon(
                                                      FontAwesomeIcons.dice,
                                                      color: Colors.black,
                                                    )
                                                  ],
                                                )),
                                            Center(
                                                child: Text(
                                              'Sólo un tiro mensual',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                              ),
                                              textAlign: TextAlign.justify,
                                            )),
                                            FutureBuilder(
                                                future: _checkCompartidas(),
                                                builder: (context, snapshot) {
                                                  switch (snapshot
                                                      .connectionState) {
                                                    case ConnectionState.none:
                                                    case ConnectionState
                                                        .waiting:
                                                      return Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    default:
                                                      if (snapshot.hasError) {
                                                        return RaisedButton(
                                                            onPressed: null,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0)),
                                                            color: Colors.white,
                                                            child: new Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                new Text(
                                                                    'Has un tiro para poder compartir',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: Colors
                                                                            .black)),
                                                                new Icon(
                                                                  FontAwesomeIcons
                                                                      .share,
                                                                  color: Colors
                                                                      .black,
                                                                )
                                                              ],
                                                            ));
                                                      } else if (int.parse(
                                                              snapshot.data[
                                                                  "TOTALC"]) <=
                                                          9) {
                                                        return int.parse(snapshot
                                                                        .data[
                                                                    "TOTALD"]) ==
                                                                null
                                                            ? RaisedButton(
                                                                onPressed: null,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            40.0)),
                                                                color: Colors
                                                                    .white,
                                                                child: new Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: <
                                                                      Widget>[
                                                                    new Text(
                                                                        'Número de compartidas: ' +
                                                                            snapshot.data[
                                                                                "TOTALC"],
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.black)),
                                                                    new Icon(
                                                                      FontAwesomeIcons
                                                                          .share,
                                                                      color: Colors
                                                                          .black,
                                                                    )
                                                                  ],
                                                                ))
                                                            : RaisedButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    Share.share(
                                                                            'Descarga Cabofind, obten puntos y canjealos por increibles recompensas https://bit.ly/33ywdUS')
                                                                        .then((value) =>
                                                                            setState(() {
                                                                              _insertShare();
                                                                            }));
                                                                  });
                                                                },
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            40.0)),
                                                                color: Colors
                                                                    .white,
                                                                child: new Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: <
                                                                      Widget>[
                                                                    new Text(
                                                                        'Número de compartidas: ' +
                                                                            snapshot.data[
                                                                                "TOTALC"],
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.black)),
                                                                    new Icon(
                                                                      FontAwesomeIcons
                                                                          .share,
                                                                      color: Colors
                                                                          .black,
                                                                    )
                                                                  ],
                                                                ));
                                                      } else if (int.parse(
                                                              snapshot.data[
                                                                  "TOTALD"]) <=
                                                          1) {
                                                        if (int.parse(snapshot
                                                                    .data[
                                                                "TOTALC"]) ==
                                                            10) {
                                                          return RaisedButton(
                                                              onPressed: () {
                                                                _controller
                                                                        .isCompleted
                                                                    ? _controller
                                                                        .reverse()
                                                                    : _controller
                                                                        .forward();
                                                                throwDices();
                                                                _insertDado(
                                                                    '$leftDiceNumber',
                                                                    _idnx);
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "Felicidades, obtuviste puntos para $nombre - $ciudad",
                                                                    toastLength:
                                                                        Toast
                                                                            .LENGTH_LONG,
                                                                    backgroundColor:
                                                                        Color(
                                                                            0xff60032D),
                                                                    textColor:
                                                                        Colors
                                                                            .white,
                                                                    timeInSecForIos:
                                                                        5);
                                                              },
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              40.0)),
                                                              color:
                                                                  Colors.white,
                                                              child: new Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: <
                                                                    Widget>[
                                                                  new Text(
                                                                      'Tirar segundo dado de la suerte :) ',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color:
                                                                              Colors.black)),
                                                                  new Icon(
                                                                    FontAwesomeIcons
                                                                        .dice,
                                                                    color: Colors
                                                                        .black,
                                                                  )
                                                                ],
                                                              ));
                                                        }
                                                      } else //if (int.parse(snapshot.data["TOTALC"]) >=10)
                                                      {
                                                        return RaisedButton(
                                                            onPressed: null,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0)),
                                                            color: Colors.white,
                                                            child: new Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                new Text(
                                                                    'Ya has completado tu límite de este mes :)',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .black)),
                                                                new Icon(
                                                                  FontAwesomeIcons
                                                                      .share,
                                                                  color: Colors
                                                                      .black,
                                                                )
                                                              ],
                                                            ));
                                                      }
                                                  }
                                                }),
                                          ],
                                        );
                                      } else if (snapshot.data["ID_DADOS"] !=
                                          null) {
                                        return Column(
                                          children: [
                                            RaisedButton(
                                                onPressed: null,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40.0)),
                                                color: Colors.white,
                                                child: new Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    new Text(
                                                        'Ya has hecho tu tiro mensual  ',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.black)),
                                                    new Icon(
                                                      FontAwesomeIcons.dice,
                                                      color: Colors.black,
                                                    )
                                                  ],
                                                )),
                                            Text(
                                              'Obten un tiro compartiendo con  10 amigos',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            FutureBuilder(
                                                future: _checkCompartidas(),
                                                builder: (context, snapshot) {
                                                  switch (snapshot
                                                      .connectionState) {
                                                    case ConnectionState.none:
                                                    case ConnectionState
                                                        .waiting:
                                                      return Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    default:
                                                      if (snapshot.hasError) {
                                                        return RaisedButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                Share.share(
                                                                        'Descarga Cabofind, obten puntos y canjealos por increibles recompensas https://bit.ly/33ywdUS')
                                                                    .then((value) =>
                                                                        setState(
                                                                            () {
                                                                          _insertShare();
                                                                        }));
                                                              });
                                                            },
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0)),
                                                            color: Colors.white,
                                                            child: new Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                new Text(
                                                                    'Número de compartidas: 0',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: Colors
                                                                            .black)),
                                                                new Icon(
                                                                  FontAwesomeIcons
                                                                      .share,
                                                                  color: Colors
                                                                      .black,
                                                                )
                                                              ],
                                                            ));
                                                      } else if (int.parse(
                                                              snapshot.data[
                                                                  "TOTALC"]) <=
                                                          9) {
                                                        return RaisedButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                Share.share(
                                                                        'Descarga Cabofind, obten puntos y canjealos por increibles recompensas https://bit.ly/33ywdUS')
                                                                    .then((value) =>
                                                                        setState(
                                                                            () {
                                                                          _insertShare();
                                                                        }));
                                                              });
                                                            },
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0)),
                                                            color: Colors.white,
                                                            child: new Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                new Text(
                                                                    'Número de compartidas: ' +
                                                                        snapshot.data[
                                                                            "TOTALC"],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: Colors
                                                                            .black)),
                                                                new Icon(
                                                                  FontAwesomeIcons
                                                                      .share,
                                                                  color: Colors
                                                                      .black,
                                                                )
                                                              ],
                                                            ));
                                                      } else if (int.parse(
                                                              snapshot.data[
                                                                  "TOTALD"]) <=
                                                          1) {
                                                        if (int.parse(snapshot
                                                                    .data[
                                                                "TOTALC"]) ==
                                                            10) {
                                                          return RaisedButton(
                                                              onPressed: () {
                                                                _controller
                                                                        .isCompleted
                                                                    ? _controller
                                                                        .reverse()
                                                                    : _controller
                                                                        .forward();
                                                                throwDices();
                                                                _insertDado(
                                                                    '$leftDiceNumber',
                                                                    _idnx);
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "Felicidades, obtuviste puntos para $nombre - $ciudad",
                                                                    toastLength:
                                                                        Toast
                                                                            .LENGTH_LONG,
                                                                    backgroundColor:
                                                                        Color(
                                                                            0xff60032D),
                                                                    textColor:
                                                                        Colors
                                                                            .white,
                                                                    timeInSecForIos:
                                                                        5);
                                                              },
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              40.0)),
                                                              color:
                                                                  Colors.white,
                                                              child: new Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: <
                                                                    Widget>[
                                                                  new Text(
                                                                      'Tirar segundo dado de la suerte :) ',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color:
                                                                              Colors.black)),
                                                                  new Icon(
                                                                    FontAwesomeIcons
                                                                        .dice,
                                                                    color: Colors
                                                                        .black,
                                                                  )
                                                                ],
                                                              ));
                                                        }
                                                      } else {
                                                        return RaisedButton(
                                                            onPressed: null,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0)),
                                                            color: Colors.white,
                                                            child: new Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                new Text(
                                                                    'Ya has completado tu límite de este mes :) ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .black)),
                                                                new Icon(
                                                                  FontAwesomeIcons
                                                                      .share,
                                                                  color: Colors
                                                                      .black,
                                                                )
                                                              ],
                                                            ));
                                                      }
                                                  }
                                                }),
                                            /* Offstage(
                                              offstage: _isVisibleAsi,
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 25,
                                                    ),
                                                    Text(
                                                      'FELICIDADES!',
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xff60032D)),
                                                    ),
                                                    Text(
                                                      'Obtuviste puntos para:',
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xff60032D)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Text(
                                                        nombre,
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        new Icon(
                                                          FontAwesomeIcons
                                                              .locationArrow,
                                                          color: Colors.black87,
                                                          size: 12,
                                                        ),
                                                        Text(
                                                          '  ',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Text(
                                                          ciudad,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .black87),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )*/
                                          ],
                                        );
                                      }
                                  }
                                });
                      } else {
                        Text(
                          'Vuelve a intentarlo más tarde',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        );
                      }
                  }
                }),
            // Text('Comparte 5 veces para obtener un tiro gratis!',                style: TextStyle(color: Colors.black, fontSize: 12))
          ],
        ),
      ),
    );
  }
}