
import 'package:flutter/material.dart';

class Restaurantes_ing extends StatefulWidget {
  int id=0;

  @override
_Restaurantes_ing createState() => new _Restaurantes_ing();
}

class _Restaurantes_ing extends State<Restaurantes_ing> {
@override
Widget build(BuildContext context) {
  final tabpages=<Widget>[
    //llamar classes siempre despues de un <Widget>
    //lo que se declare aqui, sera el contenido de los botones de navigacion al fondo
    // new ImageCarousel2(),
    //new ImageCarousel2(),

    //new Listviewx(),
    //new ImageCarousel2(),

    Center(child: Icon(Icons.map,size: 60.0,color: Colors.red,),),
    Center(child: Icon(Icons.mic,size: 60.0,color: Colors.red,),),
    Center(child: Icon(Icons.radio,size: 60.0,color: Colors.red,),),
    Center(child: Icon(Icons.music_video,size: 60.0,color: Colors.red,),),

  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.star,),title: Text("Mexicans")),
    BottomNavigationBarItem(icon: Icon(Icons.fiber_new,),title: Text("Italians")),
    BottomNavigationBarItem(icon: Icon(Icons.visibility,),title: Text("Chinese")),
    BottomNavigationBarItem(icon: Icon(Icons.favorite,),title: Text("Japaneses")),
    BottomNavigationBarItem(icon: Icon(Icons.bookmark,),title: Text("Tacos")),
    BottomNavigationBarItem(icon: Icon(Icons.bookmark,),title: Text("Coffe shops")),
    BottomNavigationBarItem(icon: Icon(Icons.bookmark,),title: Text("Snacks")),


  ];

  int id=0;

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
title: new Text('Restaurantes'),
),
);
}
}
