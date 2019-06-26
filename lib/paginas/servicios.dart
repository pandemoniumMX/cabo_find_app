
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Servicios extends StatefulWidget {
@override
_Servicios createState() => new _Servicios();
}

class _Servicios extends State<Servicios> {
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
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.car,),title: Text("Automotriz")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.piggyBank,),title: Text("Bancos")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userTie,),title: Text("Asesoría")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userCog,),title: Text("Técnicos")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.taxi,),title: Text("Transporte")),


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
      title: new Text('Servicios'),
    ),
  );
}
}