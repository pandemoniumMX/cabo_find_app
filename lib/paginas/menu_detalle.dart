import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/preparing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stripe_native/stripe_native.dart';
import 'package:cabofind/utilidades/clasesilver.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'list_manejador_menus.dart';

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

  bool widgetcarac = false;
  final _formKey = GlobalKey<FormState>();
  bool isLoggedIn = false;
  List data;
  List extra;
  List _complementos;
  String _extras1;
  String _extras2;
  String _extras3;
  String holder = '';
  List dataneg;
  List logos;
  List descripcion;
  int _counter = 0;
  double _costo = 0;
  double _costocu = 0;
  double _subtotal = 0;
  double _suma = 0;
  double _suma_ex = 0;
  double _suma_ex2 = 0;

  var factorial = 0;
  var userStatus = List<bool>();
  var _multiple = List<String>();

  String encodeData;
  String idn = '';

  List customers = [];

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
            "http://cabofind.com.mx/app_php/APIs/esp/list_menu_comidas_single.php?ID=${widget.menu.id_n}&MENU=${widget.menu.id_p}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      dataneg = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> _insertPedidoSingle(int cantidad, double costo, String nota,
      String extra1, String extra2, double costoex1, double costoex2) async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insert_carrito_single.php?ID=${widget.menu.id_n}&MENU=${widget.menu.id_p}&IDF=$_mail2&CANTIDAD=${cantidad}&COSTO=${costo}&NOTA=${nota}&EXTRA1=${extra1}&EXTRA2=${extra2}&EXTRA1COSTO=${costoex1}&EXTRA2COSTO=${costoex2}"),
        headers: {"Accept": "application/json"});

    return "Success!";
  }

  Future<String> getExtras() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_extras_menu.php?ID=${widget.menu.id_p}"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      extra = json.decode(response.body);
      //  userStatus.add(false);
    });
    for (var u in extra) {
      // userStatus.add(false);
    }
    return "Success!";
  }

  Future<Map> getPortada() async {
    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/galeria_menu_portada.php?ID=${widget.menu.id_p}");
    return json.decode(response.body);
  }

  Future<Map> _countCart() async {
    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/list_count_cart.php?ID=${widget.menu.id_n}");
    return json.decode(response.body);
  }

  void initState() {
    super.initState();
    this.getExtras();
    // this.getCar();
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
    void showResena() {
      Fluttertoast.showToast(
          msg: "Necesitas agregar mínimo 1 platillo",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          timeInSecForIos: 1);
    }

    Widget titleSection = Container(
      //padding: const EdgeInsets.all(20),
      height: 40.0,
      child: new ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: dataneg == null ? 0 : dataneg.length,
        itemBuilder: (BuildContext context, int index) {
          var suma = double.parse(dataneg[index]["MENU_COSTO"]);
          // String idnx = dataneg[index]["ID_NEGOCIO"];
          _costocu = suma;

          idn = widget.menu.id_n;

          if (_counter >= 1) {
            //  _costo = suma;
          }
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

    /*Widget extras = dataneg[0]["MENU_EXTRA_TIPO"] != null
        ? Column(children: <Widget>[
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xffD3D7D6),
              ),
              child: Row(children: <Widget>[
                Text(
                  ' ' + dataneg[0]["MENU_EXTRA_TIPO"],
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                )
              ]),
            ),
            new ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: extra == null ? 0 : extra.length,
                itemBuilder: (BuildContext context, int index) {
                  var suma_ex = int.parse(extra[index]["EXT_PRECIO"]);
                  _suma_ex = suma_ex;
                  var item = extra[index]["EXT_NOMBRE"];

                  return Column(children: [
                    Container(
                      margin: EdgeInsets.all(1),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            extra[index]["EXT_NOMBRE"],
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          Text(
                            ' \$' + extra[index]["EXT_PRECIO"],
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          Expanded(
                            flex: 1,
                            child: CheckboxListTile(
                              activeColor: Colors.green,
                              value: userStatus[index],
                              onChanged: (bool val) {
                                if (val == true) {
                                  setState(() {
                                    userStatus[index] = !userStatus[index];

                                    String name = extra[index]["EXT_NOMBRE"];
                                    String costo = extra[index]["EXT_PRECIO"];

                                    if (_counter >= 1) {
                                      _costo = _costo + _suma_ex;

                                      customers.add(Dibs(name, costo));

                                      print(customers);
                                    } else if (_counter == 0) {
                                      userStatus[index] = false;
                                      showResena();
                                    }
                                  });
                                } else {
                                  setState(() {
                                    String name = extra[index]["EXT_NOMBRE"];
                                    String costox = extra[index]["EXT_PRECIO"];
                                    _costo = _costo - _suma_ex;
                                    userStatus[index] = !userStatus[index];
                                    customers.remove(Dibs(name, costox));

                                    print(customers);
                                    if (_counter >= 1) {
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
                                  : Text(
                                      '',
                                      style: TextStyle(color: Colors.red),
                                    ),

                              //controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]);
                }),
          ])
        : SizedBox();*/

    void _confirmacion() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Alerta"),
            content: new Text(
              "¿Que desea hacer?",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Seguir ordenando"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Menu_manejador(manejador: new Users(idn))));
                },
              ),
              new FlatButton(
                child: new Text("Pagar"),
                onPressed: () {
                  String notax = controller.text;
                  _insertPedidoSingle(_counter, _costocu, notax, _extras1,
                      _extras2, _suma_ex, _suma_ex2);
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Preparing(negocio: new Users(idn))));
                },
              ),
            ],
          );
        },
      );
    }

    ;

    Widget extras2 = dataneg[0]["MENU_EXTRA_TIPO"] != null
        ? Column(children: <Widget>[
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xffD3D7D6),
              ),
              child: Row(children: <Widget>[
                Text(
                  ' ' + dataneg[0]["MENU_EXTRA_TIPO"],
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                )
              ]),
            ),
            dataneg[0]["MENU_REQUIERE"] == '1'
                ? Column(children: <Widget>[
                    _counter >= 1
                        ? DropdownButtonFormField(
                            items: extra.map((item) {
                              return new DropdownMenuItem(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Text(item['EXT_NOMBRE'] + ' '),
                                      Text('\$' + item['EXT_PRECIO'])
                                    ]),
                                onTap: () {
                                  var suma_ex =
                                      double.parse(item['EXT_PRECIO']);
                                  if (_counter >= 1) {
                                    if (_suma_ex == 0) {
                                      _suma_ex = suma_ex;
                                      _costo = _costo + _suma_ex;
                                      print(suma_ex);
                                    } else if (_suma_ex != 0) {
                                      _costo = _costo - _suma_ex;
                                      _suma_ex = suma_ex;
                                      _costo = _costo + _suma_ex;
                                    }
                                  }
                                },
                                value: item['ID_EXTRAS'].toString(),
                              );
                            }).toList(),
                            onTap: null,
                            onChanged: (newVal) {
                              setState(() {
                                if (_counter >= 1) {
                                  /* var suma_ex = (newVal['EXT_PRECIO']);
                            _suma_ex = suma_ex;*/
                                  // _costo = _costo + _suma_ex;
                                  _extras1 = newVal;
                                }
                              });
                            },
                            validator: (value) =>
                                value == null ? 'Campo requerido' : null,
                            hint: Text('Seleccionar'),
                            value: _extras1,
                            isExpanded: true,
                          )
                        : DropdownButtonFormField(
                            items: extra.map((item) {}).toList(),
                            onTap: null,
                            validator: (value) =>
                                value == null ? 'field required' : null,
                            hint: Text('Selecciona un ingrediente'),
                            value: _extras1,
                            isExpanded: true,
                          )
                  ])
                : dataneg[0]["MENU_REQUIERE"] == '2'
                    ? Column(children: <Widget>[
                        _counter >= 1
                            ? DropdownButtonFormField(
                                items: extra.map((item) {
                                  return new DropdownMenuItem(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          new Text(item['EXT_NOMBRE'] + ' '),
                                          Text('\$' + item['EXT_PRECIO'])
                                        ]),
                                    onTap: () {
                                      var suma_ex =
                                          double.parse(item['EXT_PRECIO']);
                                      if (_counter >= 1) {
                                        if (_suma_ex == 0) {
                                          _suma_ex = suma_ex;
                                          _costo = _costo + _suma_ex;
                                          print(suma_ex);
                                        } else if (_suma_ex != 0) {
                                          _costo = _costo - _suma_ex;
                                          _suma_ex = suma_ex;
                                          _costo = _costo + _suma_ex;
                                        }
                                      }
                                    },
                                    value: item['ID_EXTRAS'].toString(),
                                  );
                                }).toList(),
                                onTap: null,
                                onChanged: (newValx) {
                                  setState(() {
                                    if (_counter >= 1) {
                                      _extras1 = newValx;
                                    }
                                  });
                                },
                                validator: (value) =>
                                    value == null ? 'Campo requerido' : null,
                                hint: Text('Seleccionar'),
                                value: _extras1,
                                isExpanded: true,
                              )
                            : DropdownButtonFormField(
                                items: extra.map((item) {}).toList(),
                                onTap: null,
                                validator: (value) =>
                                    value == null ? 'field required' : null,
                                hint: Text('Selecciona un ingrediente'),
                                value: _extras1,
                                isExpanded: true,
                              ),
                        _counter >= 1
                            ? DropdownButtonFormField(
                                items: extra.map((item) {
                                  return new DropdownMenuItem(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          new Text(item['EXT_NOMBRE'] + ' '),
                                          Text('\$' + item['EXT_PRECIO'])
                                        ]),
                                    onTap: () {
                                      var suma_ex2 =
                                          double.parse(item['EXT_PRECIO']);
                                      if (_counter >= 1) {
                                        if (suma_ex2 == 0) {
                                          _suma_ex2 = suma_ex2;
                                          _costo = _costo + _suma_ex2;
                                          print(suma_ex2);
                                        } else if (suma_ex2 != 0) {
                                          _costo = _costo - _suma_ex2;
                                          _suma_ex2 = suma_ex2;
                                          _costo = _costo + _suma_ex2;
                                        }
                                      }
                                    },
                                    value: item['ID_EXTRAS'].toString(),
                                  );
                                }).toList(),
                                onTap: null,
                                onChanged: (newVal) {
                                  setState(() {
                                    if (_counter >= 1) {
                                      _extras2 = newVal;
                                    }
                                  });
                                },
                                validator: (value) =>
                                    value == null ? 'Campo requerido' : null,
                                hint: Text('Seleccionar'),
                                value: _extras2,
                                isExpanded: true,
                              )
                            : DropdownButtonFormField(
                                items: extra.map((item) {}).toList(),
                                onTap: null,
                                validator: (value) =>
                                    value == null ? 'field required' : null,
                                hint: Text('Selecciona un ingrediente'),
                                value: _extras2,
                                isExpanded: true,
                              ),
                      ])
                    : SizedBox()
          ])
        : SizedBox();
    Widget textSection = Column(children: <Widget>[
      new ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: dataneg == null ? 0 : dataneg.length,
          itemBuilder: (BuildContext context, int index) {
            var suma = double.parse(dataneg[index]["MENU_COSTO"]);
            var item = dataneg[index];
            // _costo = suma; por aqui va la validacion
            _suma = suma;

            return Form(
              key: _formKey,
              child: Column(
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
                  // extras, //Checkbox EXTRAS
                  extras2,
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
                                  _costo = _costo - _suma;
                                } else if (_counter == 0) {
                                  _costo = 0;
                                  _suma_ex = 0;
                                  _suma_ex2 = 0;
                                  _extras1 = null;
                                  _extras2 = null;
                                  _extras3 = null;
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
                                print(_costocu);
                              });
                            },
                            child: Text(
                              '+',
                              style: TextStyle(fontSize: 50),
                            )),
                      ],
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.center,

                      children: <Widget>[
                        _counter >= 1
                            ? Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _confirmacion();
                                    }
                                  },
                                  color: Colors.green,
                                  textColor: Colors.white,
                                  child: Text(
                                    'Agregar $_counter al carrito • MXN \$ $_costo',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              )
                            : Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(color: Colors.grey),
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
              ),
            );
          })
    ]);

    return new Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: Color(0xffFF7864),

            //   expandedHeight: 230.0,
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
                /*background: FutureBuilder(
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0),
                            textAlign: TextAlign.center,
                          ));
                        } else {
                          return CachedNetworkImage(
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width,
                            //height: MediaQuery.of(context).size.height * 0.38,
                            height: MediaQuery.of(context).size.height,
                            imageUrl: snapshot.data["MENU_FOTO"],
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          );
                        }
                    }
                  }),*/
                ),
            actions: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Preparing(
                                negocio: Users(idn),
                              )));
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
                    FutureBuilder(
                        future: _countCart(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            default:
                              if (snapshot.hasError) {
                                return Positioned(
                                  height: 20,
                                  width: 20,
                                  right: 1.0,
                                  bottom: 28,
                                  child: new FloatingActionButton(
                                    child: new Text('0',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0,
                                            color: Colors.white)),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } else {
                                return Positioned(
                                  height: 20,
                                  width: 20,
                                  right: 1.0,
                                  bottom: 28,
                                  child: new FloatingActionButton(
                                    child: new Text(snapshot.data["Total"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0,
                                            color: Colors.white)),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                          }
                        }),
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
              textSection,
            ],
          ),
        ],
      ),
    ));
  }
}
