
import 'package:flutter/material.dart';

class Compras extends StatefulWidget {
@override
_Compras createState() => new _Compras();
}

class _Compras extends State<Compras> {
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
    BottomNavigationBarItem(icon: Icon(Icons.star,),title: Text("Ropa")),
    BottomNavigationBarItem(icon: Icon(Icons.fiber_new,),title: Text("Regalos")),
    BottomNavigationBarItem(icon: Icon(Icons.visibility,),title: Text("Tiendas")),
    BottomNavigationBarItem(icon: Icon(Icons.favorite,),title: Text("Artesanias")),
    BottomNavigationBarItem(icon: Icon(Icons.bookmark,),title: Text("Farmacias")),


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
      title: new Text('Compras'),
    ),
  );
}
}