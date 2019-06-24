import 'dart:convert';
import 'package:cabofind/paginas/salud.dart';
import 'package:cabofind/paginas/youtube.dart';
import 'package:cabofind/utilidades/buscador.dart';
import 'package:cabofind/utilidades/carousel_pro.dart';
import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/main_eng.dart';
import 'package:cabofind/paginas_listas/list_publicaciones.dart';
import 'package:flutter/material.dart';
import 'package:cabofind/paginas/acercade.dart';
import 'package:cabofind/paginas/restaurantes.dart';
import 'package:cabofind/paginas/vida_nocturna.dart';
import 'package:cabofind/paginas/servicios.dart';
import 'package:cabofind/paginas/compras.dart';




void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
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
          child:           new MyHomePage()
      )



    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
  

}

class Home extends StatelessWidget {

  Map<String, dynamic> user = jsonDecode(
      "http://cabofind.com.mx/app_php/fotos1.php"
  );
  //print('Howdy, ${user['name']}!');
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

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

class _MyHomePageState extends State<MyHomePage> {
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Cabofind");
  int id=0;

  @override



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
      BottomNavigationBarItem(icon: Icon(Icons.star,),title: Text("Inicio")),
      BottomNavigationBarItem(icon: Icon(Icons.fiber_new,),title: Text("Lo nuevo")),
      BottomNavigationBarItem(icon: Icon(Icons.visibility,),title: Text("Más visto")),
      BottomNavigationBarItem(icon: Icon(Icons.favorite,),title: Text("Recomendado")),
      BottomNavigationBarItem(icon: Icon(Icons.bookmark,),title: Text("Publicaciones")),
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
              title: new Text('Restaurantes'),
              leading: Icon(Icons.restaurant),
              

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Restaurantes()));
              },
/*
                xd Column= new  Column(
                    children: <Widget>[
                      Center(
                        child: new ListTile(
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
                      ),
                    ],
                  ),
*/
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
                        builder: (BuildContext context) => new Compras()));
              },
            ),
            new ListTile(
              title: new Text('Compras'),
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
              title: new Text('Salud'),
              leading: Icon(Icons.healing),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Salud()));
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
                        builder: (BuildContext context) => new MyHomePageEng()));
              },
            ),
          ],
        ),
      ),

        );
  }
}



