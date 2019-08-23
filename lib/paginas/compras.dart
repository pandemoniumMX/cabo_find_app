
import 'package:cabofind/paginas_listas/list__com_joyerias.dart';
import 'package:cabofind/paginas_listas/list__com_moda.dart';
import 'package:cabofind/paginas_listas/list__com_regalos.dart';
import 'package:cabofind/paginas_listas/list__com_tiendas.dart';
import 'package:cabofind/paginas_listas/list_serv_prov.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Compras extends StatefulWidget {
@override
_Compras createState() => new _Compras();
}

class _Compras extends State<Compras> {
  int id=0;
@override
Widget build(BuildContext context) {
  final tabpages=<Widget>[
    new ListaModa(),
    new ListaRegalos(),
    new ListaJoyerias(),
    new ListaTiendas(),
    new ListaProveedores(),

  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.tshirt,),title: Text("Moda")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.gift,),title: Text("Regalos")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.gem,),title: Text("Joyería")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.store,),title: Text("Tiendas")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.boxOpen,),title: Text("Proveedores")),


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
      title: new Text('Compras'),
    ),
  );
}
}