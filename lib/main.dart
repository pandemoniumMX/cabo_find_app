import 'dart:convert';
import 'package:cabofind/main_ing.dart';
import 'package:cabofind/main_lista.dart';
import 'package:cabofind/paginas/descubre.dart';
import 'package:cabofind/paginas/salud.dart';
import 'package:cabofind/paginas/youtube.dart';
import 'package:cabofind/paginas_listas/list_eventos_grid.dart';
import 'package:cabofind/paginas_listas/list_promociones.dart';
import 'package:cabofind/paginas_listas/list_promociones_grid.dart';
import 'package:cabofind/paginas_listas/list_publicaciones_grid.dart';
import 'package:cabofind/paginas_listas/list_recomendado_grid.dart';
import 'package:cabofind/utilidades/banderasicon_icons.dart' as banderax;
import 'package:cabofind/utilidades/buscador.dart';
import 'package:cabofind/utilidades/buscador_2.dart';
import 'package:cabofind/utilidades/buscador_notap.dart';

import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/paginas_listas/list_publicaciones.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cabofind/paginas/acercade.dart';
import 'package:cabofind/paginas/restaurantes.dart';
import 'package:cabofind/paginas/vida_nocturna.dart';
import 'package:cabofind/paginas/servicios.dart';
import 'package:cabofind/paginas/compras.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';







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
            child:           new MyHomePages()
        )



    );
  }
}

class MyHomePages extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();


}
  @override


  



class ImeiPlugin {
  static const MethodChannel _channel = const MethodChannel('imei_plugin');

  // get imei android device @return String or null
  static Future<String> get getImei async {
    final String version = await _channel.invokeMethod('getImei');
    print('Running on ${version}');
    return version;
  }

}



class _MyHomePageState extends State<MyHomePages> {
 // Icon idioma_ing = new Icon(FontAwesomeIcons.flagUsa);

  Icon actionIcon = new Icon(Icons.search);

  Widget appBarTitle = new Text("Cabofind");
  int id=0;
 


    @override//Registro descarga en Android
    Future<String> checkModelAndroid() async {
       String currentLocale;
    try {
      currentLocale = await Devicelocale.currentLocale;
      print(currentLocale);
    } on PlatformException {
      print("Error obtaining current locale");
    }

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //print('Running on ${androidInfo.id}');
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insertInfo.php?MOD=${androidInfo.model}&BOOT=${androidInfo.display},${androidInfo.bootloader}&VERSION=${androidInfo.product}&IDIOMA=${currentLocale}"),

        headers: {
          "Accept": "application/json"
        }
    );
  
  } 
  /*Registro descarga en iOS
  @override
    Future<String> checkModelIos() async {
    String currentLocale;
    try {
      currentLocale = await Devicelocale.currentLocale;
      print(currentLocale);
    } on PlatformException {
      print("Error obtaining current locale");
    }
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    //print('Running on ${iosInfo.identifierForVendor}');
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insertInfoiOS.php?MOD=${iosInfo.model}&BOOT=${iosInfo.utsname.nodename}&VERSION=${iosInfo.systemName}&IDIOMA=${languages}"),

        headers: {
          "Accept": "application/json"
        }
    );

  }
*/




 @override
  void initState() {
    super.initState(

    );
    //this.checkModelIos();
    this.checkModelAndroid();
  


  }

  Widget build(BuildContext context) {
   // new Publicaciones();

    final tabpages=<Widget>[
      //llamar classes siempre despues de un <Widget>
      //lo que se declare aqui, sera el contenido de los botones de navigacion al fondo
     // new ImageCarousel2(),
      //new ImageCarousel2(),
      new Publicaciones_grid(),
      new Promociones_grid(),
      //new Publicaciones_grid(),
      new Recomendado_grid(),
      new Eventos_grid(),

    ];

    final bnbi=<BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.fire,),title: Text("Inicio")),
      BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.percent,),title: Text("Promos")),
      //BottomNavigationBarItem(icon: Icon(Icons.visibility,),title: Text("Más visto")),
      BottomNavigationBarItem(icon: Icon(Icons.favorite,),title: Text("Recomendado")),
      BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.calendarWeek,),title: Text("Eventos")),

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
                        builder: (BuildContext context) => new MyHomePages_ing()
                        )
                        );
            },
                child: new Center(
                  //padding: const EdgeInsets.all(13.0),
                  
                  child: new Container(
                   decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: ExactAssetImage('assets/usaflag.png'),
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
                return new MyApp_lista();
              }));
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
              accountName: new Text('Menú categorias '),
              //accountEmail: new Text('tu_correo@.com'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: AssetImage(
                    'android/assets/images/splash.png'),

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
              leading: Icon(FontAwesomeIcons.glassCheers),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Vida_nocturna()));
              },
            ),
            new ListTile(
              title: new Text('¿Que hacer?'),
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
              title: new Text('Compras'),
              leading: Icon(FontAwesomeIcons.shoppingCart),

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
              leading: Icon(FontAwesomeIcons.heartbeat),

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
                        builder: (BuildContext context) => new Acercade()));
              },
            ),
            new ListTile(
              title: new Text('English'),
              leading: Icon(FontAwesomeIcons.flagUsa),

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new MyHomePages_ing()
                        )
                        );
              },
            ),
          ],
        ),
      ),

        );
  }
  @override
  void dispose() {
    super.dispose();
  }
}



