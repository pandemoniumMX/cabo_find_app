import 'package:cabofind/paginas_listas/list__vida_antros.dart';
import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/paginas_listas_ing/list__vida_bares.dart';
import 'package:cabofind/paginas_listas_ing/list_vida_antros.dart';
import 'package:cabofind/paginas_listas_ing/list_vida_rockbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




class Vida_nocturna_ing extends StatefulWidget {
@override
_Vida_nocturna_ing createState() => new _Vida_nocturna_ing();
}

class _Vida_nocturna_ing extends State<Vida_nocturna_ing> {
  int id=0;

  @override
Widget build(BuildContext context) {
    final tabpages=<Widget>[
      //llamar classes siempre despues de un <Widget>
      //lo que se declare aqui, sera el contenido de los botones de navigacion al fondo
      // new ImageCarousel2(),
    //  new Carrusel(),
      new ListaAntros_ing(),
      new ListaBares_ing(),
      new Listarockbar_ing(),



      //new ImageCarousel2(),

      Center(child: Icon(Icons.map,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.mic,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.radio,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.music_video,size: 60.0,color: Colors.red,),),

    ];

    final bnbi=<BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.cocktail,),title: Text("Clubs")),
      BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.beer,),title: Text("Bars")),
      BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.guitar,),title: Text("Rockbar")),
      BottomNavigationBarItem(icon: Icon(Icons.bookmark,),title: Text("Terrace")),
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
      title: new Text('Nightlife'),
    ),
  );
}
}