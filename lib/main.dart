import 'package:cabofind/carousel_pro.dart';
import 'package:cabofind/main_eng.dart';
import 'package:flutter/material.dart';
import 'acercade.dart';
import 'restaurantes.dart';
import 'vida_nocturna.dart';
import 'servicios.dart';
import 'compras.dart';
import 'descubre.dart';
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

  @override
  Widget build(BuildContext context) {

    return new Scaffold(


      appBar: new AppBar(

        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(icon: actionIcon, onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close);
                this.appBarTitle = new TextField(
                  style: new TextStyle(
                    color: Colors.white,

                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Buscar...",
                      hintStyle: new TextStyle(color: Colors.white)
                  ),
                );
              }
              else {
                this.actionIcon = new Icon(Icons.search);
                this.appBarTitle = new Text("CaboFind");
              }
            });
          },),
        ],


      ),


      drawer: new Drawer(

        child: ListView(
          scrollDirection: Axis.vertical,

          children: <Widget>[

            new UserAccountsDrawerHeader(
              accountName: new Text('No registrado'),
              accountEmail: new Text('tu_correo@.com'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage('http://i.pravatar.cc/300'),

              ),
            ),

            new ListTile(
              title: new Text('Restaurantes'),
              leading: Icon(Icons.restaurant),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Restaurantes()));
              },
            ),
            new ListTile(
              title: new Text('Vida nocturna'),
              leading: Icon(Icons.group),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (
                            BuildContext context) => new Vida_nocturna()));
              },
            ),
            new ListTile(
              title: new Text('Descubre'),
              leading: Icon(Icons.beach_access),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Descubre()));
              },
            ),
            new ListTile(
              title: new Text('De compras'),
              leading: Icon(Icons.shopping_basket),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Compras()));
              },
            ),
            new ListTile(
              title: new Text('Servicios'),
              leading: Icon(Icons.build),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Servicios()));
              },
            ),
            new ListTile(
              title: new Text('Acerca de nosotros'),
              leading: Icon(Icons.record_voice_over),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AboutPage()));
              },
            ),
            new ListTile(
              title: new Text('English'),
              leading: Icon(Icons.flag),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (
                            BuildContext context) => new MyHomePageEnglish()));
              },
            ),
          ],
        ),
      ),

      body: new Container(

        child: ListView(
          scrollDirection: Axis.vertical,

          children: <Widget>[

            new ImageCarousel(),
            new Home(),
            new Publicaciones(),

          ],
        ),




      ),


    );
  }
}

class ImageCarousel extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Center(

      child: Container(

        margin: EdgeInsets.only(bottom: 0.0),
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

class Publicaciones extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Center(

      child: Container(


        margin: EdgeInsets.only(bottom: 0.0),
        padding: EdgeInsets.all(10.0),
        height: 200.0,
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Text(
                      'No te lo puedes perder',
                      textAlign: TextAlign.center,
                      //overflow: TextOverflow.ellipsis,

                      style: TextStyle(

                          color: Color(0XFF000000),
                          fontSize:25.0,
                          fontWeight: FontWeight.bold),
                    )

                ),

              ],
            ),
          ],
        )
        /*
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
*/

    ),

    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: EdgeInsets.only(left: 10.0, bottom: 0.0),
            alignment: Alignment.bottomCenter,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'No te lo puedes perder',
                        textAlign: TextAlign.center,
                        //overflow: TextOverflow.ellipsis,
                        
                        style: TextStyle(

                            color: Color(0XFF000000),
                            fontSize:25.0,
                            fontWeight: FontWeight.bold),
                      )

                    ),

                  ],
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

            new RaisedButton(
              padding: const EdgeInsets.all(8.0),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: null,
              child: new Text("Lo nuevo"),
            ),
              new RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: null,
                child: new Text("Lo más visitado"),
              ),
              new RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: null,
                child: new Text("Recomendado"),
              ),
              new RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: null,
                child: new Text("Promociones"),
              ),
          ],
        )
              ],
            )
        )
    );
  }
}