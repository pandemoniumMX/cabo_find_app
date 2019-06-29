
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Salud_ing extends StatefulWidget {
@override
_Salud_ing createState() => new _Salud_ing();
}

class _Salud_ing extends State<Salud_ing> {
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
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.hospital,),title: Text("Hospitals")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.clinicMedical,),title: Text("Consultants")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.hospitalSymbol,),title: Text("Specialties")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.pills,),title: Text("Pharmacy")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.ambulance,),title: Text("Emergency")),


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
      title: new Text('Healht'),
    ),
  );
}
}