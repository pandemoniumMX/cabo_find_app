import 'package:cabofind/paginas_listas/list_antros.dart';
import 'package:cabofind/paginas/carrusel.dart';
import 'package:flutter/material.dart';







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
      new ListaAntros(),



      //new ImageCarousel2(),

      Center(child: Icon(Icons.map,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.mic,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.radio,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.music_video,size: 60.0,color: Colors.red,),),

    ];

    final bnbi=<BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.star,),title: Text("Bars")),
      BottomNavigationBarItem(icon: Icon(Icons.fiber_new,),title: Text("Clubs")),
      BottomNavigationBarItem(icon: Icon(Icons.visibility,),title: Text("Sportbar")),
      BottomNavigationBarItem(icon: Icon(Icons.favorite,),title: Text("Rockbar")),
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
      title: new Text('Vida nocturna'),
    ),
  );
}
}