import 'dart:async';
import 'dart:convert';
import 'package:cabofind/carrito/cart_bloc.dart';
import 'package:cabofind/carrito/cart_page.dart';
import 'package:cabofind/paginas/preparing.dart';
import 'package:provider/provider.dart';
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
  List extra;

  List dataneg;
  List data_carrusel;
  List logos;
  List descripcion;
  int _counter = 0;
  int _costo = 0;
  int _suma = 0;
  int _suma_ex = 0;

  bool _value = true;
  var factorial = 0;
  var userStatus = List<bool>();

  Cart serverData;
  String encodeData;

  //var cart = bloc.cart;

  //List<Cart> _cartList = List<Cart>();

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
      //  userStatus.add(false);
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

  Future<String> getExtras() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_extras_menu.php?ID=${widget.menu.id_n}"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      extra = json.decode(response.body);
      userStatus.add(false);
    });
    for (var u in extra) {
      userStatus.add(false);
    }
    return "Success!";
  }

  Future<Map> getPortada() async {
    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/galeria_hotel_api2.php?ID=${widget.menu.id_n}");
    return json.decode(response.body);
  }

  void initState() {
    super.initState();
    this.getExtras();
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

    Widget textSection = Column(children: <Widget>[
      new ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: dataneg == null ? 0 : dataneg.length,
          itemBuilder: (BuildContext context, int index) {
            var suma = int.parse(dataneg[index]["MENU_COSTO"]);
            var item = dataneg[index];

            _suma = suma;
            print(suma);
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    dataneg[index]["MENU_DESC"],
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xffD3D7D6),
                  ),
                  child: Row(children: <Widget>[
                    Text(
                      ' Instrucciones especiales',
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.normal),
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
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.grey)),
                          onPressed: () {
                            _decrementCounter();
                            setState(() {
                              if (_counter >= 1) {
                                //   _costo = 0;
                                // _counter = 0;
                                _costo = _costo - _suma;
                              } else if (_counter == 0) {
                                _costo = 0;
                                userStatus[0] = false;
                                userStatus[1] = false;
                                userStatus[2] = false;
                                userStatus[3] = false;
                                userStatus[4] = false;
                                userStatus[5] = false;
                                userStatus[6] = false;
                                userStatus[7] = false;
                                userStatus[8] = false;
                                userStatus[9] = false;
                                /*      for (var i = 9; i >= 0; i--) {
                                userStatus[i] = false;
                              }*/

                                //   extras;
                              }
                            });
                          },
                          child: Text(
                            '-',
                            style: TextStyle(fontSize: 50),
                          )),
                      Text(
                        '$_counter',
                        style: TextStyle(fontSize: 20),
                      ),
                      FlatButton(
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.grey)),
                          onPressed: () {
                            _incrementCounter();
                            setState(() {
                              _costo = _costo + _suma;
                            });
                          },
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
                                String _orden = dataneg[index]["MENU_NOMBRE"];
                                String _costos = _costo
                                    .toString(); //int.parse(_costo);// int.parse(_costo);
                                String _nota = controller.text;

                                serverData = new Cart(_orden, _costos, _nota);
                                encodeData = jsonEncode(serverData);
                                print(encodeData);
                                // _cartList.addCart(widget.menu.id_n);
                                //  bloc.addToCart(dataneg);
                                /* Navigator.of(context).pop();
                              var token = await receiptPayment;
                              print(token);                             
                              StripeNative.confirmPayment(true); */
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
                                    'Agregar $_counter al carrito • MXN \$ $_costo',
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
                              decoration:
                                  BoxDecoration(color: Color(0xff9B9D9C)),
                              child: Center(
                                child: Text(
                                  'Agregar $_counter al carrito • MXN \$ $_costo',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            )
                    ]),
              ],
            );
          })
    ]);

    Widget extras = Column(children: <Widget>[
      new ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: extra == null ? 0 : extra.length,
          itemBuilder: (BuildContext context, int index) {
            var suma_ex = int.parse(extra[index]["EXT_PRECIO"]);
            _suma_ex = suma_ex;
            var item = extra[index]["EXT_NOMBRE"];

            //   Bool indexMaster = userStatus[index];
            return Column(children: [
              Container(
                margin: EdgeInsets.all(1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      extra[index]["EXT_NOMBRE"],
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    Text(
                      '\$' + extra[index]["EXT_PRECIO"],
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
              ),
              CheckboxListTile(
                activeColor: Color(0xff01969a),
                value: userStatus[index],
                onChanged: (bool val) {
                  if (val == true) {
                    /* setState(() {
                      userStatus[index] = !userStatus[index];
                      if (_counter >= 1) {
                        _costo = _costo + _suma_ex;
                        if (!_cartList.contains(item))
                          _cartList.add(item);
                        else
                          _cartList.remove(item);
                      } else if (_counter == 0) {
                        userStatus[index] = false;
                      }
                    });*/
                  } else {
                    setState(() {
                      userStatus[index] = !userStatus[index];
                      if (_counter >= 1) {
                        _costo = _costo - _suma_ex;
                      } else if (_counter == 0) {
                        userStatus[index] = false;
                      }
                    });
                  }
                },
                subtitle: 2 == userStatus[index]
                    ? Text(
                        'Requiere.',
                        style: TextStyle(color: Colors.red),
                      )
                    : null,

                //controlAffinity: ListTileControlAffinity.leading,
              ),
            ]);
          }),
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
                              itemBuilder: (BuildContext context, int index) =>
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
            ),
            actions: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Preparing()));
                },
                child: new Stack(
                  children: [
                    Center(
                      child: new Row(children: <Widget>[
                        new Icon(FontAwesomeIcons.shoppingCart),
                        Text(
                          "  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.0),
                        ),
                      ]),
                    ),
                    Positioned(
                      height: 20,
                      width: 20,
                      right: 1.0,
                      bottom: 28,
                      child: new FloatingActionButton(
                        child: new Text('1',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.0,
                                color: Colors.white)),
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
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
              /*   Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffD3D7D6),
                ),
                child: Row(children: <Widget>[
                  Text(
                    ' Ingredientes',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                  ),
                ]),
              ),*/
              // extras,

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
