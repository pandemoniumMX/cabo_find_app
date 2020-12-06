import 'dart:async';
import 'dart:convert';
import 'package:cabofind/main.dart';
import 'package:cabofind/paginas_ing/acercade.dart';
import 'package:cabofind/paginas_ing/compras.dart';
import 'package:cabofind/paginas_ing/descubre.dart';
import 'package:cabofind/paginas_ing/educacion.dart';
import 'package:cabofind/paginas_ing/login.dart';
import 'package:cabofind/paginas_ing/maps.dart';
import 'package:cabofind/paginas_ing/mis_reservaciones.dart';
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
import 'package:cabofind/settings.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:cabofind/utilidades_ing/buscador.dart';
import 'package:cabofind/utilidades_ing/calculadora.dart';
import 'package:cabofind/utilidades_ing/notificaciones.dart';
import 'package:cabofind/utilidades_ing/rutas.dart';
import 'package:cabofind/weather/weather/weather_builder.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'paginas_ing/anuncios.dart';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void fcmSubscribe() {
  _firebaseMessaging.unsubscribeFromTopic('Todos');
  _firebaseMessaging.subscribeToTopic('All');
}

class MyHomePages_ing extends StatefulWidget {
  @override
  _MyHomePages_ing createState() => new _MyHomePages_ing();
}

class _MyHomePages_ing extends State<MyHomePages_ing> {

  Icon actionIcon = new Icon(Icons.search);

  Widget appBarTitle = new Text("Cabofind");

  @override

  List data;
  List portada;

  Future<String> getPortada() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/list_portada.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      portada = json.decode(response.body);
    });

    return "Success!";
  }

  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/estructura_ing.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  @override
  void initState() {
    this.getPortada();
    super.initState();
    _c = new PageController(
      initialPage: _page,
    );
    fcmSubscribe();
    setupNotification();
    this.getData();


  }

 


  void setupNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print('===== FCM Token =====');
      print(token);
      prefs.setString('stringToken', token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('======= On Message ========');
        print(" $message");

        String id_n = (message['data']['id_n']) as String;
        String id = (message['data']['id']) as String;
        String idr = (message['data']['idr']) as String;

        idr != null
            ? showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Reservation',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    content: Container(
                        width: 300,
                        height: 50.0,
                        child: Text('Reservation status #$idr')),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text('Close'),
                        onPressed: () {
                          // _stopFile();

                          Navigator.of(context).pop();
                        },
                      ),
                      new FlatButton(
                        color: Color(0xff773E42),
                        child: new Text(
                          'See status',
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new Mis_reservaciones_ing()));
                        },
                      )
                    ],
                  );
                })
            : id_n != null
                ? showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'New post!',
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                        content: Container(
                          width: 300,
                          height: 300.0,
                          child: FadeInImage(
                            image: NetworkImage(
                                "http://cabofind.com.mx/assets/img/alerta.png"),
                            fit: BoxFit.fill,
                            width: 300,
                            height: 300,

                            // placeholder: AssetImage('android/assets/images/loading.gif'),
                            placeholder:
                                AssetImage('android/assets/images/loading.gif'),
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
                            color: Colors.black,
                            child: new Text(
                              'Discover',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new Publicacion_detalle_fin_ing(
                                            publicacion:
                                                new Publicacion(id_n, id),
                                          )));
                            },
                          )
                        ],
                      );
                    })
                : SizedBox();

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
      onLaunch: (Map<String, dynamic> message) async {
        print('======= On launch ========');
        print(" $message");

        String id_n = (message['data']['id_n']) as String;
        String id = (message['data']['id']) as String;
        String idr = (message['data']['idr']) as String;
        idr != null
            ? Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Mis_reservaciones_ing()))
            : id_n != null
                ? Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Publicacion_detalle_fin_ing(
                              publicacion: new Publicacion(id_n, id),
                            )))
                : SizedBox();
      },
      onResume: (Map<String, dynamic> message) async {
        print('======= On resume ========');
        print(" $message");

        String id_n = (message['data']['id_n']) as String;
        String id = (message['data']['id']) as String;
        String idr = (message['data']['idr']) as String;
        idr != null
            ? Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Mis_reservaciones_ing()))
            : id_n != null
                ? Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Publicacion_detalle_fin_ing(
                              publicacion: new Publicacion(id_n, id),
                            )))
                : SizedBox();
      },
    );
  }

  int _page = 0;
  int selectedIndex = 0;
  PageController _c;
  Widget build(BuildContext context) {
   

    Widget cuerpo = new GridView.builder(
      padding: EdgeInsets.only(top: 2),
      itemCount: data == null ? 0 : data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.height / 1500,
      ),
      itemBuilder: (BuildContext context, int index) => Container(
        height: 400,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(2),
        child: Stack(
          children: [
            InkWell(
              child: CachedNetworkImage(
                fit: BoxFit.fitHeight,
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 2,
                imageUrl: data[index]["est_foto"],
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              onTap: () {
                String ruta = data[index]["est_navegacion"];
                print(ruta);

                if (ruta == "Restaurantes") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Restaurantes_ing()));
                } else if (ruta == "Descubre") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Descubre_ing()));
                } else if (ruta == "Compras") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Compras_ing()));
                } else if (ruta == "Educacion") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Educacion_ing()));
                } else if (ruta == "Eventos") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Eventos_ing_grid()));
                } else if (ruta == "Acercade") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Acercade_ing()));
                } else if (ruta == "Promociones") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Promociones_list_ing()));
                } else if (ruta == "Salud") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Salud_ing()));
                } else if (ruta == "Servicios") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Servicios_ing()));
                } else if (ruta == "Vida_nocturna") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Vida_nocturna_ing()));
                } else if (ruta == "Publicaciones") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Publicaciones_grid_ing()));
                } else if (ruta == "Anuncios") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Anuncios_ing()));
                } else if (ruta == "Mapa") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Maps_ing()));
                } else if (ruta == "Rutas") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Rutas_ing()));
                }
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Point(
                      triangleHeight: 10.0,
                      edge: Edge.LEFT,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, top: 8.0, bottom: 8.0),
                        color: Color(int.parse(data[index]["est_color"])),
                        child: new Text(data[index]["est_nombre_ing"],
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900,
                              //  backgroundColor: Colors.black45
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      /* staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 2),*/
    );

    return Scaffold(
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Colors.white,
          selectedItemBackgroundColor: Color(0xff773E42),
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Color(0xff773E42),
        ),
        items: [
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.home,
            label: 'Home',
          ),
          /*  FFNavigationBarItem(
            iconData: FontAwesomeIcons.fire,
            label: 'Deals',
          ),
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.solidHeart,
            label: 'Favorites',
          ),*/
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.userAlt,
            label: 'Profile',
          ),
        ],
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          this._c.animateToPage(index,
              duration: const Duration(milliseconds: 10),
              curve: Curves.easeInOut);
        },
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              floating: true,
              pinned: true,
              automaticallyImplyLeading: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.all(10.0),
                background: GestureDetector(
                  onTap: () {},
                  child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    imageUrl: portada[0]["POR_FOTO_ING"],
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                centerTitle: false,
                title: Text("Cabofind",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                    )),
              ),
              actions: <Widget>[
                new InkResponse(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new Notificaciones_ing()));
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0,
                                    color: Colors.white)),
                            backgroundColor: Colors.red,
                          ),
                        ),
                        new Center(
                          child: new Row(children: <Widget>[
                            new Icon(FontAwesomeIcons.bell),
                            Text(
                              "  ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25.0),
                            ),
                          ]),
                        ),
                      ],
                    )),
                new InkResponse(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new WeatherBuilder().build()));
                    },
                    child: new Center(
                      child: new Row(children: <Widget>[
                        new Icon(FontAwesomeIcons.cloudSun),
                        Text(
                          "   ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.0),
                        ),
                      ]),
                    )),
                new InkResponse(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new Calculadora_ing()));
                    },
                    child: new Center(
                      child: new Row(children: <Widget>[
                        new Icon(FontAwesomeIcons.moneyBillAlt),
                        Text(
                          "   ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.0),
                        ),
                      ]),
                    )),
                new InkResponse(
                    onTap: () {
                      //Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new Settings()));
                    },
                    child: new Center(
                      //padding: const EdgeInsets.all(13.0),

                      child: new Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: ExactAssetImage('assets/usaflag.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: new Text(
                          "     ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.0),
                        ),
                      ),
                    )),
                new IconButton(
                  icon: actionIcon,
                  onPressed: () {
                    //Use`Navigator` widget to push the second screen to out stack of screens
                    Navigator.of(context).push(MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                      return new Buscador_ing();
                    }));
                  },
                ),
              ],
            ),
          ];
        },
        body: new PageView(
          controller: _c,
          onPageChanged: (newPage) {
            setState(() {
              this._page = newPage;
              selectedIndex = newPage;
            });
          },
          children: <Widget>[
            cuerpo,
            // new Mis_promos_ing(),
            // new Mis_favoritos_ing(),
            new Login_ing()
          ],
        ),
      ),
    );
  }
}
