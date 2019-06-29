
import 'package:cabofind/paginas_listas_ing/list__com_joyerias.dart';
import 'package:cabofind/paginas_listas_ing/list__com_moda.dart';
import 'package:cabofind/paginas_listas_ing/list__com_regalos.dart';
import 'package:cabofind/paginas_listas_ing/list__com_tiendas.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Compras_ing extends StatefulWidget {
@override
_Compras_ing createState() => new _Compras_ing();
}

class _Compras_ing extends State<Compras_ing> {
  int id=0;

  @override
Widget build(BuildContext context) {
  final tabpages=<Widget>[
    //llamar classes siempre despues de un <Widget>
    //lo que se declare aqui, sera el contenido de los botones de navigacion al fondo
    new ListaModa_ing(),
    new ListaRegalos_ing(),
    new ListaJoyerias_ing(),
    new ListaTiendas_ing(),



  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.tshirt,),title: Text("Fashion")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.gift,),title: Text("Souvenirs")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.gem,),title: Text("Jewelry")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.store,),title: Text("Stores")),


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
      title: new Text('Shopping'),
    ),
  );
}
}