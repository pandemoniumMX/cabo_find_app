
import 'package:cabofind/paginas_listas/list__anun_autos.dart';
import 'package:cabofind/paginas_listas/list__anun_electronica.dart';
import 'package:cabofind/paginas_listas/list__anun_empleo.dart';
import 'package:cabofind/paginas_listas/list__anun_inmuebles.dart';
import 'package:cabofind/paginas_listas/list_serv_auto.dart';
import 'package:cabofind/paginas_listas/list_serv_bancos.dart';
import 'package:cabofind/paginas_listas/list_serv_mascotas.dart';
import 'package:cabofind/paginas_listas/list_serv_prof.dart';
import 'package:cabofind/paginas_listas/list_serv_prov.dart';
import 'package:cabofind/paginas_listas/list_serv_trans.dart';
import 'package:cabofind/paginas_listas_ing/list__anun_autos.dart';
import 'package:cabofind/paginas_listas_ing/list__anun_electronica.dart';
import 'package:cabofind/paginas_listas_ing/list__anun_empleo.dart';
import 'package:cabofind/paginas_listas_ing/list__anun_inmuebles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Anuncios_ing extends StatefulWidget {
@override
_Servicios createState() => new _Servicios();
}

class _Servicios extends State<Anuncios_ing> {
  int id=0;

  @override
Widget build(BuildContext context) {
  final tabpages=<Widget>[

    new Lista_anun_autos_ing(),
    new Lista_anun_inmueble_ing(),
    new Lista_anun_electronica_ing(),
    new Lista_anun_empleo_ing(),
    


  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.car,),title: Text("Cars")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.sign,),title: Text("Estate")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.laptop,),title: Text("Tecnology")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userCheck,),title: Text("Vacants")),





  ];


  final bnb=BottomNavigationBar(

    items: bnbi,
    currentIndex:id ,
    type: BottomNavigationBarType.fixed,
    onTap: (int value){
      setState(() {
        id=value;
      });
    },
  );

  return new Scaffold(
    body: tabpages[id],
    bottomNavigationBar: bnb,
    appBar: new AppBar(
      title: new Text('Marketplace'),
    ),
  );
}
}