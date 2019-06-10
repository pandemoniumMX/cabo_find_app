
import 'package:cabofind/list_antros.dart';
import 'package:cabofind/carrusel.dart';
import 'package:cabofind/listado_test.dart';
import 'package:cabofind/slider_backup.dart';
import 'package:flutter/material.dart';




void main() => runApp(new MyAppNocturna());

class MyAppNocturna extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner:false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          accentColor: Colors.black26,
        ),
        home: new Container(
            child:           new Vida_nocturna()
        )



    );
  }
}

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
      new Carrusel(),
      new ListaAntros(),



      //new ImageCarousel2(),

      Center(child: Icon(Icons.map,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.mic,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.radio,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.music_video,size: 60.0,color: Colors.red,),),

    ];

    final bnbi=<BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.star,),title: Text("Bares")),
      BottomNavigationBarItem(icon: Icon(Icons.fiber_new,),title: Text("Antros")),
      BottomNavigationBarItem(icon: Icon(Icons.visibility,),title: Text("Sportbar")),
      BottomNavigationBarItem(icon: Icon(Icons.favorite,),title: Text("Rockbar")),
      BottomNavigationBarItem(icon: Icon(Icons.bookmark,),title: Text("Terraza")),
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