
import 'package:flutter/material.dart';

class Salud extends StatefulWidget {
@override
_Salud createState() => new _Salud();
}

class _Salud extends State<Salud> {
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
    BottomNavigationBarItem(icon: Icon(Icons.star,),title: Text("Hospitales")),
    BottomNavigationBarItem(icon: Icon(Icons.favorite,),title: Text("Consultorios")),
    BottomNavigationBarItem(icon: Icon(Icons.fiber_new,),title: Text("Especialidades")),
    BottomNavigationBarItem(icon: Icon(Icons.visibility,),title: Text("Farmacias")),
    BottomNavigationBarItem(icon: Icon(Icons.favorite,),title: Text("Servicios emergencia")),


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
      title: new Text('Salud'),
    ),
  );
}
}