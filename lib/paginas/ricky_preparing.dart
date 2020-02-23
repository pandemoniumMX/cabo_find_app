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

  Future<String> sendMail(total,cts1, nombre1, numero1, _mySelection, pago) async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insert_rickys.php?NOMBRE=${nombre1}&CELULAR=${numero1}&PLAYA=${_mySelection}&FECHA=${_date}&HORA=${_time}&PAQUETE=${widget.costos.paquete}&TOTAL=${total}&PAGO=${pago}&PLATAFORMA=ANDROID"),

        headers: {
          "Accept": "application/json"
        }
    );
    
    if (_mySelection=='4'){
var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/sendmail.php?NOMBRE=${nombre1}&CELULAR=${numero1}&PLAYA=Medano&FECHA=${_date}&HORA=${_time}&PAQUETE=${widget.costos.paquete}&TOTAL=${total}&PAGO=${pago}"),

        headers: {
          "Accept": "application/json"
        }
    );
    } else if (_mySelection=='3'){
      var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/sendmail.php?NOMBRE=${nombre1}&CELULAR=${numero1}&PLAYA=8Cascadas&FECHA=${_date}&HORA=${_time}&PAQUETE=${widget.costos.paquete}&TOTAL=${total}&PAGO=${pago}"),

        headers: {
          "Accept": "application/json"
        }
    );

    } else if (_mySelection=='2'){
      var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/sendmail.php?NOMBRE=${nombre1}&CELULAR=${numero1}&PLAYA=SantaMaría&FECHA=${_date}&HORA=${_time}&PAQUETE=${widget.costos.paquete}&TOTAL=${total}&PAGO=${pago}"),

        headers: {
          "Accept": "application/json"
        }
    );

    } else if (_mySelection=='1'){
      var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/sendmail.php?NOMBRE=${nombre1}&CELULAR=${numero1}&PLAYA=Chileno&FECHA=${_date}&HORA=${_time}&PAQUETE=${widget.costos.paquete}&TOTAL=${total}&PAGO=${pago}"),

        headers: {
          "Accept": "application/json"
        }
    );

    }
    
    return "Success!";
  }

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

  Future<String> insertRickys(total,cts1, nombre1, numero1, _mySelection, pago) async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insert_rickys.php?NOMBRE=${nombre1}&CELULAR=${numero1}&PLAYA=${_mySelection}&FECHA=${_date}&HORA=${_time}&PAQUETE=${widget.costos.paquete}&TOTAL=${total}&PAGO=${pago}&PLATAFORMA=ANDROID"),

        headers: {
          "Accept": "application/json"
        }
    );



    return "Success!";
  }

  Future<String> getPagos(id_fp) async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_pagos.php?ID=${id_fp}"),

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
    //this.getPagos();
   

  }

  @override
  Widget build(BuildContext context) {

    _urlMercado250() async {
    final url =  "https://www.mercadopago.com.mx/checkout/v1/redirect?pref_id=528197060-1244bd6c-253e-49e9-8368-a6a21345e996";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     } 
    }
    _urlMercado350() async {
      final url =  "https://www.mercadopago.com.mx/checkout/v1/redirect?pref_id=528197060-8616adc5-5e58-4726-9be8-ef6727a837a7";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     } 
    } 
    _urlMercado500() async {
      final url =  "https://www.mercadopago.com.mx/checkout/v1/redirect?pref_id=528197060-8a4d9d78-0129-40a6-908b-8c200624e45b";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     } 
    } 
    _urlMercado600() async {
      final url =  "https://www.mercadopago.com.mx/checkout/v1/redirect?pref_id=528197060-c644126f-e4c8-405f-bbcf-97d053a6d3f5";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     } 
    } 
    _urlMercado800() async {
      final url =  "https://www.mercadopago.com.mx/checkout/v1/redirect?pref_id=528197060-6b2ccb85-39e6-4f87-b53c-391e9fd5c468";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     } 
    } 
    _urlMercado900() async {
      final url =  "https://www.mercadopago.com.mx/checkout/v1/redirect?pref_id=528197060-5275ee98-8ca3-4250-a34b-2d62f88ca681";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     } 
    } 
    
    _urlPaypal() async {
      final url =  "https://www.paypal.me/rickyscornerparadise";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     } 
    } 

    _urlCash() async {
      final url =  "https://www.paypal.me/rickyscornerparadise";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     } 
    } 

    void showResena() {
      Fluttertoast.showToast(
          msg: "Paquete agendado correctamente, te llamaremos en breve",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          timeInSecForIos:5);
    }
    alertMercado(context,cts1,nombre1,numero1, _mySelection) async { 
      var total = int.parse(widget.costos.costo)+int.parse(cts1);
      String total2 = total.toString();
      var pago = 'MercadoPago';

      if (total2=="250"){
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type AlertDialog
              return AlertDialog(
                title: new Text("Total a pagar \$$total "),
                content: new Text("Será dirigido a MercadoPago, una vez hecho el pago "+
                "nos comunicaremos lo antes posible al número que nos proporcionó."),
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
                    onPressed: (){
                       sendMail(total,cts1,nombre1,numero1,_mySelection, pago);
                       insertRickys(total,cts1,nombre1,numero1,_mySelection, pago);
                       showResena();
                       Navigator.of(context).pop();
                      _urlMercado250();
                        }
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
                "nos comunicaremos lo antes posible al número que nos proporcionó."),
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
                    onPressed: (){
                       sendMail(total,cts1,nombre1,numero1,_mySelection, pago);
                       insertRickys(total,cts1,nombre1,numero1,_mySelection, pago);
                       showResena();
                       Navigator.of(context).pop();
                      _urlMercado350();
                      }
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
                "nos comunicaremos lo antes posible al número que nos proporcionó."),
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
                    onPressed: (){
                       sendMail(total,cts1,nombre1,numero1,_mySelection, pago);
                       insertRickys(total,cts1,nombre1,numero1,_mySelection, pago);
                       showResena();
                       Navigator.of(context).pop();
                      _urlMercado500();
                      }
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
                "nos comunicaremos lo antes posible al número que nos proporcionó."),
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
                    onPressed: (){
                       sendMail(total,cts1,nombre1,numero1,_mySelection, pago);
                       insertRickys(total,cts1,nombre1,numero1,_mySelection, pago);
                       showResena();
                       Navigator.of(context).pop();
                      _urlMercado600();
                      }
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
                "nos comunicaremos lo antes posible al número que nos proporcionó."),
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
                    onPressed: (){
                       sendMail(total,cts1,nombre1,numero1,_mySelection, pago);
                       insertRickys(total,cts1,nombre1,numero1,_mySelection, pago);
                       showResena();
                       Navigator.of(context).pop();
                      _urlMercado800();
                      }
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
                "nos comunicaremos lo antes posible al número que nos proporcionó."),
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
                    onPressed: (){
                       sendMail(total,cts1,nombre1,numero1,_mySelection, pago);
                       insertRickys(total,cts1,nombre1,numero1,_mySelection, pago);
                       showResena();
                       Navigator.of(context).pop();
                      _urlMercado900();
                      }
                  ),
                ],
              );
            },
          );
      }
     
   }
    alertPaypal(context,cts1,nombre1,numero1, _mySelection) async {  
      var total = int.parse(widget.costos.costo)+int.parse(cts1);
      var pago = 'Paypal';
      
     
      print(_mySelection);
     return showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type AlertDialog
              return AlertDialog(
                title: new Text("Total a pagar \$$total "),
                content: new Text("Será dirigido a paypal, una vez hecho el pago "+
                "nos comunicaremos lo antes posible al número que nos proporcionó."),
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
                    onPressed: (){
                       sendMail(total,cts1,nombre1,numero1,_mySelection, pago);
                       insertRickys(total,cts1,nombre1,numero1,_mySelection, pago);
                       showResena();
                       Navigator.of(context).pop();
                      _urlPaypal();
                      }
                  ),
                ],
              );
            },
          );
   }

   alertCash(context,cts1,nombre1,numero1, _mySelection) async {  
      var total = int.parse(widget.costos.costo)+int.parse(cts1);
      var pago = 'Efectivo';
     return showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type AlertDialog
              return AlertDialog(
                title: new Text("Total a pagar \$$total "),
                content: new Text("El monto total lo pagará cuando se "+
                "le entregue el paquete seleccionado, nos comunicaremos con usted lo antes posible al número proporcionado."),
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
                    onPressed: (){
                      

                       sendMail(total,cts1,nombre1,numero1,_mySelection, pago);
                       //insertRickys(total,cts1,nombre1,numero1,_mySelection, pago);
                       showResena();
                       Navigator.of(context).pop();     
                                          
                     
                              
                      }
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
               final numero1 = numero.text;
               final nombre1 = nombre.text;
               if (_formKey.currentState.validate()) {

               if (_mySelection=='1'){
                final String cts1 ='100';
                 
                 alertPaypal(context, cts1, nombre1, numero1, _mySelection);
               }else if (_mySelection=='2'){
                 print("santaalv");
                 final String cts1 ='100';
                 alertPaypal(context, cts1, nombre1, numero1, _mySelection);
               }else if (_mySelection=='3'){
                 final String cts1 ='0';
                 print("cascadasalv");
                 alertPaypal(context, cts1, nombre1, numero1, _mySelection);
               }else if (_mySelection=='4'){
                final String cts1 ='0';
                print("medanoalv");  
                alertPaypal(context, cts1, nombre1, numero1, _mySelection);

               }

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
               final numero1 = numero.text;
               final nombre1 = nombre.text;
               if (_formKey.currentState.validate()) {
                if (_mySelection=='1'){
                 final String cts1 ='100';
                 alertMercado(context, cts1, nombre1, numero1, _mySelection);
                 
               }else if (_mySelection=='2'){
                 print("santamercado");
                 final String cts1 ='100';
                 alertMercado(context, cts1, nombre1, numero1, _mySelection);
               }else if (_mySelection=='3'){
                 final String cts1 ='0';
                 print("cascadasmercado");
                 alertMercado(context, cts1, nombre1, numero1, _mySelection);
               }else if (_mySelection=='4'){
                final String cts1 ='0';
                print("medanomercado");
                alertMercado(context, cts1, nombre1, numero1, _mySelection);
               }


               }
               
             },
             backgroundColor:Color(0xff01969a),heroTag: "bt3",elevation: 0.0,),
             Text('MercadoPago', style: TextStyle(color: Colors.black),),

           ],
         ),
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.dollarSign),
              onPressed: (){
                final numero1 = numero.text;
                final nombre1 = nombre.text;
                if (_formKey.currentState.validate()) {
                if (_mySelection=='1'){
                 final String cts1 ='100';
                 alertCash(context, cts1, nombre1, numero1, _mySelection);
                 
               }else if (_mySelection=='2'){
                 print("santacash");
                 final String cts1 ='100';
                 alertCash(context, cts1, nombre1, numero1, _mySelection);
               }else if (_mySelection=='3'){
                 final String cts1 ='0';
                 print("cascadascash");
                 alertCash(context, cts1, nombre1, numero1, _mySelection);
               }else if (_mySelection=='4'){
                final String cts1 ='0';
                print("medanocash");
                alertCash(context, cts1, nombre1, numero1, _mySelection);
               }

                }
                
                },
              backgroundColor:Color(0xff01969a),heroTag: "bt3",elevation: 0.0,),
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