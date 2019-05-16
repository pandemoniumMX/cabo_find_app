import 'package:cabofind/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'acercade.dart';
import 'restaurantes.dart';
import 'vida_nocturna.dart';
import 'servicios.dart';
import 'compras.dart';
import 'descubre.dart';
import 'acercade_eng.dart';
import 'restaurantes_eng.dart';
import 'vida_nocturna_eng.dart';
import 'servicios_eng.dart';
import 'compras_eng.dart';
import 'descubre_eng.dart';
import 'main.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';






class MyHomePageEnglish extends StatefulWidget {
  @override
  _MyHomePageEnglish createState() => new _MyHomePageEnglish();

}



class _MyHomePageEnglish extends State<MyHomePageEnglish> {
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Cabo Find");
  @override



  Widget build(BuildContext context) {
    return new Scaffold(

      body: Home(),

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
                      hintText: "Search...",
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
              accountName: new Text('No registred'),
              accountEmail: new Text('your_mail@.com'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage('http://i.pravatar.cc/300'),

              ),
            ),

            new ListTile(
              title: new Text('Restaurants'),
              leading: Icon(Icons.restaurant),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Restaurantes_eng()));
              },
            ),
            new ListTile(
              title: new Text('Night life'),
              leading: Icon(Icons.group),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (
                            BuildContext context) => new Vida_nocturna_eng()));
              },
            ),
            new ListTile(
              title: new Text('Discover'),
              leading: Icon(Icons.beach_access),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Descubre_eng()));
              },
            ),
            new ListTile(
              title: new Text('Shopping'),
              leading: Icon(Icons.shopping_basket),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Compras_eng()));
              },
            ),
            new ListTile(
              title: new Text('Services'),
              leading: Icon(Icons.build),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Servicios_eng()));
              },
            ),
            new ListTile(
              title: new Text('About us'),
              leading: Icon(Icons.record_voice_over),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AboutPage_eng()));
              },
            ),
            new ListTile(
              title: new Text('Español'),
              leading: Icon(Icons.flag),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new MyApp()));
              },
            ),
          ],
        ),
      ),

    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
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
            )));
  }
}

