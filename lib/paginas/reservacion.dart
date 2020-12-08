import 'dart:convert';
import 'package:cabofind/paginas/login3.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'login.dart';

class Reservacion extends StatefulWidget {
  final Reserva reserva;

  Reservacion({Key key, @required this.reserva}) : super(key: key);
  @override
  Detalles createState() => new Detalles();
}

class Detalles extends State<Reservacion> {
  TextEditingController pedido = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController fecha = TextEditingController();
  TextEditingController hora = TextEditingController();
  String _mySelection;
  String _mispagos;
  String _mail2 = '';
  List playas;
  List pagos;
  final _formKey = GlobalKey<FormState>();
  String _date = "No seleccionada";
  String _time = "No seleccionada";

  DateTime now = DateTime.now();

  Future<Map> _loadUser() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";

    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/list_usuarios_api.php?IDF=$_mail2");
    return json.decode(response.body);
  }

  Future<String> getPlaya() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_personas.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      playas = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> insertRickys(nombre1, numero1, correo1, _mySelection) async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    _mail2 = login.getString("stringID");
    var response1 = await http.get(
        Uri.encodeFull(
            'http://cabofind.com.mx/app_php/sendmails/sendmail_reservacion.php?NOM=${nombre1}&NUM=${numero1}&NEGOCIO=${widget.reserva.nombre}&TIPO_R=${widget.reserva.tipo_r}&TIPO_N=${widget.reserva.tipo_n}&PERSONAS=${_mySelection}&CORREO=${correo1}&FECHA=${_date}&HORA=${_time}&PARA=${widget.reserva.correo}'),
        headers: {"Accept": "application/json"});
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insert_reservacion.php?NOM=${nombre1}&NUM=${numero1}&NEGOCIO=${widget.reserva.nombre}&ID_NEGOCIO=${widget.reserva.id}&TIPO_R=${widget.reserva.tipo_r}&TIPO_N=${widget.reserva.tipo_n}&PERSONAS=${_mySelection}&CORREO=${correo1}&FECHA=${_date}&HORA=${_time}&PLATAFORMA=ANDROID&IDIOMA=ESP&IDF=$_mail2"),
        headers: {"Accept": "application/json"});

    return "Success!";
  }

  void initState() {
    super.initState();
    this.getPlaya();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  }

  @override
  Widget build(BuildContext context) {
    void showResena() {
      Fluttertoast.showToast(
          msg:
              "Reservación realizada existosamente, recibiras confirmacion en los proximos minutos!",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          timeInSecForIos: 5);
    }

    _confirmDialog(context, nombre1, numero1, correo1, _mySelection) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type AlertDialog
          return AlertDialog(
            title: new Text("Confirmar reservación"),
            content: new Text("¿Los datos están correctos? " + ""),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                  color: Colors.black,
                  child: new Text("Sí"),
                  onPressed: () {
                    showResena();
                    insertRickys(nombre1, numero1, correo1, _mySelection);
                    Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Myapp1()));
                  }),
            ],
          );
        },
      );
    }

    return new Scaffold(
      appBar: AppBar(
        title: Text('Regresar'),
      ),
      body: ListView(children: <Widget>[
        Form(
            key: _formKey,
            child: _mail2 != null
                ? FutureBuilder(
                    future: _loadUser(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError) {
                            return Center(
                                child: Text(
                              "Error :(",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 25.0),
                              textAlign: TextAlign.center,
                            ));
                          } else {
                            var name = snapshot.data['USU_NOMBRE'];
                            var numb = snapshot.data['USU_CELULAR'];
                            var mail = snapshot.data['USU_CORREO'];

                            nombre = new TextEditingController(text: name);
                            numero = new TextEditingController(text: numb);
                            correo = new TextEditingController(text: mail);

                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Llena todo los campos por favor, verificar que el horario seleccionado este disponible en el negocio",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                  ),
                                ),
                                new ListTile(
                                  leading: const Icon(Icons.person),
                                  title: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Este campo no puede estar vacío';
                                      } else if (value.length <= 3) {
                                        return 'Requiere minimo 4 letras';
                                      }
                                      return null;
                                    },
                                    decoration: new InputDecoration(
                                      labelText: "Nombre completo",
                                      fillColor: Colors.white,
                                    ),
                                    keyboardType: TextInputType.text,
                                    controller: nombre,
                                    readOnly: true,
                                    maxLines: 1,
                                  ),
                                ),
                                new ListTile(
                                  leading: const Icon(Icons.phone),
                                  title: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Este campo no puede estar vacío';
                                      } else if (value.length <= 9) {
                                        return 'Requiere 10 dígitos';
                                      }
                                      return null;
                                    },
                                    decoration: new InputDecoration(
                                      labelText: "Celular",
                                      fillColor: Colors.white,
                                    ),
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: <TextInputFormatter>[
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    controller: numero,
                                    maxLines: 1,
                                  ),
                                ),
                                new ListTile(
                                  leading: const Icon(Icons.email),
                                  title: TextFormField(
                                    expands: false,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Este campo no puede estar vacío';
                                      } else if (value.length <= 9) {
                                        return 'Requiere 10 dígitos';
                                      }
                                      return null;
                                    },
                                    decoration: new InputDecoration(
                                      labelText: "Correo",
                                      fillColor: Colors.white,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    controller: correo,
                                    maxLines: 1,
                                  ),
                                ),
                                new ListTile(
                                    leading: const Icon(Icons.group),
                                    title: DropdownButtonFormField(
                                      items: playas.map((item) {
                                        return new DropdownMenuItem(
                                          child: new Text(item['PER_NOMBRE']),
                                          value: item['ID_PERSONA'].toString(),
                                        );
                                      }).toList(),
                                      onTap: null,
                                      onChanged: (newVal) {
                                        setState(() {
                                          _mySelection = newVal;
                                          var one = int.parse(newVal);
                                        });
                                      },
                                      validator: (value) => value == null
                                          ? 'Campo requerido'
                                          : null,
                                      hint: Text('Cantidad de personas'),
                                      value: _mySelection,
                                      isExpanded: true,
                                    )),
                                new ListTile(
                                  leading:
                                      const Icon(FontAwesomeIcons.calendar),
                                  title: TextFormField(
                                    onTap: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: now,
                                          maxTime: DateTime(2030, 12, 31),
                                          onChanged: (date) {
                                        _date =
                                            '${date.year}-${date.month}-${date.day.toString().padLeft(2, '0')}';
                                        setState(() {
                                          fecha = new TextEditingController(
                                              text: '$_date');
                                        });
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.es);
                                    },
                                    expands: false,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Este campo no puede estar vacío';
                                      } else if (value.length <= 3) {
                                        return 'Requiere 4 dígitos';
                                      }
                                      return null;
                                    },
                                    decoration: new InputDecoration(
                                      labelText: "Fecha",
                                      fillColor: Colors.white,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    readOnly: true,
                                    controller: fecha,
                                    maxLines: 1,
                                  ),
                                ),
                                new ListTile(
                                  leading: const Icon(FontAwesomeIcons.clock),
                                  title: TextFormField(
                                    onTap: () {
                                      DatePicker.showTime12hPicker(context,
                                          theme: DatePickerTheme(
                                            containerHeight: 210.0,
                                          ),
                                          showTitleActions: true,
                                          onConfirm: (time) {
                                        _time =
                                            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                                        setState(() {
                                          hora = new TextEditingController(
                                              text: '$_time');
                                        });
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.es);
                                    },
                                    expands: false,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Este campo no puede estar vacío';
                                      } else if (value.length <= 3) {
                                        return 'Requiere 4 dígitos';
                                      }
                                      return null;
                                    },
                                    decoration: new InputDecoration(
                                      labelText: "Hora",
                                      fillColor: Colors.white,
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: hora,
                                    maxLines: 1,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            RaisedButton(
                                                onPressed: () {
                                                  final nombre1 = nombre.text;
                                                  final numero1 = numero.text;
                                                  final correo1 = correo.text;
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    _confirmDialog(
                                                        context,
                                                        nombre1,
                                                        numero1,
                                                        correo1,
                                                        _mySelection);
                                                  }
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40.0)),
                                                color: Colors.black,
                                                child: new Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    new Text('Reservar ahora ',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white)),
                                                    new Icon(
                                                      FontAwesomeIcons
                                                          .calendarAlt,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            );
                          }
                      }
                    })
                : Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Login())))
      ]),
    );
  }
}