import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/preparing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cabofind/utilidades/clasesilver.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'domicilio.dart';
import 'list_manejador_menus.dart';

class Menu_detalle extends StatefulWidget {
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
  double _suma;
  double _suma_ex = 0;
  double _suma_ex2 = 0;
  double _suma_ex3 = 0;
  double total = 0;

  var factorial = 0;
  var userStatus = List<bool>();
  var _multiple = List<String>();

  String encodeData;
  String idn = '';

  List customers = [];

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

  Future<String> _insertPedidoSingle(
      int cantidad,
      double costo,
      String nota,
      String extra1,
      String extra2,
      String extra3,
      double costoex1,
      double costoex2) async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insert_carrito_single.php?ID=${widget.menu.id_n}&MENU=${widget.menu.id_p}&IDF=$_mail2&CANTIDAD=${cantidad}&COSTO=${costo}&NOTA=${nota}&EXTRA1=${extra1}&EXTRA2=${extra2}&EXTRA1COSTO=${costoex1}&EXTRA2COSTO=${costoex2}&EXTRA3=${extra3}"),
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
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    _status = login.getString("stringLogin") ?? '';
    _mail = login.getString("stringMail") ?? '';
    String _id = "";

    _id = login.getString("stringID");
    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/list_count_cart.php?ID=${widget.menu.id_n}&IDF=$_id");
    return json.decode(response.body);
  }

  void initState() {
    // setState(() {});
    super.initState();
    this.getExtras();

    this.getInfo();

    /*StripeNative.setPublishableKey(
        "pk_test_qRcqwUowOCDhl2bEuXPPCKDw00LMVoJpLi");
    StripeNative.setMerchantIdentifier("4525-9725-4152");*/
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
      if (_counter > 1) {
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
          var sumax = double.parse(dataneg[0]["MENU_COSTO"]);
          // String idnx = dataneg[index]["ID_NEGOCIO"];
          //

          if (_counter >= 1) {
            _costocu = sumax;
            total = _costo + _costocu;
            print(total);
            print(_costo);
            print(_costocu);
            print(_counter);
          } else if (total == 0) {
            total = _costo + 0;
          }

          idn = widget.menu.id_n;

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

    void _confirmacion() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Alerta"),
            content: new Text(
              "¿Seguro que desea hacer?",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new FlatButton(
                    child: new Text("Cancelar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child: new Text(
                      "Agregar al carrito",
                      style: TextStyle(color: Color(0xff60032D)),
                    ),
                    onPressed: () {
                      String notax = controller.text;
                      _insertPedidoSingle(_counter, total, notax, _extras1,
                          _extras2, _extras3, _suma_ex, _suma_ex2);

                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new Menu_manejador(
                                        manejador: new Users(idn))));
                      });

                      /*   Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  Menu_manejador(manejador: new Users(idn))),
                          (Route<dynamic> route) => false);*/
                    },
                  ),
                  new FlatButton(
                    child: new Text("Pagar",
                        style: TextStyle(color: Color(0xff60032D))),
                    onPressed: () {
                      String notax = controller.text;
                      _insertPedidoSingle(_counter, total, notax, _extras1,
                          _extras2, _extras3, _suma_ex, _suma_ex2);

                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  new Preparing(negocio: new Users(idn))),
                        ).then((value) => setState(() {}));
                        /* Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new Preparing(negocio: new Users(idn))
                                    ));*/
                      });
                      /*Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  Preparing(negocio: new Users(idn))),
                          (Route<dynamic> route) => false);*/
                    },
                  ),
                ],
              )
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
                    : dataneg[0]["MENU_REQUIERE"] == '3'
                        ? Column(children: <Widget>[
                            _counter >= 1
                                ? DropdownButtonFormField(
                                    items: extra.map((item) {
                                      return new DropdownMenuItem(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              new Text(
                                                  item['EXT_NOMBRE'] + ' '),
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
                                    validator: (value) => value == null
                                        ? 'Campo requerido'
                                        : null,
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
                                              new Text(
                                                  item['EXT_NOMBRE'] + ' '),
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
                                    validator: (value) => value == null
                                        ? 'Campo requerido'
                                        : null,
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
                            _counter >= 1
                                ? DropdownButtonFormField(
                                    items: extra.map((item) {
                                      return new DropdownMenuItem(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              new Text(
                                                  item['EXT_NOMBRE'] + ' '),
                                              Text('\$' + item['EXT_PRECIO'])
                                            ]),
                                        onTap: () {
                                          var suma_ex3 =
                                              double.parse(item['EXT_PRECIO']);
                                          if (_counter >= 1) {
                                            if (suma_ex3 == 0) {
                                              _suma_ex3 = suma_ex3;
                                              _costo = _costo + _suma_ex3;
                                              print(suma_ex3);
                                            } else if (suma_ex3 != 0) {
                                              _costo = _costo - _suma_ex3;
                                              _suma_ex3 = suma_ex3;
                                              _costo = _costo + _suma_ex3;
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
                                          _extras3 = newVal;
                                        }
                                      });
                                    },
                                    validator: (value) => value == null
                                        ? 'Campo requerido'
                                        : null,
                                    hint: Text('Seleccionar'),
                                    value: _extras3,
                                    isExpanded: true,
                                  )
                                : DropdownButtonFormField(
                                    items: extra.map((item) {}).toList(),
                                    onTap: null,
                                    validator: (value) =>
                                        value == null ? 'field required' : null,
                                    hint: Text('Selecciona un ingrediente'),
                                    value: _extras3,
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
                              if (_counter > 1) {
                                _decrementCounter();
                                _costo = _costo - _suma;
                              }
                              setState(() {
                                /*else if (_counter == 0) {
                                  _costocu = 0;
                                  total = 0;
                                  _costo = 0;
                                  _suma_ex = 0;
                                  _suma_ex2 = 0;
                                  _extras1 = null;
                                  _extras2 = null;
                                  _extras3 = null;
                                  print('COSTO RESTADO' + _costo.toString());
                                }*/
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
                                // _suma = _costocu;
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
                                  color: Color(0xff192227),
                                  textColor: Colors.white,
                                  child: Text(
                                    'Agregar $_counter al carrito • MXN \$ $total',
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
                                    'Agregar $_counter al carrito • MXN \$ $total',
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

    return WillPopScope(
      onWillPop: () async => true,
      child: new Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Color(0xff60032D),

              floating: false,
              pinned: true,
              title: SABT(
                  child: Text(
                'Regresar',
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
                new Stack(
                  children: [
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
                                    backgroundColor: Color(0xff192227),
                                  ),
                                );
                              } else if (snapshot.data["Total"] == '0') {
                                return Stack(
                                  children: [
                                    Center(
                                      child: new Row(children: <Widget>[
                                        new Icon(FontAwesomeIcons.shoppingCart),
                                        Text(
                                          "  ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0),
                                        ),
                                      ]),
                                    ),
                                    Positioned(
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
                                        backgroundColor: Color(0xff192227),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return InkWell(
                                  onTap: () {
                                    //recargar estado
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => new Preparing(
                                                negocio: new Users(idn))),
                                      ).then((value) => setState(() {}));
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: new Row(children: <Widget>[
                                          new Icon(
                                              FontAwesomeIcons.shoppingCart),
                                          Text(
                                            "  ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.0),
                                          ),
                                        ]),
                                      ),
                                      Positioned(
                                        height: 20,
                                        width: 20,
                                        right: 1.0,
                                        bottom: 28,
                                        child: new FloatingActionButton(
                                          child: new Text(
                                              snapshot.data["Total"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10.0,
                                                  color: Colors.white)),
                                          backgroundColor: Color(0xff192227),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          }
                        }),
                  ],
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
      )),
    );
  }
}
