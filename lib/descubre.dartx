
import 'package:cabofind/listado_test.dart';
import 'package:flutter/material.dart';

class Descubre extends StatefulWidget {
@override
_Descubre createState() => new _Descubre();
}

class _Descubre extends State<Descubre> {
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
    BottomNavigationBarItem(icon: Icon(Icons.star,),title: Text("Actividades")),
    BottomNavigationBarItem(icon: Icon(Icons.favorite,),title: Text("Paseos")),
    BottomNavigationBarItem(icon: Icon(Icons.fiber_new,),title: Text("Cultura")),



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
      title: new Text('Descubre'),
    ),
  );
}
}

class SecondScreenWithData extends StatelessWidget {
  // Declare a field that holds the Person data
  final Person person;

  // In the constructor, require a Person
  SecondScreenWithData({Key key, @required this.person}) : super(
      key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
            "Second Screen With Data"),
      ),
      body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Display passed data from first screen
              new Text(
                  "Person Data  \nname: ${person.name} \nage: ${person.age}"),
              new RaisedButton(
                  child: new Text(
                      "Go Back!"),
                  onPressed: () {
                    // Navigate back to first screen when tapped!
                    Navigator.pop(
                        context);
                  }
              ),
            ],
          )
      ),
    );
  }
}