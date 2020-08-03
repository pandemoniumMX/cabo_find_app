import 'dart:convert';
import 'dart:math';

import 'package:cabofind/paginas/menu_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:cabofind/utilidades/estilo.dart';
import 'package:expandable/expandable.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

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
  PageController _c;
  AnimationController _controller;
  Animation<double> _animation;
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode _focusNode;

  bool _isVisibleAsi = true;

  final bool expanded = false;

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

  @override
  void initState() {
    super.initState();
    _c = new PageController(
      initialPage: _page,
    );
    this._loadExp();

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
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Menu_detalle(
                                menu: new Publicacion(idn, idm))));
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
                        FadeInImage(
                          image: NetworkImage(data[index]["MENU_FOTO"]),
                          fit: BoxFit.fill,
                          width: 150,
                          height: 150,

                          // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                          placeholder:
                              AssetImage('android/assets/images/loading.gif'),
                          fadeInDuration: Duration(milliseconds: 200),
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
                              Text(
                                '\$' + data[index]["MENU_COSTO"],
                                overflow: TextOverflow.ellipsis,
                              ),
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

    return Scaffold(
        appBar: AppBar(
          title: Text('Regresar'),
          backgroundColor: Color(0xffFF7864),
        ),
        body: ListView(
          children: [
            FadeInImage(
              image: NetworkImage(exp[0]['GAL_FOTO']), //portada
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: 250,
              // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
              placeholder: AssetImage('android/assets/images/loading.gif'),
              fadeInDuration: Duration(milliseconds: 200),
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
        ));
  }

  cb(ExpandableController controller) async {
    await Future.delayed(Duration(seconds: 2));
    controller.toggle();
  }
}
