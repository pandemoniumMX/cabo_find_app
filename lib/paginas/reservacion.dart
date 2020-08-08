import 'dart:convert';

import 'package:cabofind/paginas/ricky.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.black,
          //primaryColor: Colors.black,
          accentColor: Colors.black26,
        ),
        home: new Container(child: new Reservacion()));
  }
}

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
  String _mySelection;
  String _mispagos;
  List playas;
  List pagos;
  final _formKey = GlobalKey<FormState>();
  String _date = "No seleccionada";
  String _time = "No seleccionada";

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
    var response1 = await http.get(
        Uri.encodeFull(
            'http://cabofind.com.mx/app_php/sendmails/sendmail_reservacion.php?NOM=${nombre1}&NUM=${numero1}&NEGOCIO=${widget.reserva.nombre}&TIPO_R=${widget.reserva.tipo_r}&TIPO_N=${widget.reserva.tipo_n}&PERSONAS=${_mySelection}&CORREO=${correo1}&FECHA=${_date}&HORA=${_time}&PARA=${widget.reserva.correo}'),
        headers: {"Accept": "application/json"});
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insert_reservacion.php?NOM=${nombre1}&NUM=${numero1}&NEGOCIO=${widget.reserva.nombre}&ID_NEGOCIO=${widget.reserva.id}&TIPO_R=${widget.reserva.tipo_r}&TIPO_N=${widget.reserva.tipo_n}&PERSONAS=${_mySelection}&CORREO=${correo1}&FECHA=${_date}&HORA=${_time}&PLATAFORMA=ANDROID&IDIOMA=ESP"),
        headers: {"Accept": "application/json"});

    return "Success!";
  }

  void initState() {
    super.initState();
    this.getPlaya();
  }

  @override
  Widget build(BuildContext context) {
    void showResena() {
      Fluttertoast.showToast(
          msg:
              "Reservación hecha existosamente, recibiras confirmacion vìa email en los proximos minutos!",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          timeInSecForIos: 5);
    }

    alertPaypal(context, nombre1, numero1, correo1, _mySelection) async {
      print(_mySelection);
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
          child: Container(
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15.0),
                  Center(
                    child: Text(
                      "Llena todo los campos por favor, verificar que el horario seleccionado este disponible en el negocio",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      } else if (value.length <= 3) {
                        return 'Requiere minimo 4 letras';
                      }
                      return null;
                    },
                    decoration: new InputDecoration(
                      labelText: "NOMBRE COMPLETO",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    keyboardType: TextInputType.text,
                    controller: nombre,
                    maxLines: 1,
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      } else if (value.length <= 9) {
                        return 'Requiere 10 dígitos';
                      }
                      return null;
                    },
                    decoration: new InputDecoration(
                      labelText: "CELULAR",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    controller: numero,
                    maxLines: 1,
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      } else if (value.length <= 9) {
                        return 'Requiere 10 dígitos';
                      }
                      return null;
                    },
                    decoration: new InputDecoration(
                      labelText: "CORREO",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: correo,
                    maxLines: 1,
                  ),
                  SizedBox(height: 10.0),
                  InputDecorator(
                    decoration: new InputDecoration(
                      labelText: "Número de personas",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    child: DropdownButton(
                      items: playas.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['PER_NOMBRE']),
                          value: item['ID_PERSONA'].toString(),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          _mySelection = newVal;
                          var one = int.parse(newVal);
                        });
                      },
                      value: _mySelection,
                      focusColor: Colors.red,
                      isExpanded: true,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  FlatButton(
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2020, 1, 1),
                          maxTime: DateTime(2025, 12, 31), onChanged: (date) {
                        print('confirm $date');
                        _date = '${date.year} - ${date.month} - ${date.day}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.es);
                    },
                    child: InputDecorator(
                      decoration: new InputDecoration(
                        labelText: "Fecha seleccionada",
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      child: Text(
                        " $_date",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  FlatButton(
                    onPressed: () {
                      DatePicker.showTimePicker(context,
                          theme: DatePickerTheme(
                            containerHeight: 210.0,
                          ),
                          showTitleActions: true, onConfirm: (time) {
                        print('confirm $time');
                        _time =
                            '${time.hour} : ${time.minute} : ${time.second}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.es);
                      setState(() {});
                    },
                    child: InputDecorator(
                      decoration: new InputDecoration(
                        labelText: "Hora seleccionada",
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      child: Text(
                        " $_time",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton(
                                  onPressed: () {
                                    final nombre1 = nombre.text;
                                    final numero1 = numero.text;
                                    final correo1 = correo.text;
                                    if (_formKey.currentState.validate()) {
                                      alertPaypal(context, nombre1, numero1,
                                          correo1, _mySelection);
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(40.0)),
                                  color: Colors.black,
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text('Reservar ahora ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                      new Icon(
                                        FontAwesomeIcons.calendarAlt,
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
              )),
        )
      ]),
    );
  }
}
