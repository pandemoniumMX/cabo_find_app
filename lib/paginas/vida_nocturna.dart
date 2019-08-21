import 'package:cabofind/paginas_listas/list_vida_antros.dart';
import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/paginas_listas/list_vida_bares.dart';
import 'package:cabofind/paginas_listas/list_vida_rockbar.dart';
import 'package:cabofind/paginas_listas/list_vida_mas.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';





class Vida_nocturna extends StatefulWidget {
@override
_Vida_nocturna createState() => new _Vida_nocturna();
}

class _Vida_nocturna extends State<Vida_nocturna> {
  int id=0;

  @override
Widget build(BuildContext context) {
    final tabpages=<Widget>[
      //llamar classes siempre despues de un <Widget>
      //lo que se declare aqui, sera el contenido de los botones de navigacion al fondo
      // new ImageCarousel2(),
    //  new Carrusel(),
      new ListaAntros(),
      new ListaBares(),
      new Listarockbar(),
      new ListaMas(),


      //new ImageCarousel2(),

      Center(child: Icon(Icons.map,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.mic,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.radio,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.music_video,size: 60.0,color: Colors.red,),),

    ];

    final bnbi=<BottomNavigationBarItem>[

      BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.cocktail,),title: Text("Antros")),
      BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.beer,),title: Text("Bares")),
      BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.guitar,),title: Text("Rockbar")),
      BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.searchPlus,),title: Text("Más")),
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
      title: new Text('Vida nocturna'),
    ),
  );
}
}