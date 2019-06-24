import 'dart:convert';
import 'package:cabofind/paginas/salud.dart';
import 'package:cabofind/paginas/youtube.dart';
import 'package:cabofind/paginas_ing/acercade_ing.dart';
import 'package:cabofind/paginas_ing/compras_ing.dart';
import 'package:cabofind/paginas_ing/descubre_ing.dart';
import 'package:cabofind/paginas_ing/restaurantes_ing.dart';
import 'package:cabofind/paginas_ing/salud_ing.dart';
import 'package:cabofind/paginas_ing/servicios_ing.dart';
import 'package:cabofind/paginas_ing/vida_nocturna_ing.dart';
import 'package:cabofind/utilidades/buscador.dart';
import 'package:cabofind/utilidades/carousel_pro.dart';
import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/main.dart';
import 'package:cabofind/paginas_listas/list_publicaciones.dart';
import 'package:flutter/material.dart';
import 'package:cabofind/paginas/acercade.dart';
import 'package:cabofind/paginas/restaurantes.dart';
import 'package:cabofind/paginas/vida_nocturna.dart';
import 'package:cabofind/paginas/servicios.dart';
import 'package:cabofind/paginas/compras.dart';






class MyHomePage_ING extends StatefulWidget {
  @override
  _MyHomePage_ING createState() => new _MyHomePage_ING();
  

}


Widget slider = Container(
    child: Stack(

      children: <Widget>[

        Container(

          margin: EdgeInsets.only(
              top: 0.0),
          padding: EdgeInsets.all(
              10.10),
          height: 250.0,
          child: Carousel(
            boxFit: BoxFit.cover,
            images: [

              AssetImage(
                  'android/assets/images/img1.jpg'),
              AssetImage(
                  'android/assets/images/img2.jpg'),
              AssetImage(
                  'android/assets/images/img3.jpg'),
              AssetImage(
                  'android/assets/images/img4.jpg'),
              AssetImage(
                  'android/assets/images/img5.jpg'),
             
            ],
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(
                milliseconds: 2000),
          ),
        ),

      ],
    )
);



class _MyHomePage_ING extends State<MyHomePage_ING> {
  Icon idioma_ing = new Icon(Icons.flag);
  Icon actionIcon = new Icon(Icons.search);

  Widget appBarTitle = new Text("Cabofind");
  int id=0;

  @override

  dispose();

  Widget build(BuildContext context) {
   // new Publicaciones();

    final tabpages=<Widget>[
      //llamar classes siempre despues de un <Widget>
      //lo que se declare aqui, sera el contenido de los botones de navigacion al fondo
     // new ImageCarousel2(),
      //new ImageCarousel2(),
      new Publicaciones(),
      new Carrusel(),
      new Youtube(),

      //new ImageCarousel2(),

      Center(child: Icon(Icons.map,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.mic,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.radio,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.music_video,size: 60.0,color: Colors.red,),),

    ];

    final bnbi=<BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.fiber_new,),title: Text("New")),
      BottomNavigationBarItem(icon: Icon(Icons.star,),title: Text("Oferts")),
      BottomNavigationBarItem(icon: Icon(Icons.visibility,),title: Text("Most view")),
      BottomNavigationBarItem(icon: Icon(Icons.favorite,),title: Text("Recomended")),
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



    return  Scaffold(

      body: tabpages[id],
      bottomNavigationBar: bnb,


      appBar: new AppBar(

        centerTitle: true,
        title:appBarTitle,
        actions: <Widget>[


          new IconButton(
            icon: idioma_ing,
            onPressed: () {
              //Use`Navigator` widget to push the second screen to out stack of screens
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new MyHomePages()));
            }, ),

          new IconButton(
            icon: actionIcon,
              onPressed: () {
                //Use`Navigator` widget to push the second screen to out stack of screens
                Navigator.of(context)
                    .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new Buscador();
                }));
              }, ),

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
              title: new Text('Restaurants'),
              leading: Icon(Icons.restaurant),
              

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Restaurantes_ing()));
              },

            ),
            new ListTile(
              title: new Text('Night club'),
              leading: Icon(Icons.group),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Vida_nocturna_ing()));
              },
            ),
            new ListTile(
              title: new Text('Explore'),
              leading: Icon(Icons.beach_access),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Descubre_ing()));
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
                        builder: (BuildContext context) => new Compras_ing()));
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
                        builder: (BuildContext context) => new Servicios_ing()));
              },
            ),
            new ListTile(
              title: new Text('Health'),
              leading: Icon(Icons.healing),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Salud_ing()));
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
                        builder: (BuildContext context) => new Acercade_ing()));
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
                        builder: (BuildContext context) => new MyHomePages()));
              },
            ),
          ],
        ),
      ),

        );
  }
}



