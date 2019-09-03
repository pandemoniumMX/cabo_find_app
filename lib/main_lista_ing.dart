import 'dart:convert';
import 'package:cabofind/main.dart';
import 'package:cabofind/main_ing.dart';
import 'package:cabofind/main_lista.dart';
import 'package:cabofind/paginas/descubre.dart';
import 'package:cabofind/paginas/salud.dart';
import 'package:cabofind/paginas/youtube.dart';
import 'package:cabofind/paginas_ing/acercade.dart';
import 'package:cabofind/paginas_ing/compras.dart';
import 'package:cabofind/paginas_ing/descubre.dart';
import 'package:cabofind/paginas_ing/restaurantes.dart';
import 'package:cabofind/paginas_ing/salud.dart';
import 'package:cabofind/paginas_ing/servicios.dart';
import 'package:cabofind/paginas_ing/vida_nocturna.dart';
import 'package:cabofind/paginas_listas_ing/list_eventos.dart';
import 'package:cabofind/paginas_listas_ing/list_promociones_ing.dart';
import 'package:cabofind/paginas_listas_ing/list_publicaciones_ing.dart';
import 'package:cabofind/paginas_listas_ing/list_recomendado.dart';
import 'package:cabofind/paginas_listas_ing/list_visitado_ing.dart';

import 'package:cabofind/utilidades_ing/buscador_ing.dart';
import 'package:flutter/material.dart';
import 'package:cabofind/paginas/acercade.dart';
import 'package:cabofind/paginas/restaurantes.dart';
import 'package:cabofind/paginas/servicios.dart';
import 'package:cabofind/paginas/compras.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(new MyApp_lista_ing());

class MyApp_lista_ing extends StatelessWidget {
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
            child:           new MyHomePages_ing()
        )



    );
  }
}




class MyHomePages_ing extends StatefulWidget {
  @override
  _MyHomePages_ing createState() => new _MyHomePages_ing();

}




class _MyHomePages_ing extends State<MyHomePages_ing> {
  Icon idioma_ing = new Icon(Icons.flag);
  Icon actionIcon = new Icon(Icons.search);

  Widget appBarTitle = new Text("Cabofind");
  int id=0;

  @override

//  dispose();

  Widget build(BuildContext context) {
   // new Publicaciones();

    final tabpages=<Widget>[
      //llamar classes siempre despues de un <Widget>
      //lo que se declare aqui, sera el contenido de los botones de navigacion al fondo
     // new ImageCarousel2(),
      //new ImageCarousel2(),
      new Publicaciones_ing(),
      new Promociones_ing(),
      new Recomendado_visitado_ing(),
      new Recomendado_ing(),
      new Eventos_ing(),

    ];

    final bnbi=<BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.fire,),title: Text("Feeds")),
      BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.percent,),title: Text("Promotions")),
      BottomNavigationBarItem(icon: Icon(Icons.visibility,),title: Text("Most viewed")),
      BottomNavigationBarItem(icon: Icon(Icons.favorite,),title: Text("Recommended")),
      BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.calendarWeek,),title: Text("Events")),

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

        //enterTitle: true,
        title:appBarTitle,
        actions: <Widget>[

          new InkResponse(
                onTap: () {
              Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new MyApp_lista()
                        )
                        );
            },
                child: new Center(
                  //padding: const EdgeInsets.all(13.0),
                  
                  child: new Container(
                   decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: ExactAssetImage('assets/mexflag.png'),
                      fit: BoxFit.fill,
                    ),
                  
                      
                      ),
                      child: new Text("     ",
                    
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                    
                    

                  ),
                )
                ),

          new IconButton(
            icon: Icon(FontAwesomeIcons.thLarge,),
            onPressed: () {
              //Use`Navigator` widget to push the second screen to out stack of screens
              Navigator.of(context)
                  .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                return new MyApp_ing();
              }));
            }, ),

          new IconButton(
            icon: actionIcon,
              onPressed: () {
                //Use`Navigator` widget to push the second screen to out stack of screens
                Navigator.of(context)
                    .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new Buscador_ing();
                }));
              }, ),

        ],


      ),


      drawer: new Drawer(

        child: ListView(
          scrollDirection: Axis.vertical,

          children: <Widget>[

            new UserAccountsDrawerHeader(
              accountName: new Text('Categories menu '),
              //accountEmail: new Text('tu_correo@.com'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: AssetImage(
                    'android/assets/images/splash.png'),

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
              title: new Text('Night life'),
              leading: Icon(FontAwesomeIcons.glassCheers),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Vida_nocturna_ing()));
              },
            ),
            new ListTile(
              title: new Text('¿What to do?'),
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
              leading: Icon(FontAwesomeIcons.shoppingCart),

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
              leading: Icon(FontAwesomeIcons.heartbeat),

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
                        builder: (BuildContext context) => new MyApp_lista()
                        )
                        );
              },
            ),
          ],
        ),
      ),

        );
  }

}



