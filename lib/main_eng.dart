import 'package:cabofind/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'acercade.dart';
import 'restaurantes.dart';
import 'vida_nocturna.dart';
import 'servicios.dart';
import 'compras.dart';
import 'descubre.dart';
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

      body: ImageCarousel(),

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
                        builder: (BuildContext context) => new Restaurantes()));
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
                            BuildContext context) => new Vida_nocturna()));
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
                        builder: (BuildContext context) => new Descubre()));
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
                        builder: (BuildContext context) => new Compras()));
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
                        builder: (BuildContext context) => new Servicios()));
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
                        builder: (BuildContext context) => new AboutPage()));
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
