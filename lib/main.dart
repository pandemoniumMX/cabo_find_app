import 'package:cabofind/carousel_pro.dart';
import 'package:cabofind/main_eng.dart';
import 'package:flutter/material.dart';
import 'acercade.dart';
import 'restaurantes.dart';
import 'vida_nocturna.dart';
import 'servicios.dart';
import 'compras.dart';
import 'descubre.dart';
import 'menu_esp.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';





void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();

}


 
class _MyHomePageState extends State<MyHomePage> {
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Cabo Find");

  var body;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
     // body: Home(),




    body: new Stack(
      children: <Widget>[
        new ImageCarousel(),

        new Menu_esp(),
        new Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(10.0),

          child: new Column(
            children: <Widget>[
              new Text("Tuputamadre")

      ],

          ),


        )

      ],
    ),


    );

  }
}



class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
      new Positioned(child: new Container(

          child: Container(
              padding: EdgeInsets.only(left: 10.0, bottom: 600.0),
              alignment: Alignment.bottomCenter,
              color: Colors.deepPurple,
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.blue,
                        height: 50.0,
                        width: 50.0,
                      ),
                      Icon(Icons.adjust, size: 50.0, color: Colors.pink),
                      Icon(Icons.adjust, size: 50.0, color: Colors.purple,),
                      Icon(Icons.adjust, size: 50.0, color: Colors.greenAccent,),
                      Container(
                        color: Colors.orange,
                        height: 50.0,
                        width: 50.0,
                      ),
                      Icon(Icons.adjust, size: 50.0, color: Colors.cyan,),
                    ],
                  )
                ],
              )

    ))
      )

      ],
     );
  }
}


class ImageCarousel extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(

      child: Container(

        margin: EdgeInsets.only(bottom: 600.0),
        padding: EdgeInsets.all(10.0),
        height: 300.0,
        child: Carousel(
          boxFit: BoxFit.cover,
          images: [
            AssetImage('android/assets/images/img1.jpg'),
            AssetImage('android/assets/images/img2.jpg'),
            AssetImage('android/assets/images/img3.jpg'),
            AssetImage('android/assets/images/img4.jpg'),
            AssetImage('android/assets/images/img5.jpg'),

          ],
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 2000),
        ),
      ),
    );
  }
}

