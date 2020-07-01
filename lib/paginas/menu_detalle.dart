import 'dart:async';
import 'dart:convert';
import 'package:stripe_native/stripe_native.dart';

import 'package:cabofind/paginas/stripe.dart';
import 'package:cabofind/utilidades/clasesilver.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//import 'reseña_insert.dart';

class Menu_detalle extends StatefulWidget {
//final Publicacion publicacion;
  final Publicacion menu;

  Menu_detalle({Key key, @required this.menu}) : super(key: key);

  @override
  Detalles createState() => new Detalles();
}

class Detalles extends State<Menu_detalle> {
  TextEditingController controller = TextEditingController();
  String _displayValue = "";
  String _displayValor = "";

  bool widgetcarac = false;

  bool isLoggedIn = false;
  List data;
  List data_serv;
  List data_serh;
  List data_hab;
  List dataneg;
  List data_carrusel;
  List data_car;
  List logos;
  List descripcion;
  int _counter = 0;

  Future<String> get receiptPayment async {
    /* custom receipt w/ useReceiptNativePay */
    const receipt = <String, double>{"Nice Hat": 5.00, "Used Hat": 1.50};
    var aReceipt = Receipt(receipt, "Hat Store");
    return await StripeNative.useReceiptNativePay(aReceipt);
  }

  Future<String> get orderPayment async {
    // subtotal, tax, tip, merchant name
    var order = Order(5.50, 1.0, 2.0, "Some Store");
    return await StripeNative.useNativePay(order);
  }

  Future<String> getInfo() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_menu_comidas.php?ID=${widget.menu.id_n}&MENU=${widget.menu.id_p}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      dataneg = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> getCarrusel() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/galeria_hotel_api.php?ID=${widget.menu.id_n}"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      data_carrusel = json.decode(response.body);
    });
    return "Success!";
  }

  Future<Map> getPortada() async {
    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/galeria_hotel_api2.php?ID=${widget.menu.id_n}");
    return json.decode(response.body);
  }

  void initState() {
    super.initState();
    // this.getCar();
    this.getCarrusel();
    this.getInfo();
    StripeNative.setPublishableKey(
        "pk_test_qRcqwUowOCDhl2bEuXPPCKDw00LMVoJpLi");
    StripeNative.setMerchantIdentifier("4525-9725-4152");
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (_counter >= 1) {
        _counter--;
      } else {}
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    _alertCar(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Caracteristicas',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              content: Container(
                  width: double.maxFinite,
                  height: 300.0,
                  child: ListView.builder(
                      itemCount: data == null ? 0 : data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                data[index]["CAR_NOMBRE"],
                                style: TextStyle(),
                              ),
                              padding: EdgeInsets.only(bottom: 15.0),
                            ),
                          ],
                        );
                      })),
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

    Widget carrusel = Container(
      child: new CarouselSlider.builder(
        autoPlay: true,
        height: 500.0,
        aspectRatio: 16 / 9,
        viewportFraction: 0.9,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayCurve: Curves.fastOutSlowIn,
        itemCount: data_carrusel == null ? 0 : data_carrusel.length,
        itemBuilder: (BuildContext context, int index) => Container(
          child: FadeInImage(
            image: NetworkImage(data_carrusel[index]["GAL_FOTO"]),
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / .5,

            // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
            placeholder: AssetImage('android/assets/images/loading.gif'),
            fadeInDuration: Duration(milliseconds: 200),
          ),
        ),
      ),
    );

    Widget titleSection = Container(
      //padding: const EdgeInsets.all(20),
      height: 50.0,
      child: new ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: dataneg == null ? 0 : dataneg.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              dataneg[index]["MENU_NOMBRE"],
              style: TextStyle(fontSize: 25),
            ),
          );
        },
      ),
    );

    Widget widgetinfo = Container(
      //padding: const EdgeInsets.all(20),
      height: 50.0,
      child: new ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: dataneg == null ? 0 : dataneg.length,
        itemBuilder: (BuildContext context, int index) {
          return new Column(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        color: Color(0xff01969a),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Icon(
                              FontAwesomeIcons.globeAmericas,
                              color: Colors.white,
                            ),
                            new Text(' Visitar sitio web',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ],
                        )),
                    // Sitioweb(dataneg: dataneg),

                    RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        color: Color(0xff01969a),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Icon(
                              FontAwesomeIcons.phoneAlt,
                              color: Colors.white,
                            ),
                            new Text(' Llamar',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    Widget textSection = Column(children: <Widget>[
      new ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: dataneg == null ? 0 : dataneg.length,
          itemBuilder: (BuildContext context, int index) {
            //padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20);
            return Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                dataneg[index]["MENU_DESC"],
                softWrap: true,
                overflow: TextOverflow.visible,
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            );
          })
    ]);

    return new Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
              expandedHeight: 230.0,
              floating: false,
              pinned: true,
              title: SABT(
                  child: Text(
                'testing',
                style: TextStyle(fontSize: 18),
              )),
              //title: Text(dataneg[0]["HOT_NOMBRE"],style: TextStyle(fontSize: 18),),
              automaticallyImplyLeading: true,
              flexibleSpace: FlexibleSpaceBar(
                //titlePadding: EdgeInsets.all(10.0),
                background: GestureDetector(
                  onTap: () {},
                  child: FutureBuilder(
                      future: getPortada(),
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
                                    color: Color(0xff01969a), fontSize: 25.0),
                                textAlign: TextAlign.center,
                              ));
                            } else {
                              String _portada = snapshot.data["GAL_FOTO"];
                              // String _matricula = snapshot.data["INT_MATRICULA"];
                              return CarouselSlider.builder(
                                autoPlay: true,
                                height: 250.0,
                                //aspectRatio: 16/9,
                                viewportFraction: 1.0,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayCurve: Curves.fastOutSlowIn,

                                itemCount: data_carrusel == null
                                    ? 0
                                    : data_carrusel.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        Container(
                                  child: FadeInImage(
                                    image: NetworkImage(
                                        data_carrusel[index]["GAL_FOTO"]),
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,

                                    // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                                    placeholder: AssetImage(
                                        'android/assets/images/loading.gif'),
                                    fadeInDuration: Duration(milliseconds: 200),
                                  ),
                                ),
                              );
                            }
                        }
                      }),
                ),
              ))
        ];
      },
      body: ListView(
        //shrinkWrap: true,
        //physics: BouncingScrollPhysics(),

        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              titleSection,
              //   widgetinfo,
              textSection,

              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffD3D7D6),
                ),
                child: Row(children: <Widget>[
                  Text(
                    ' Instrucciones especiales',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                  ),
                ]),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  style: TextStyle(fontSize: 15),
                  keyboardType: TextInputType.text,
                  controller: controller,
                  maxLines: 1,
                  decoration: InputDecoration(
                      focusColor: Color(0xffD3D7D6),
                      hoverColor: Color(0xffD3D7D6),
                      hintText:
                          'Agrega una nota (salsa adicional, sin cebolla, etc.)'),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                        shape:
                            CircleBorder(side: BorderSide(color: Colors.grey)),
                        onPressed: _decrementCounter,
                        child: Text(
                          '-',
                          style: TextStyle(fontSize: 50),
                        )),
                    Text(
                      '$_counter',
                      style: TextStyle(fontSize: 20),
                    ),
                    FlatButton(
                        shape:
                            CircleBorder(side: BorderSide(color: Colors.grey)),
                        onPressed: _incrementCounter,
                        child: Text(
                          '+',
                          style: TextStyle(fontSize: 50),
                        )),
                  ],
                ),
              ),
              Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _counter >= 1
                        ? InkWell(
                            onTap: () async {
                              Navigator.of(context).pop();
                              var token = await receiptPayment;

                              print(token);
                              /* After using the plugin to get a token, charge that token. On iOS the Apple-Pay sheet animation will signal failure or success using confirmPayment. Google-Pay does not have a similar implementation, so I may flash a SnackBar using wasCharged in a real application.
          call own charge endpoint w/ token
          const wasCharged = await AppAPI.charge(token, amount);
          then show success or failure
          StripeNative.confirmPayment(wasCharged);
          */
                              // Until this method below is called, iOS will spin a loading indicator on the Apple-Pay sheet
                              StripeNative.confirmPayment(
                                  true); // iOS load to check.
                              // StripeNative.confirmPayment(false); // iOS load to X.
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              height: 50,
                              width: 350,
                              decoration:
                                  BoxDecoration(color: Color(0xff01969a)),
                              child: Center(
                                child: Text(
                                  'Agregar $_counter al carrito • MXN \$350',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            height: 50,
                            width: 350,
                            decoration: BoxDecoration(color: Color(0xff9B9D9C)),
                            child: Center(
                              child: Text(
                                'Agregar $_counter al carrito • MXN \$0',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          )
                  ]),
              //  Divider(),

              //buttonSection(),
              SizedBox(
                height: 10.0,
              ),
              //ubersection,
            ],
          ),
        ],
      ),
    ));
  }
}
