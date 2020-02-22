import 'dart:convert';

import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class Myapp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
   return new MaterialApp(
   
        debugShowCheckedModeBanner:false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xff01969a),
          //primaryColor: Colors.blue,
          accentColor: Colors.black26,
        ),
        home: new Container(
            child:           new Rick_preparing()
        )
    );
  }
}
class Rick_preparing extends StatefulWidget {
//final Publicacion publicacion;
final Costos costos;

  @override

  Rick_preparing({Key key, @required this.costos}) : super(
    key: key);
@override
  Detalles createState() => new Detalles();

}

class Detalles extends State<Rick_preparing> {

  TextEditingController pedido =  TextEditingController();
  TextEditingController nombre =  TextEditingController();
  TextEditingController numero =  TextEditingController();
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
            "http://cabofind.com.mx/app_php/APIs/esp/list_playas.php"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          playas = json.decode(
              response.body);
        });


    return "Success!";
  }

  Future<String> getPagos() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_pagos.php"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          pagos = json.decode(
              response.body);
        });


    return "Success!";
  }
  void initState() {
     
   
    super.initState();   
    this.getPlaya();
    this.getPagos();
   

  }

  @override
  Widget build(BuildContext context) {
    
    alertMercado(context,cts1) async {  
      var total = int.parse(widget.costos.costo)+int.parse(cts1);
      String total2 = total.toString();

      if (total2=='250'){
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type AlertDialog
              return AlertDialog(
                title: new Text("Total a pagar \$$total "),
                content: new Text("Será dirigido a MercadoPago, una vez hecho el pago "+
                "favor de enviar captura con la confirmacion de pago a nuestro whatsapp o correo"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child: new Text("Aceptar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
      } else if (total2=='350'){
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type AlertDialog
              return AlertDialog(
                title: new Text("Total a pagar \$$total "),
                content: new Text("Será dirigido a MercadoPago, una vez hecho el pago "+
                "favor de enviar captura con la confirmacion de pago a nuestro whatsapp o correo"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child: new Text("Aceptar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
      } else if (total2=='500'){
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type AlertDialog
              return AlertDialog(
                title: new Text("Total a pagar \$$total "),
                content: new Text("Será dirigido a MercadoPago, una vez hecho el pago "+
                "favor de enviar captura con la confirmacion de pago a nuestro whatsapp o correo"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child: new Text("Aceptar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
      } else if (total2=='600'){
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type AlertDialog
              return AlertDialog(
                title: new Text("Total a pagar \$$total "),
                content: new Text("Será dirigido a MercadoPago, una vez hecho el pago "+
                "favor de enviar captura con la confirmacion de pago a nuestro whatsapp o correo"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child: new Text("Aceptar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
      } else if (total2=='800'){
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type AlertDialog
              return AlertDialog(
                title: new Text("Total a pagar \$$total "),
                content: new Text("Será dirigido a MercadoPago, una vez hecho el pago "+
                "favor de enviar captura con la confirmacion de pago a nuestro whatsapp o correo"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child: new Text("Aceptar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
      } else if (total2=='900'){
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type AlertDialog
              return AlertDialog(
                title: new Text("Total a pagar \$$total "),
                content: new Text("Será dirigido a MercadoPago, una vez hecho el pago "+
                "favor de enviar captura con la confirmacion de pago a nuestro whatsapp o correo"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child: new Text("Aceptar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
      }
     
   }
    alertPaypal(context,cts1) async {  
      var total = int.parse(widget.costos.costo)+int.parse(cts1);
     return showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type AlertDialog
              return AlertDialog(
                title: new Text("Total a pagar \$$total "),
                content: new Text("Será dirigido a paypal, una vez hecho el pago "+
                "favor de enviar captura con la confirmacion de pago a nuestro whatsapp o correo"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child: new Text("Aceptar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
   }

    return new Scaffold(
        appBar: AppBar(
          title: Text('Rickys Corner'),
        ),
        body: ListView(
          children: <Widget>[
          Form(
            
             key:_formKey ,
              child: Container(
                padding: const EdgeInsets.all(15),
                 width: MediaQuery.of(context).size.width,
                 height:MediaQuery.of(context).size.height,
                 child:Column(
              children: <Widget>[ 
              Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[
                Column(children: <Widget>[
                  Text("Paquete seleccionado: "),
                  Text(widget.costos.paquete)
                ],),
                Column(children: <Widget>[
                   Text("Precio total: "),
                  Text(widget.costos.costo)
                ],),
              ],),
              SizedBox(height:15.0),
              Center(
                child: Text(
                                        "El precio puede variar dependiendo de la playa seleccionada",
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0),
                                      ),
              ),
                            SizedBox(height:15.0),

              TextFormField(    
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo no puede estar vacío';
                  } else if (value.length <=3) {
                    return 'Requiere minimi 4 letras';

                  }
                  return null;
                },           
                decoration: new InputDecoration(
                        labelText: "TU NOMBRE",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                        //fillColor: Colors.green
                      ),           
                keyboardType: TextInputType.text, 
                controller: nombre,
                maxLines: 1, 
                ),
                SizedBox(height:10.0), 
                TextFormField(    
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo no puede estar vacío';
                  } else if (value.length <=9) {
                    return 'Requiere 10 dígitos';

                  }
                  return null;
                },            
                decoration: new InputDecoration(
                        labelText: "TU CELULAR",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                        //fillColor: Colors.green
                      ),   
                keyboardType: TextInputType.phone,    
                inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly], 
                   
                controller: numero,
                maxLines: 1, 
                ),   
              SizedBox(height:10.0),
              InputDecorator(
                decoration:  new InputDecoration(
                        labelText: "Seleccionar Playa",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                        //fillColor: Colors.green
                      ), 
                  child: DropdownButton(
                  items: playas.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(item['NOM_PLAYA']),
                      value: item['ID_PLAYA'].toString(),

                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      _mySelection = newVal;
                      var one = int.parse(newVal);

                      /*String id = playas[one]['PRE_PLAYA'];                      
                      print(_mySelection);
                      print(newVal);
                      print(id);*/
                    });
                  },
                  value: _mySelection,
                  focusColor: Colors.red,           
                  isExpanded: true,        

                ),  
                
              ),
              
              SizedBox(height:10.0),              
              FlatButton(
                onPressed:(){
                  DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(2020, 1, 1),
                                        maxTime: DateTime(2025, 12, 31), 
                                        onChanged: (date) {
                                      print('confirm $date');
                                      _date = '${date.year} - ${date.month} - ${date.day}';
                                      setState(() {});
                                    }, currentTime: DateTime.now(), locale: LocaleType.es);
                } ,
                  child: InputDecorator(                
                  decoration:  new InputDecoration(
                          labelText: "Fecha seleccionada",
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                            ),
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
              SizedBox(height:15.0),
              FlatButton(

                onPressed:(){
                  DatePicker.showTimePicker(context,
                    theme: DatePickerTheme(
                      containerHeight: 210.0,
                    ),
                    showTitleActions: true, onConfirm: (time) {
                  print('confirm $time');
                    _time = '${time.hour} : ${time.minute} : ${time.second}';
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.es);
                  setState(() {});
                } ,
                  child: InputDecorator(                
                  decoration:  new InputDecoration(
                          labelText: "Hora seleccionada",
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                            ),
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
              SizedBox(height:15.0),
              Center(
                child: Text(
                                        "Formas de pago",
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0),
                                      ),
              ),
          SizedBox(height:15.0),

          Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.ccPaypal), 
             onPressed:() {

               if (_mySelection=='1'){
                 final String cts1 ='100';
                 alertPaypal(context, cts1);
               }else if (_mySelection=='2'){
                 print("santaalv");
                 final String cts1 ='100';
                 alertPaypal(context, cts1);
               }else if (_mySelection=='3'){
                 final String cts1 ='0';
                 print("cascadasalv");
                 alertPaypal(context, cts1);
               }else if (_mySelection=='4'){
                final String cts1 ='0';
                print("medanoalv");
                alertPaypal(context, cts1);
               }
               //
               },
             backgroundColor:Color(0xff01969a),heroTag: "bt1",elevation: 0.0,),
             Text('Paypal', style: TextStyle(color: Colors.black),),
           ],
         ),
/*
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.ccApplePay), onPressed:() => (context),backgroundColor:Color(0xff01969a),heroTag: "bt2",elevation: 0.0,),
             Text('Tarjeta', style: TextStyle(color: Colors.black),),

           ],
         ),*/
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.handshake), 
             onPressed:(){
               if (_mySelection=='1'){
                 final String cts1 ='100';
                 alertMercado(context, cts1);
               }else if (_mySelection=='2'){
                 print("santamercado");
                 final String cts1 ='100';
                 alertMercado(context, cts1);
               }else if (_mySelection=='3'){
                 final String cts1 ='0';
                 print("cascadasmercado");
                 alertMercado(context, cts1);
               }else if (_mySelection=='4'){
                final String cts1 ='0';
                print("medanomercado");
                alertMercado(context, cts1);
               }
             },
             backgroundColor:Color(0xff01969a),heroTag: "bt3",elevation: 0.0,),
             Text('MercadoPago', style: TextStyle(color: Colors.black),),

           ],
         ),
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.dollarSign), onPressed:()  => (context),backgroundColor:Color(0xff01969a),heroTag: "bt3",elevation: 0.0,),
             Text('Efectivo', style: TextStyle(color: Colors.black),),

           ],
         ),
         
         Column(
           children: <Widget>[
             
           ],
         ),
       ],
         )
               
                ],
                 )
                 
               ),
           )
          ]
        ),
      
    );
  }
}