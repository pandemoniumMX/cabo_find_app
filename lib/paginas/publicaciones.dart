
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
import 'package:cabofind/paginas_listas/list_publicaciones_actividades%20.dart';
import 'package:cabofind/paginas_listas/list_publicaciones_bares.dart';
import 'package:cabofind/paginas_listas/list_publicaciones_compras.dart';
import 'package:cabofind/paginas_listas/list_publicaciones_educacion.dart';
import 'package:cabofind/paginas_listas/list_publicaciones_restaurantes.dart';
import 'package:cabofind/paginas_listas/list_publicaciones_servicios.dart';
import 'package:cabofind/paginas_listas/list_serv_auto.dart';
import 'package:cabofind/paginas_listas/list_serv_bancos.dart';
import 'package:cabofind/paginas_listas/list_serv_mascotas.dart';
import 'package:cabofind/paginas_listas/list_serv_prof.dart';
import 'package:cabofind/paginas_listas/list_serv_prov.dart';
import 'package:cabofind/paginas_listas/list_serv_trans.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Publicaciones_grid extends StatefulWidget {
@override
_Servicios createState() => new _Servicios();
}

class _Servicios extends State<Publicaciones_grid> {
  int id=0;

  @override
Widget build(BuildContext context) {
  final tabpages=<Widget>[

    new Publicaciones_restaurantes(),
    new Publicaciones_bares(),
    new Publicaciones_actividades(),
    new Publicaciones_compras(),
    new Promociones_salud(),
    new Publicaciones_servicios(),
    new Publicaciones_educacion(),


    


  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.utensils,),title: Text("Restaurantes")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.beer,),title: Text("Bares")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.bicycle,),title: Text("Actividades")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.tshirt,),title: Text("Moda")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.heartbeat,),title: Text("Bienestar")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userTie,),title: Text("Servicios")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.graduationCap,),title: Text("Educación")),








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