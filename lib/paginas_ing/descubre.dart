
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Descubre_ing extends StatefulWidget {
@override
_Descubre_ing createState() => new _Descubre_ing();
}

class _Descubre_ing extends State<Descubre_ing> {
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
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.swimmer,),title: Text("Water")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.bicycle,),title: Text("Land")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.telegramPlane,),title: Text("Air")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.theaterMasks,),title: Text("Events")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.bookmark,),title: Text("Culture")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.umbrellaBeach,),title: Text("Beaches")),



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
      title: new Text('Actividades'),
    ),
  );
}
}