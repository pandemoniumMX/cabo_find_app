import 'package:cabofind/carousel_pro.dart';
import 'package:cabofind/main_eng.dart';
import 'package:flutter/material.dart';
import 'acercade.dart';
import 'restaurantes.dart';
import 'vida_nocturna.dart';
import 'servicios.dart';
import 'compras.dart';
import 'descubre.dart';

class Menu_esp extends StatefulWidget {
  @override
  _Menu_esp createState() => new _Menu_esp();
}

class _Menu_esp extends State<Menu_esp> {
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Cabo Find");

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(

        centerTitle: true,
        title:appBarTitle,
        actions: <Widget>[
          new IconButton(icon: actionIcon,onPressed:(){
            setState(() {
              if ( this.actionIcon.icon == Icons.search){
                this.actionIcon = new Icon(Icons.close);
                this.appBarTitle = new TextField(
                  style: new TextStyle(
                    color: Colors.white,

                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search,color: Colors.white),
                      hintText: "Buscar...",
                      hintStyle: new TextStyle(color: Colors.white)
                  ),
                );}
              else {
                this.actionIcon = new Icon(Icons.search);
                this.appBarTitle = new Text("CaboFind");
              }


            });
          } ,),
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
    builder: (BuildContext context) => new Vida_nocturna()));
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
    builder: (BuildContext context) => new MyHomePageEnglish()));
    },
    ),
    ],




    ),


    ),
    );
  }
}
