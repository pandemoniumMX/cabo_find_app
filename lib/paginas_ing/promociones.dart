
import 'package:cabofind/paginas_listas/list__anun_autos.dart';
import 'package:cabofind/paginas_listas/list__anun_electronica.dart';
import 'package:cabofind/paginas_listas/list__anun_empleo.dart';
import 'package:cabofind/paginas_listas/list__anun_inmuebles.dart';
import 'package:cabofind/paginas_listas/list_promociones_actividades.dart';
import 'package:cabofind/paginas_listas/list_promociones_bares.dart';
import 'package:cabofind/paginas_listas/list_promociones_compras.dart';
import 'package:cabofind/paginas_listas/list_promociones_restaurantes.dart';
import 'package:cabofind/paginas_listas/list_promociones_salud.dart';
import 'package:cabofind/paginas_listas/list_promociones_servicios.dart';
import 'package:cabofind/paginas_listas/list_serv_auto.dart';
import 'package:cabofind/paginas_listas/list_serv_bancos.dart';
import 'package:cabofind/paginas_listas/list_serv_mascotas.dart';
import 'package:cabofind/paginas_listas/list_serv_prof.dart';
import 'package:cabofind/paginas_listas/list_serv_prov.dart';
import 'package:cabofind/paginas_listas/list_serv_trans.dart';
import 'package:cabofind/paginas_listas_ing/list_promociones_actividades.dart';
import 'package:cabofind/paginas_listas_ing/list_promociones_bares.dart';
import 'package:cabofind/paginas_listas_ing/list_promociones_compras.dart';
import 'package:cabofind/paginas_listas_ing/list_promociones_restaurantes.dart';
import 'package:cabofind/paginas_listas_ing/list_promociones_salud.dart';
import 'package:cabofind/paginas_listas_ing/list_promociones_servicios.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Promociones_grid_ing extends StatefulWidget {
@override
_Servicios createState() => new _Servicios();
}

class _Servicios extends State<Promociones_grid_ing> {
  int id=0;

  @override
Widget build(BuildContext context) {
  final tabpages=<Widget>[

    new Promociones_restaurantes_ing(),
    new Promociones_bares_ing(),
    new Promociones_actividades_ing(),
    new Promociones_compras_ing(),
    new Promociones_salud_ing(),
    new Promociones_servicios_ing(),

    


  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.utensils,),title: Text("Restaurants")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.beer,),title: Text("Bars")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.bicycle,),title: Text("Activities")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.tshirt,),title: Text("Fashion")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.heartbeat,),title: Text("Wellness")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userTie,),title: Text("Services")),







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
    
  );
}
}