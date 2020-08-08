import 'dart:convert';
import 'dart:math';

import 'package:cabofind/paginas/domicilio.dart';
import 'package:cabofind/paginas/menu_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:cabofind/utilidades/estilo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'login3.dart';
import 'preparing.dart';

class Menu_manejador extends StatefulWidget {
  final Users manejador;

  Menu_manejador({Key key, @required this.manejador}) : super(key: key);
  @override
  _Menu_majeadorState createState() => _Menu_majeadorState();
}

class _Menu_majeadorState extends State<Menu_manejador>
    with TickerProviderStateMixin {
  List data;
  List exp;
  int _page = 0;
  int selectedIndex = 0;
  String _mail2 = "";
  PageController _c;
  AnimationController _controller;
  Animation<double> _animation;
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode _focusNode;

  bool _isVisibleAsi = true;

  final bool expanded = false;
  Future<String> _logcheck() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    setState(() {
      _mail2 = login.getString("stringID");
    });

    return "Success!";
  }

  Future<Map> _loadMenu(String idn, idm) async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_menu_comidas.php?ID=${idn}&MENU=${idm}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });
  }

  Future<Map> _loadExp() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_menu_comidas_exp.php?ID=${widget.manejador.correo}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      exp = json.decode(response.body);
    });
  }

  Future<Map> _countCart() async {
    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/list_count_cart.php?ID=${widget.manejador.correo}&IDF=$_mail2");
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    _c = new PageController(
      initialPage: _page,
    );
    this._loadExp();
    this._logcheck();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this, value: 0.1);
    _animation = CurvedAnimation(
        parent: _controller,
        // reverseCurve: Curves.bounceInOut,
        curve: Curves.bounceInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  cleanTexto() {
    String controlador = controller.text;

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    Widget expandir = SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: _controller,
      child: Offstage(
          offstage: _isVisibleAsi,
          child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              String controlador = controller.text;
              return Card(
                elevation: 2.0,
                child: InkWell(
                  onTap: () {
                    String idn = data[index]["negocios_ID_NEGOCIO"];
                    String idm = data[index]["ID_MENU"];
                    print(
                        '***************************************************' +
                            idm);
                    print(_mail2);
                    _mail2 != null
                        ? Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new Menu_detalle(
                                    menu: new Publicacion(idn, idm))))
                        : Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new Login_esp()));
                  },
                  child: new Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey)),
                    padding: EdgeInsets.all(5.0),
                    //  margin: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CachedNetworkImage(
                          fit: BoxFit.fill,
                          width: 150,
                          height: 150,
                          imageUrl: (data[index]["MENU_FOTO"]),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                                  child: Container(
                            width: 150,
                            height: 150,
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          )),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                data[index]["MENU_NOMBRE"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(data[index]["MENU_SUBTITULO"],
                                  overflow: TextOverflow.ellipsis, maxLines: 5),
                              Container(
                                  child: Text(
                                'MXN: \$' + data[index]["MENU_COSTO"],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ))
                              /*   Text(
                                '\$' + data[index]["MENU_COSTO"],
                                overflow: TextOverflow.ellipsis,
                              ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );

    return WillPopScope(
      onWillPop: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new Domicilio()));
      },
      child: Scaffold(
          appBar: AppBar(
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Domicilio()),
                    (Route<dynamic> route) => false)
                /*    Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new Domicilio())),*/
                ),
            title: Text('Regresar'),
            backgroundColor: Color(0xff3E252B),
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
                                  backgroundColor: Colors.green,
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
                                      backgroundColor: Colors.green,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new Preparing(
                                                negocio: Users(
                                                    widget.manejador.correo),
                                              )));
                                },
                                child: Stack(
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
                                        child: new Text(snapshot.data["Total"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10.0,
                                                color: Colors.white)),
                                        backgroundColor: Colors.green,
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
          ),
          body: ListView(
            children: [
              CachedNetworkImage(
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: 250,
                imageUrl: (exp[0]['GAL_FOTO']),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    crossAxisCount: 2,
                    //childAspectRatio: MediaQuery.of(context).size.height / 300
                    childAspectRatio: 2.5
                    //  (MediaQuery.of(context).size.height / 1.5)
                    ),
                itemCount: exp == null ? 0 : exp.length,
                itemBuilder: (BuildContext context, int index) {
                  String idn = exp[index]["negocios_ID_NEGOCIO"];

                  String idm = exp[index]["ID_SUB_MEN"];

                  return Container(
                    margin: EdgeInsets.all(3.0),
                    padding: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    child: InkWell(
                      onTap: () {
                        cleanTexto();
                        _loadMenu(idn, idm);
                        _isVisibleAsi = !true;

                        print(idn);
                        _controller.isCompleted
                            ? _controller.reverse()
                            : _controller.forward();

                        /*  _controller.isDismissed
                      ? _controller.reverse()
                      : _controller.forward();*/

                        // (String idn) => showToast(idn);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              exp[index]["SUB_MEN_NOMBRE"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                              softWrap: true,
                            ),
                          ),
                          /* Text(
                            '12 PIEZAS',
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black54),
                            softWrap: true,
                          ),*/
                          //  Divider()
                        ],
                      ),
                    ),
                  );
                },
              ),
              expandir
            ],
          )),
    );
  }

  cb(ExpandableController controller) async {
    await Future.delayed(Duration(seconds: 2));
    controller.toggle();
  }
}
