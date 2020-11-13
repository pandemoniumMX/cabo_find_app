import 'dart:convert';
import 'package:cabofind/paginas/pedidos_historial.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main_esp.dart';
import 'list_manejador_menus.dart';
import 'list_manejador_restaurantes.dart';
import 'menu.dart';

class Domicilio extends StatefulWidget {
  final Categoria numeropagina;
  final Categoria numtab;

  const Domicilio({Key key, this.numeropagina, this.numtab}) : super(key: key);
  @override
  _DomicilioState createState() => _DomicilioState();
}

class _DomicilioState extends State<Domicilio> {
  DateTime now = DateTime.now();
  DateFormat dateFormat;
  List data;
  List restaurantes;
  List nuevos;
  int _page;
  int selectedIndex;
  PageController _c;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_domicilio_rest.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> getNew() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_domicilio_rest_new.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      nuevos = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> getRest() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_restaurantescat.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      restaurantes = json.decode(response.body);
    });

    return "Success!";
  }

  void initState() {
    _page = widget.numeropagina.cat;
    selectedIndex = widget.numeropagina.cat;
    super.initState();
    this.getData();
    this.getRest();
    this.getNew();

    _c = new PageController(
      initialPage: _page,
    );
    dateFormat = new DateFormat.Hm();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new Myapp()));
      },
      child: Scaffold(
          bottomNavigationBar: FFNavigationBar(
            theme: FFNavigationBarTheme(
              barBackgroundColor: Colors.white,
              selectedItemBorderColor: Colors.white,
              selectedItemBackgroundColor: Color(0xff60032D),
              selectedItemIconColor: Colors.white,
              selectedItemLabelColor: Colors.black,
            ),
            items: [
              FFNavigationBarItem(
                selectedBackgroundColor: Color(0xff773E42),
                iconData: FontAwesomeIcons.utensils,
                label: 'Inicio',
              ),
              FFNavigationBarItem(
                selectedBackgroundColor: Color(0xff773E42),
                iconData: FontAwesomeIcons.search,
                label: 'Buscar',
              ),
              FFNavigationBarItem(
                selectedBackgroundColor: Color(0xff773E42),
                iconData: FontAwesomeIcons.fileAlt,
                label: 'Pedidos',
              ),
            ],
            selectedIndex: selectedIndex,
            onSelectTab: (index) {
              this._c.animateToPage(index,
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.easeInOut);
            },
          ),
          appBar: AppBar(
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Myapp()));
                }),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Cabofood'),
                InkWell(
                    onTap: () {
                      setState(() {});
                    },
                    child: Icon(FontAwesomeIcons.syncAlt))
              ],
            ),
            backgroundColor: Color(0xff60032D),
          ),
          body: new PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _c,
            onPageChanged: (newPage) {
              setState(() {
                this._page = newPage;
                selectedIndex = newPage;
              });
            },
            children: <Widget>[
              ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    color: Color(0xffF9F9F9),
                    margin: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              FontAwesomeIcons.eye,
                              color: Color(0xff773E42),
                            ),
                            Text(
                              '  Explora lo que tenemos para tí.',
                              style: TextStyle(
                                  color: Color(0xff773E42),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            /*InkWell(
                              child: Text(
                                'Ver más',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              onTap: () {},
                            )*/
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Descubre las diferentes categorías.')
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xffF9F9F9),
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurantes == null ? 0 : restaurantes.length,
                      itemBuilder: (BuildContext context, int index) {
                        String id_c = restaurantes[index]["ID_CAT_REST"];
                        return InkWell(
                          onTap: () {
                            print(id_c);

                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new List_restaurantes_cat(
                                            manejador: new Users(id_c))));
                          },
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    margin: EdgeInsets.all(5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: FadeInImage(
                                        image: NetworkImage(
                                            restaurantes[index]['CAT_FOTO']),
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                        placeholder: AssetImage(
                                            'android/assets/images/loading.gif'),
                                        fadeInDuration:
                                            Duration(milliseconds: 200),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child:
                                    new Text(restaurantes[index]['CAT_NOMBRE'],
                                        style: new TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w300,
                                          //  backgroundColor: Colors.black45
                                        )),
                              ),
                            ],
                          ),
                        );

                        //  : SizedBox();
                      },
                    ),
                  ),
                  //termina lista de categorias
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              color: Color(0xff773E42),
                            ),
                            Text(
                              ' Restaurantes cerca de tí',
                              style: TextStyle(
                                  color: Color(0xff773E42),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            /*InkWell(
                              child: Text(
                                'Ver más',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              onTap: () {},
                            )*/
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Que se te antoja hoy?')
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: data == null ? 0 : data.length,
                      itemBuilder: (BuildContext context, int index) {
                        String id_n = data[index]["ID_NEGOCIO"];
                        String hora = data[index]["HOR_APERTURA"];
                        String estatus = data[index]["HOR_ESTATUS"];
                        String horaclose = data[index]["HOR_CIERRE"];
                        String formattedTime = DateFormat('h:mm a').format(now);
                        DateTime hora1 = dateFormat.parse(hora);
                        DateTime horacerrar = dateFormat.parse(horaclose);
                        DateTime hora2 =
                            new DateFormat("h:mm a").parse(formattedTime);

                        //DateTime apertura2 = new DateFormat("kk:mm:ss").parse(hora);
                        String apertura = DateFormat('h:mm a').format(hora1);

                        return estatus != 'A' //testing ==B
                            ? new InkWell(
                                onTap: () {},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5.0),
                                          margin: EdgeInsets.all(5.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              width: 250,
                                              height: 150,
                                              imageUrl: data[index]["GAL_FOTO"],
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          //  margin: EdgeInsets.all(50),
                                          height: 50,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                              color: Colors.black26,
                                            ),
                                            color: Colors.black26,
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Cerrado',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        children: [
                                          new Text(data[index]['NEG_NOMBRE'],
                                              style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                                //  backgroundColor: Colors.black45
                                              )),
                                          new Text(
                                              ' - ' + data[index]['CAT_NOMBRE'],
                                              style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                                //  backgroundColor: Colors.black45
                                              )),
                                        ],
                                      ),
                                    ),
                                    Divider()
                                  ],
                                ),
                              )
                            : hora1.isBefore(hora2) &&
                                    horacerrar.isAfter(hora2) //correcto
                                // : hora1 != null //testing
                                ? new InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new Menu_manejador(
                                                      manejador:
                                                          new Users(id_n))));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(5.0),
                                          margin: EdgeInsets.all(5.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              width: 250,
                                              height: 150,
                                              imageUrl: data[index]["GAL_FOTO"],
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Row(
                                            children: [
                                              new Text(
                                                  data[index]['NEG_NOMBRE'],
                                                  style: new TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w600,
                                                    //  backgroundColor: Colors.black45
                                                  )),
                                              new Text(
                                                  ' - ' +
                                                      data[index]['CAT_NOMBRE'],
                                                  style: new TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w600,
                                                    //  backgroundColor: Colors.black45
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Divider()
                                      ],
                                    ),
                                  )
                                : new InkWell(
                                    onTap: () {},
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5.0),
                                              margin: EdgeInsets.all(5.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  width: 250,
                                                  height: 150,
                                                  imageUrl: data[index]
                                                      ["GAL_FOTO"],
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              //  margin: EdgeInsets.all(50),
                                              height: 50,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                  color: Colors.black26,
                                                ),
                                                color: Colors.black26,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Hora de apertura: ' +
                                                      apertura.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: new Text(
                                              data[index]['NEG_NOMBRE'],
                                              style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w900,
                                                //  backgroundColor: Colors.black45
                                              )),
                                        ),
                                        Divider()
                                      ],
                                    ),
                                  );
                        //  : SizedBox();
                      },
                    ),
                  ), //termina  restaurantes cercanos
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              FontAwesomeIcons.fire,
                              color: Color(0xff773E42),
                            ),
                            Text(
                              ' Restaurantes nuevos.',
                              style: TextStyle(
                                  color: Color(0xff773E42),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            /*InkWell(
                              child: Text(
                                'Ver más',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              onTap: () {},
                            )*/
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Lo más nuevo en Cabofood')
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: nuevos == null ? 0 : nuevos.length,
                      itemBuilder: (BuildContext context, int index) {
                        String id_n = nuevos[index]["ID_NEGOCIO"];
                        String hora = nuevos[index]["HOR_APERTURA"];
                        String estatus = nuevos[index]["HOR_ESTATUS"];
                        String horaclose = nuevos[index]["HOR_CIERRE"];
                        String formattedTime = DateFormat('h:mm a').format(now);
                        DateTime hora1 = dateFormat.parse(hora);
                        DateTime horacerrar = dateFormat.parse(horaclose);
                        DateTime hora2 =
                            new DateFormat("h:mm a").parse(formattedTime);

                        String apertura = DateFormat('h:mm a').format(hora1);
                        print('aperturaaaaaaaaaaaaaaaaaa');
                        print(hora1);
                        print('cerrarrrrrrrrrrrrrrr');

                        print(horacerrar);
                        //  print(formattedTime);
                        return estatus != 'A' //testing ==B
                            ? new InkWell(
                                onTap: () {},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5.0),
                                          margin: EdgeInsets.all(5.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: FadeInImage(
                                              image: NetworkImage(
                                                  nuevos[index]['GAL_FOTO']),
                                              fit: BoxFit.fill,
                                              width: 300,
                                              height: 150,
                                              // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                                              placeholder: AssetImage(
                                                  'android/assets/images/loading.gif'),
                                              fadeInDuration:
                                                  Duration(milliseconds: 200),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          //  margin: EdgeInsets.all(50),
                                          height: 50,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                              color: Colors.black26,
                                            ),
                                            color: Colors.black26,
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Cerrado',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        children: [
                                          new Text(nuevos[index]['NEG_NOMBRE'],
                                              style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                                //  backgroundColor: Colors.black45
                                              )),
                                          new Text(
                                              ' - ' +
                                                  nuevos[index]['CAT_NOMBRE'],
                                              style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                                //  backgroundColor: Colors.black45
                                              )),
                                        ],
                                      ),
                                    ),
                                    Divider()
                                  ],
                                ),
                              )
                            : hora1.isBefore(hora2) &&
                                    horacerrar.isAfter(hora2) //correcto
                                // : hora1 != null //testing
                                ? new InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new Menu_manejador(
                                                      manejador:
                                                          new Users(id_n))));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(5.0),
                                          margin: EdgeInsets.all(5.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              width: 300,
                                              height: 150,
                                              imageUrl: nuevos[index]
                                                  ["GAL_FOTO"],
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Row(
                                            children: [
                                              new Text(
                                                  nuevos[index]['NEG_NOMBRE'],
                                                  style: new TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w600,
                                                    //  backgroundColor: Colors.black45
                                                  )),
                                              new Text(
                                                  ' - ' +
                                                      nuevos[index]
                                                          ['CAT_NOMBRE'],
                                                  style: new TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w600,
                                                    //  backgroundColor: Colors.black45
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Divider()
                                      ],
                                    ),
                                  )
                                : new InkWell(
                                    onTap: () {},
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5.0),
                                              margin: EdgeInsets.all(5.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  width: 300,
                                                  height: 150,
                                                  imageUrl: nuevos[index]
                                                      ["GAL_FOTO"],
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              //  margin: EdgeInsets.all(50),
                                              height: 50,
                                              width: 300,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                  color: Colors.black26,
                                                ),
                                                color: Colors.black26,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Hora de apertura: ' +
                                                      apertura.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: new Text(
                                              nuevos[index]['NEG_NOMBRE'],
                                              style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w900,
                                                //  backgroundColor: Colors.black45
                                              )),
                                        ),
                                        Divider()
                                      ],
                                    ),
                                  );
                        //  : SizedBox();
                      },
                    ),
                  ),
                ],
              ),

              Center(
                child: Text(
                  'Proximamente :)',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              new Pedidos_historial(
                pagina: Categoria(widget.numtab.cat),
              )
              //new Mis_recompensas(),
              //new Mis_promos(),
              //new Mis_favoritos(),
              //new Login()
            ],
          )),
    );
  }
}