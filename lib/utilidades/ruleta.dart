import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Ruleta extends StatefulWidget {
  @override
  _RuletaState createState() => _RuletaState();
}

class _RuletaState extends State<Ruleta> {
  Future _loadNeg;
  Future _loadRul;

  final StreamController _dividerController = StreamController<int>.broadcast();
  final _wheelNotifier = StreamController<double>.broadcast();

  int _value;
  int selected;
  bool _vista = true;
  bool _texto = true;

  Future<Map> _checkNeg() async {
    await Future.delayed(Duration(seconds: 1));
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

  Future<Map> _checkRuleta(String idn) async {
    await Future.delayed(Duration(seconds: 1));
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/list_check_ruleta.php?IDF=$_mail2&ID=${idn}");
    return json.decode(response.body);
  }

  Future<String> _insertRul(String rul) async {
    print('chavaaaaaaaaaaaaaaaaaaaaaaaaaal' + rul);
  }

  Future<bool> _getText() async {
    await Future.delayed(Duration(seconds: 1));
    return _texto = false;
  }

  final Map<int, String> labels = {
    1: 'SEGUNDO TIRO',
    2: 'PUNTOS AL DOBLE',
    3: 'MALA SUERTE',
    4: '100 PUNTOS',
    5: '0 PUNTOS',
  };

  dispose() {
    _dividerController.close();
    _wheelNotifier.close();
  }

  @override
  void initState() {
    super.initState();
    _loadNeg = _checkNeg();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Regresar"), elevation: 0.0),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: _loadNeg,
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

                  return FutureBuilder(
                      future: _checkRuleta(_idnx),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          default:
                            if (snapshot.hasError) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Vuelve a intentarlo más tarde',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              );
                            } else if (snapshot.hasData) {
                              int dadototal = int.parse(snapshot.data['Total']);
                              return dadototal > 65 && dadototal < 500
                                  ? Center(
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Ruleta de la suerte🍀",
                                            style: TextStyle(fontSize: 30),
                                          ),
                                          Text(
                                            "Apuesta tus puntos",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          _value == null
                                              ? DropdownButton(
                                                  hint: Text(
                                                      "Cantidad de puntos"),
                                                  onTap: () {},
                                                  isExpanded: false,
                                                  value: _value,
                                                  items: [
                                                    DropdownMenuItem(
                                                      child: Text("25 Puntos"),
                                                      value: 1,
                                                    ),
                                                    DropdownMenuItem(
                                                        child:
                                                            Text("50 Puntos"),
                                                        value: 2),
                                                  ],
                                                  onChanged: (valuex) {
                                                    setState(() {
                                                      _value = valuex;
                                                      _vista = false;
                                                    });
                                                  })
                                              : SizedBox(),
                                          Column(
                                            children: [
                                              Offstage(
                                                offstage: _vista,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      _value == 1
                                                          ? '25 PUNTOS'
                                                          : _value == 2
                                                              ? '50 PUNTOS'
                                                              : 'nada',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    SpinningWheel(
                                                      Image.asset(
                                                          'assets/roulette-8-300.png'),
                                                      width: 310,
                                                      height: 310,
                                                      initialSpinAngle:
                                                          _generateRandomAngle(),
                                                      spinResistance: 0.2,
                                                      dividers: 5,
                                                      onUpdate:
                                                          _dividerController
                                                              .add,
                                                      onEnd: _dividerController
                                                          .add,
                                                      secondaryImage: Image.asset(
                                                          'assets/roulette-center-300.png'),
                                                      secondaryImageHeight: 110,
                                                      secondaryImageWidth: 110,
                                                      shouldStartOrStop:
                                                          _wheelNotifier.stream,
                                                      canInteractWhileSpinning:
                                                          false,
                                                    ),
                                                    Visibility(
                                                      maintainState: false,
                                                      visible: _texto,
                                                      child: RaisedButton(
                                                          child: new Text(
                                                              "Girar ruleta"),
                                                          onPressed: () {
                                                            _wheelNotifier.sink.add(
                                                                _generateRandomVelocity());
                                                            _getText();
                                                          }),
                                                    ),
                                                    StreamBuilder(
                                                      stream: _dividerController
                                                          .stream,
                                                      builder: (context,
                                                              snapshot) =>
                                                          snapshot.hasData
                                                              ? RouletteScore(
                                                                  selected:
                                                                      snapshot
                                                                          .data,
                                                                )
                                                              : Container(),
                                                    )
                                                    /*Visibility(
                                                      maintainState: false,
                                                      visible: true,
                                                      child: StreamBuilder(
                                                        stream:
                                                            _dividerController
                                                                .stream,
                                                        builder: (context,
                                                                snapshot) =>
                                                            snapshot.hasData
                                                                ? _insertRul(
                                                                    snapshot
                                                                        .data)
                                                                : Container(),
                                                      ),
                                                    ),*/
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'Ya has superado tu límite de tiros :(',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
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
    );
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class RouletteScore extends StatefulWidget {
  final int selected;

  const RouletteScore({Key key, this.selected}) : super(key: key);
  @override
  _RouletteScoreState createState() => _RouletteScoreState();
}

class _RouletteScoreState extends State<RouletteScore> {
  final Map<int, String> labels = {
    1: 'SEGUNDO TIRO',
    2: 'PUNTOS AL DOBLE',
    3: 'MALA SUERTE',
    4: '100 PUNTOS',
    5: '0 PUNTOS',
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void showFavorites() {
    Fluttertoast.showToast(
      msg: "Borrado correctamente!",
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Color(0xffED393A),
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text('${labels[widget.selected]}',
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 24.0));
  }
}

/*class RouletteScore extends StatelessWidget {
  final int selected;

  final Map<int, String> labels = {
    1: 'SEGUNDO TIRO',
    2: 'PUNTOS AL DOBLE',
    3: 'MALA SUERTE',
    4: '100 PUNTOS',
    5: '0 PUNTOS',
  };

  RouletteScore(this.selected);
 

  @override
  Widget build(BuildContext context) {
    return Text('${labels[selected]}',
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 24.0));
  }
}
*/
