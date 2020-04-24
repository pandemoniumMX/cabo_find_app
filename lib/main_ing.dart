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
import 'package:cabofind/paginas_ing/login.dart';
import 'package:cabofind/paginas_ing/maps.dart';
import 'package:cabofind/paginas_ing/misfavoritos.dart';
import 'package:cabofind/paginas_ing/mispromos.dart';
import 'package:cabofind/paginas_ing/promociones.dart';
import 'package:cabofind/paginas_ing/publicacion_detalle.dart';
import 'package:cabofind/paginas_ing/publicaciones.dart';
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
import 'package:cabofind/utilidades_ing/buscador.dart';
import 'package:cabofind/utilidades_ing/calculadora.dart';
import 'package:cabofind/utilidades_ing/notificaciones.dart';
import 'package:cabofind/utilidades_ing/rutas.dart';
import 'package:cabofind/weather/weather/weather_builder.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cabofind/paginas/acercade.dart';
import 'package:cabofind/paginas/restaurantes.dart';
import 'package:cabofind/paginas/servicios.dart';
import 'package:cabofind/paginas/compras.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_esp.dart';
import 'paginas_ing/anuncios.dart';
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
          primaryColor: Color(0xff01969a),
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
  final fromTextController = TextEditingController();
  List<String> currencies;
  String fromCurrency = "USD";
  String toCurrency = "MXN";
  String result;
  Icon idioma_ing = new Icon(Icons.flag);
  Icon actionIcon = new Icon(Icons.search);

  Widget appBarTitle = new Text("Cabofind");

 @override
  final String _idioma = "espanol";

List data;


   //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/estructura_ing.php"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          data = json.decode(
              response.body);
        });
    

    return "Success!";
  }

  @override
  void initState() {
    //addStringToSF();
    super.initState();
 _c =  new PageController(
      initialPage: _page,
      
    );
    fcmSubscribe(); 
    setupNotification();
    this.getData();
    _loadCurrencies();


    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();
    
       


  }

  Future<String> _loadCurrencies() async {
    String uri = "http://api.openrates.io/latest";
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    Map curMap = responseBody['rates'];
    currencies = curMap.keys.toList();
    setState(() {});
    print(currencies);
    return "Success";
  }

  Future<String> _doConversion() async {
    String uri = "http://api.openrates.io/latest?base=$fromCurrency&symbols=$toCurrency";
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    setState(() {
      result = (double.parse(fromTextController.text) * (responseBody["rates"][toCurrency])).toString();
    });
    print(result);
    return "Success";
  }

  _onFromChanged(String value) {
    setState(() {
      fromCurrency = value;
    });
  }

  _onToChanged(String value) {
    setState(() {
      toCurrency = value;
    });
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
  int _page = 0;
  int selectedIndex = 0;
 PageController _c;
  Widget build(BuildContext context) {
   Widget _buildDropDownButton(String currencyCategory) {
    return DropdownButton(
      value: currencyCategory,
      items: currencies
          .map((String value) => DropdownMenuItem(
                value: value,
                child: Row(
                  children: <Widget>[
                    Text(value),
                  ],
                ),
              ))
          .toList(),
      onChanged: (String value) {
        if(currencyCategory == fromCurrency){
          _onFromChanged(value);
        }else {
          _onToChanged(value);
        }
      },
    );
  }

    Widget cuerpo = Container(

        
     // height: MediaQuery.of(context).size.height,
    child: new  StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount:data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) => new Container(
          //color: Colors.white,
        child: Container(
          
          decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(20.0),
                    

                    border: Border.all(
                        color: Color(0xff01969a),)),
                padding: EdgeInsets.all(
                    5.0),
                margin: EdgeInsets.all(
                    10.0),
          child: InkWell(
                    child: Column(

              children: <Widget>[               

                Expanded(
                child: Stack(
                
                children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                                  child: FadeInImage(   
                        image: NetworkImage(data[index]["est_foto"]),  
                        fit: BoxFit.cover,  
                        width: MediaQuery.of(context).size.width,  
                        //height: MediaQuery.of(context).size.height * 0.38,  
                        height: MediaQuery.of(context).size.height,  
                        // placeholder: AssetImage('android/assets/images/jar-loading.gif'),  
                        placeholder: AssetImage('android/assets/images/loading.gif'),  
                        fadeInDuration: Duration(milliseconds: 200),   
                        
                      ),
                ),
                    Positioned(
                     
                                child: Center(
                                  child: new Text (
                                  data[index]["est_nombre_ing"],
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w900,
                                    backgroundColor: Colors.black45
                                  )
                              ),
                                ),
                              
                                
                              ),  
                              
],
                                  ),
                ),

/*
                Row(
                    children: <Widget>[


                      Padding(
                          child: new Text(
                            data[index]["NEG_NOMBRE"],
                            overflow: TextOverflow.ellipsis,),
                          padding: EdgeInsets.all(
                              1.0)),
                      Text(
                          " | "),
                      Flexible(
                        child: new Text(
                          data[index]["NEG_LUGAR"],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,),


                      ),



                    ]),
*/

              ],

            ),
            onTap: () {


              String ruta = data[index]["est_navegacion"];
              print(ruta);

               if( ruta == "Restaurantes"){

                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Restaurantes_ing()
                        )
                        );

               } else if (ruta == "Descubre"){
                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Descubre_ing()
                        )
                        );
               } else if (ruta == "Compras"){
                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Compras_ing()
                        )
                        );
               } else if (ruta == "Educacion"){
                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Educacion_ing()
                        )
                        );
               } else if (ruta == "Eventos"){
                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Eventos_ing_grid()
                        )
                        );
               } else if (ruta == "Acercade"){
                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Acercade_ing()
                        )
                        );
              } else if (ruta == "Promociones"){
                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Promociones_list_ing()
                        )
                        );
               } else if (ruta == "Salud"){
                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Salud_ing()
                        )
                        );
               } else if (ruta == "Servicios"){
                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Servicios_ing()
                        )
                        );
               } else if (ruta == "Vida_nocturna"){
                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Vida_nocturna_ing()
                        )
                        );
                } else if (ruta == "Publicaciones"){
                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Publicaciones_grid_ing()
                        )
                        );
               } else if (ruta == "Anuncios"){
                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Anuncios_ing()
                        )
                        );
               } else if (ruta == "Mapa"){
                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Maps_ing()
                        )
                        );
                 
                } else if (ruta == "Rutas"){
                 Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Rutas_ing()
                        )
                        );
                 
               }
              
              
          


            },
          ),
        ),

      ),

      staggeredTileBuilder: (int index) =>
      new StaggeredTile.count(2, index.isEven ? 2 :2 ),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    ),

    );
    



    return  Scaffold(

        appBar: new AppBar(

        //enterTitle: true,
        title:appBarTitle,
        actions: <Widget>[

              new InkResponse( 
                onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Notificaciones_ing()
                        )
                        );
               },
                child: Stack(
                    children: <Widget>[
                    /*Positioned(
                      
                                right: 2.0,
                                bottom: 30,
                                child: new Text('22',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0, color: Colors.redAccent)),
                              ),*/ 
                    Positioned(
                                height: 20,
                                width: 20,
                                right: 3.0,
                                bottom: 28,
                                child: new FloatingActionButton(
                                  
                                  child: new Text('',
                                 style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0, color: Colors.white)),
                                  backgroundColor: Colors.red,
                                  
                                 
                                ),
                              ),             
                    new Center(
                      child: new Row(                   
                        children: <Widget>[new Icon(FontAwesomeIcons.bell),
                        Text("  ",                    
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),
                        ),
                        ]
                      ),
                    ),
                  ],
                )
                ),

          
              new InkResponse( 
                onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new WeatherBuilder().build()
                        )
                        );
               },
                child: new Center(
                  child: new Row(                   
                    children: <Widget>[new Icon(FontAwesomeIcons.cloudSun),
                    Text("   ",                    
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                    ]
                  ),
                )
                ),
          
              new InkResponse( 
                onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Calculadora_ing()
                        )
                        );
               },
                child: new Center(
                  child: new Row(                   
                    children: <Widget>[new Icon(FontAwesomeIcons.moneyBillAlt),
                    Text("   ",                    
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                    ]
                  ),
                )
                ),
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
      bottomNavigationBar: FFNavigationBar(
        
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Colors.white,
          selectedItemBackgroundColor: Color(0xff01969a),
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
        ),
        
      
        items: [
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.home,
            label: 'Home',
          ),
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.fire,
            label: 'Deals',
          ),
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.solidHeart,
            label: 'Favorites',
          ),
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.userAlt,
            label: 'Profile',
           ),
          
        ],

        selectedIndex: selectedIndex,
        onSelectTab: (index){
          this._c.animateToPage(index,duration: const Duration(milliseconds: 10),curve: Curves.easeInOut);
        },
      ),


      body: new PageView(
        controller: _c,
        
        onPageChanged: (newPage){
          setState((){
            this._page=newPage;
            selectedIndex=newPage;
          });
        },
        children: <Widget>[
          cuerpo,
          new Mis_promos_ing(),
          new Mis_favoritos_ing(),
          new Login_ing()
        ],
      ),
      
      

        );
  }

}



