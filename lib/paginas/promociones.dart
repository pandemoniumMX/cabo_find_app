
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
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Promociones_grid extends StatefulWidget {
@override
_Servicios createState() => new _Servicios();
}

class _Servicios extends State<Promociones_grid> {
  int id=0;

  @override
Widget build(BuildContext context) {
  final tabpages=<Widget>[

    new Promociones_restaurantes(),
    new Promociones_bares(),
    new Promociones_actividades(),
    new Promociones_compras(),
    new Promociones_salud(),
    new Promociones_servicios(),

    


  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.utensils,),title: Text("Restaurantes")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.beer,),title: Text("Bares")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.bicycle,),title: Text("Actividades")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.tshirt,),title: Text("Moda")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.heartbeat,),title: Text("Bienestar")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userTie,),title: Text("Servicios")),







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