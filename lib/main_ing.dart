import 'dart:async';
import 'dart:convert';
import 'package:cabofind/main.dart';
import 'package:cabofind/main_lista_ing.dart';
import 'package:cabofind/notificaciones/push_publicacion_android.dart';
import 'package:cabofind/paginas/descubre.dart';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas/salud.dart';
import 'package:cabofind/paginas/youtube.dart';
import 'package:cabofind/paginas_ing/acercade.dart';
import 'package:cabofind/paginas_ing/compras.dart';
import 'package:cabofind/paginas_ing/descubre.dart';
import 'package:cabofind/paginas_ing/educacion.dart';
import 'package:cabofind/paginas_ing/publicacion_detalle.dart';
import 'package:cabofind/paginas_ing/restaurantes.dart';
import 'package:cabofind/paginas_ing/salud.dart';
import 'package:cabofind/paginas_ing/servicios.dart';
import 'package:cabofind/paginas_ing/vida_nocturna.dart';
import 'package:cabofind/paginas_listas_ing/list_eventos_grid.dart';
import 'package:cabofind/paginas_listas_ing/list_promociones_grid.dart';
import 'package:cabofind/paginas_listas_ing/list_promociones_ing.dart';
import 'package:cabofind/paginas_listas_ing/list_publicaciones_grid.dart';
import 'package:cabofind/paginas_listas_ing/list_publicaciones_ing.dart';
import 'package:cabofind/paginas_listas_ing/list_recomendado_grid.dart';
import 'package:cabofind/paginas_listas_ing/list_visitado_grid.dart';
import 'package:cabofind/utilidades/banderasicon_icons.dart';
import 'package:cabofind/utilidades/classes.dart';

import 'package:cabofind/utilidades_ing/buscador_ing.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cabofind/paginas/acercade.dart';
import 'package:cabofind/paginas/restaurantes.dart';
import 'package:cabofind/paginas/servicios.dart';
import 'package:cabofind/paginas/compras.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:geocoder/geocoder.dart';
//import 'package:geolocator/geolocator.dart';



FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void fcmSubscribe() {
  _firebaseMessaging.unsubscribeFromTopic('Todos');
    _firebaseMessaging.subscribeToTopic('All');
  }

void main() => runApp(new MyApp_ing());

class MyApp_ing extends StatelessWidget {
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
  final String _idioma = "espanol";

  @override
  void initState() {
    //addStringToSF();
    super.initState();

    fcmSubscribe(); 
    setupNotification();
    


    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();
    
       


  }

  addStringToSF() async {
  	final SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.remove("stringValue");
	prefs.setString('stringValue', _idioma);
  }


  void setupNotification() async {

    _firebaseMessaging.requestNotificationPermissions();


    _firebaseMessaging.getToken().then( (token) {


      print('===== FCM Token =====');
      print( token );

    });


    _firebaseMessaging.configure(

      onMessage: ( Map<String, dynamic> message ) async {

        print('======= On Message ========');
        print(" $message" );

        String id_n= (message['data']['id_n']) as String;
        String id =(message['data']['id'])as String;

       
          showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('New post!',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: 300,
                 height: 300.0,
                 child: FadeInImage(

                   image: NetworkImage("http://cabofind.com.mx/assets/img/alerta.png"),
                   fit: BoxFit.fill,
                   width: 300,
                   height: 300,

                   // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                   placeholder: AssetImage('android/assets/images/loading.gif'),
                   fadeInDuration: Duration(milliseconds: 200),

                 ),
                 
             ),
             actions: <Widget>[
               new FlatButton(
                 child: new Text('Close'),
                 onPressed: () {
                   Navigator.of(context).pop();
                 },
               ), 
               new FlatButton(
                 color: Colors.blueAccent,
                 child: new Text('Discover',style: TextStyle(fontSize: 14.0,color: Colors.white),),
                 onPressed: () {
                  Navigator.push(context, new MaterialPageRoute
              (builder: (context) => new Publicacion_detalle_fin_ing(
              publicacion: new Publicacion(id_n,id),
            )
            )
            );
                 },
               )
             ],
           );
         });
            
/*
       showDialog(
         context: context,
         builder: (context) => AlertDialog(
           content: ListTile(
             title: Text(message['data']['id_n']),
             subtitle: Text(message['data']['id']),

           ),
         )
       );
*/
       

      },

      onLaunch: ( Map<String, dynamic> message ) async {

        print('======= On launch ========');
        print(" $message" );

       String id_n= (message['data']['id_n']) as String;
        String id =(message['data']['id'])as String;

       Navigator.push(context, new MaterialPageRoute
              (builder: (context) => new Publicacion_detalle_fin_ing(
              publicacion: new Publicacion(id_n,id),
            )
            )
            );

       

      },

      onResume: ( Map<String, dynamic> message ) async {

        print('======= On resume ========');
        print(" $message" );

       String id_n= (message['data']['id_n']) as String;
        String id =(message['data']['id'])as String;

       Navigator.push(context, new MaterialPageRoute
              (builder: (context) => new Publicacion_detalle_fin_ing(
              publicacion: new Publicacion(id_n,id),
            )
            )
            );

       

      },


    );


  }

  Widget build(BuildContext context) {
   // new Publicaciones();

    final tabpages=<Widget>[
      //llamar classes siempre despues de un <Widget>
      //lo que se declare aqui, sera el contenido de los botones de navigacion al fondo
     // new ImageCarousel2(),
      //new ImageCarousel2(),
      new Publicaciones_grid(),
      new Promociones_ing_grid(),
      new Publicaciones_vistos_grid_ing(),
      new Recomendado__ing_grid(),
      new Eventos_ing_grid(),


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
                 addStringToSF();
              Navigator.of(context).pop();
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Myapp()
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
            icon: Icon(FontAwesomeIcons.gripLines,),
            onPressed: () {
              //Use`Navigator` widget to push the second screen to out stack of screens
              Navigator.of(context)
                  .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                return new MyApp_lista_ing();
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
              title: new Text('Education'),
              leading: Icon(FontAwesomeIcons.graduationCap),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Educacion_ing()));
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
                addStringToSF();
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Myapp()
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



