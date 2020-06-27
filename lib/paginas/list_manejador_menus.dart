import 'dart:convert';

import 'package:cabofind/utilidades/classes.dart';
import 'package:cabofind/utilidades/estilo.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class Menu_manejador extends StatefulWidget {
  final Users manejador;

  Menu_manejador({Key key, @required this.manejador}) : super(key: key);
  @override
  _Menu_majeadorState createState() => _Menu_majeadorState();
}

class _Menu_majeadorState extends State<Menu_manejador> {
  List data;
  List exp;
  ExpandableController controller1;
  ExpandableController controller2;
  ExpandableController controller3;
  ExpandableController controller4;
  ExpandableController controller5;

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
            "http://cabofind.com.mx/app_php/APIs/esp/list_menu_comidas_exp.php?ID=37"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      exp = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    //this._loadMenu('','');
    this._loadExp();

    controller1 = new ExpandableController(initialExpanded: expanded);
    //_controller.addListener(_onToggle);

    /*_controller.addListener((){
      if(_controller.value)_controller.value=true;
    });
    _controller.addListener((){
      if(_controller.value)_controller.value=true;
    });*/
  }

  @override
  void dispose() {
    //  controller1.dispose();
    super.dispose();
  }

  _onToggle() {
    print("Is expanded: ${controller1.expanded}");
  }

  void showToast(idm) {
    setState(() {
      // print(idm);
      if (idm == '37') {
        _isVisibleAsi = !true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget expandir = Offstage(
        offstage: _isVisibleAsi,
        child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 2.0,
              child: new Container(
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.grey)),
                padding: EdgeInsets.all(20.0),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FadeInImage(
                      image: NetworkImage(data[index]["GAL_FOTO"]),
                      fit: BoxFit.fill,
                      width: 50,
                      height: 50,

                      // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                      placeholder:
                          AssetImage('android/assets/images/loading.gif'),
                      fadeInDuration: Duration(milliseconds: 200),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          data[index]["MENU_NOMBRE"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Flexible(
                          child: Text(data[index]["MENU_DESC"],
                              overflow: TextOverflow.ellipsis, softWrap: true),
                        ),
                        Text(
                          '\$' + data[index]["MENU_COSTO"],
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        new Icon(FontAwesomeIcons.minusCircle),
                        Text(
                          '0',
                          style: TextStyle(fontSize: 20),
                        ),
                        new Icon(FontAwesomeIcons.plusCircle),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ));

    return Scaffold(
        body: Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: exp == null ? 0 : exp.length,
          itemBuilder: (BuildContext context, int index) {
            String idn = exp[index]["negocios_ID_NEGOCIO"];

            String idm = exp[index]["ID_SUB_MEN"];

            return InkWell(
              onTap: () {
                _loadMenu(idn, idm);

                print(idn);
                _isVisibleAsi = !true;
                // (String idn) => showToast(idn);
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        exp[index]["SUB_MEN_NOMBRE"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                        softWrap: true,
                      ),
                      FadeInImage(
                        image: NetworkImage(exp[0]["GAL_FOTO"]),
                        fit: BoxFit.fill,
                        width: 50,
                        height: 50,
                        placeholder:
                            AssetImage('android/assets/images/loading.gif'),
                        fadeInDuration: Duration(milliseconds: 200),
                      ),
                    ],
                  ),
                  Divider()
                ],
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
