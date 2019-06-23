import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/utilidades/carousel_pro.dart';
import 'package:http/http.dart' as http;
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



Future<Quote> getQuote(Str) async {
  String url = 'http://cabofind.com.mx/app_php/fotos1.php';
  final response = await http.get(url, headers: {"Accept": "application/json"});


  if (response.statusCode == 200 ) {
    return Quote.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class User {

  final String name;
  final String picture;
  User(this.name, this.picture);
}
class Quote {
  final String author;
  final String quote;

  Quote({this.author, this.quote});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      author: json['GAL_FOTO'],
      quote: json['GAL_TIPO'],
    );
  }
}



class Empresa_det_fin extends StatefulWidget {
List data;
//final Publicacion publicacion;
final Empresa empresa;

Empresa_det_fin({Key key, @required this.empresa}) : super(
    key: key);

@override
  Detalles createState() => new Detalles();

}

class Detalles extends State<Empresa_det_fin> {
  ScrollController _scrollController = new ScrollController();

  List data;
  List data1;
  List data_list;







  Widget setupAlertDialoadContainer() {

    return Container(
        height: 300.0, // Change as per your requirement
        width: 300.0,
        child: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return new ListTile(

                title: new Column(
                    children: <Widget>[
                      Text(
                          data[index]["CAR_NOMBRE"]
                      ),
                    ],
                  )

              );
            }
        )
    );
  }



  
  _alertSer(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Servicios'),
            content: Container(
              width: double.maxFinite,
              height: 300.0,
                child: ListView.builder(
                    itemCount: data == null ? 0 : data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Text(data[index]["CAR_NOMBRE"]),
                        ],
                      );
                    }
                )
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _alertCar(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Servicios'),
            content: Container(
                width: double.maxFinite,
                height: 300.0,
                child: ListView.builder(
                    itemCount: data == null ? 0 : data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Text(data[index]["CAR_NOMBRE"]),
                        ],
                      );
                    }
                )
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<String> getCar() async {
    var response = await http.get(
        Uri.encodeFull(
          //"http://cabofind.com.mx/app_php/list_caracteristicas.php?ID=${widget.empresa.id}"),
          //  "http://cabofind.com.mx/app_php/list_caracteristicas.php?ID=${widget.empresa.id}"),
         "http://cabofind.com.mx/app_php/list_caracteristicas.php"),



        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          data = json.decode(
              response.body);
        });
    print(
        data[0]["CAR_NOMBRE"]);

    return "Success!";
  }

  Future<String> get_list() async {
    var response = await http.get(
        Uri.encodeFull(
           //"http://cabofind.com.mx/app_php/list_publicaciones.php"),
         "http://cabofind.com.mx/app_php/list_publicaciones_api.php?ID=${widget.empresa.id_nm}"),


        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          data_list = json.decode(
              response.body);
        });
    print(
        data_list[0]["NEG_DESCRIPCION"]);

    return "Success!";
  }
  void initState() {
    super.initState(

    );
    this.getCar();
    this.get_list();
  }

 Widget build(BuildContext context){




  Widget carrusel = Container(

      child: FutureBuilder<Quote>(
        future: getQuote(String), //sets the getQuote method as the expected Future
        builder: (context, snapshot) {
          if (snapshot.hasData) { //checks if the response returns valid data
            return Center(
              child: Carousel(
            boxFit: BoxFit.fill,
            images: [

              Image.network(widget.empresa.logo),

             
            ],
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(
                milliseconds: 2000),
          ),
            );
          } else if (snapshot.hasError) { //checks if the response throws an error
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),

    );

    
    Widget titleSection = Container(
          width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.blue)),
      padding: const EdgeInsets.all(20),
      child: Column(
        children:[
          Row(
            mainAxisAlignment: 
            MainAxisAlignment.center,            
            children: [

                 Text(
                  widget.empresa.nombre,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                      fontSize: 20.0
                  ),
                ),

              

            ],
          ),
          Row(children: <Widget>[
                Text(
                widget.empresa.cat,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
              Text(
                widget.empresa.subs,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
          ],
          )

          
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;


    Widget textSection = Container(
      padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
      child: Card(
              child: Text(
           widget.empresa.desc,
          maxLines: 10,
          softWrap: true,
          textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
        ),
      ),

    );
    mapa() async {
      final url =  widget.empresa.maps;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    Widget mapSection = Container(
      padding: const EdgeInsets.only(bottom: 10,left: 125,right: 125),
      child: RaisedButton.icon(
        textColor: Colors.white,
        color: Color(0xff189bd3),
        onPressed: mapa,
        icon: Icon(Icons.place),

        label: Text('Abrir mapa'),

        //child: Text('Abrir Mapa' ),
      ),
      
    );


    Widget buttonSection = Container(
      width: MediaQuery.of(context).size.width +30,

    
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton.icon(
          label: Text('Caracteristicas', style: TextStyle(color: Colors.white),) ,
          color: Color(0xff189bd3),
          onPressed: () => _alertCar(context),
          icon: Icon(Icons.extension),
          textColor: Colors.white,

        ),
          RaisedButton.icon(
            label: Text('Servicios', style: TextStyle(color: Colors.white),) ,
            color: Color(0xff189bd3),
            onPressed: () => _alertSer(context),
            icon: Icon(Icons.accessibility),
            textColor: Colors.white,
          ),

        ],
      ),

    );

  Widget publicaciones =  Container(

    child:  ListView.builder(
      shrinkWrap: false,
      physics: BouncingScrollPhysics(),
      itemCount: data_list == null ? 0 : data_list.length,
      itemBuilder: (BuildContext context, int index) {

        return new ListTile(


          title: new Card(

            elevation: 5.0,
            child: new Container(


              decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10.0),

                  border: Border.all(
                      color: Colors.blue)),
              padding: EdgeInsets.all(
                  10.0),
              margin: EdgeInsets.all(
                  10.0),

              child: Column(

                children: <Widget>[

                  Padding(

                      child: Text(

                        data_list[index]["PUB_TITULO"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.0,


                        ),

                      ),
                      padding: EdgeInsets.all(
                          1.0)
                  ),

                  FadeInImage(

                    image: NetworkImage(data_list[index]["GAL_FOTO"]),
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: 250,

                    // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                    placeholder: AssetImage('android/assets/images/loading.gif'),
                    fadeInDuration: Duration(milliseconds: 200),

                  ),


                  Row(
                      children: <Widget>[

                        Padding(

                            child: Text(

                                data_list[index]["CAT_NOMBRE"]),
                            padding: EdgeInsets.all(
                                1.0)),
                        Text(
                            " | "),
                        Padding(
                            child: new Text(
                                data_list[index]["NEG_NOMBRE"]),
                            padding: EdgeInsets.all(
                                1.0)),
                        Text(
                            " | "),
                        Padding(
                            child: new Text(
                                data_list[index]["NEG_LUGAR"]),
                            padding: EdgeInsets.all(
                                1.0)),



                      ]),
                ],

              ),

            ),

          ),

          onTap: () {
            String id_n = data_list[index]["ID_NEGOCIO"];
            String id = data_list[index]["ID_PUBLICACION"];
            String nom = data_list[index]["NEG_NOMBRE"];
            String lug = data_list[index]["NEG_LUGAR"];
            String cat = data_list[index]["CAT_NOMBRE"];
            String sub = data_list[index]["SUB_NOMBRE"];
            String gal = data_list[index]["GAL_FOTO"];
            String tit = data_list[index]["PUB_TITULO"];
            String det = data_list[index]["PUB_DETALLE"];
            String fec = data_list[index]["PUB_FECHA"];
            String vid = data_list[index]["PUB_VIDEO"];









            Navigator.push(context, new MaterialPageRoute
              (builder: (context) => new Publicacion_detalle_fin(
              publicacion: new Publicacion(id_n,id,nom,lug,cat,sub,gal,tit,det,fec,vid),
            )
            )
            );


          },
          //A Navigator is a widget that manages a set of child widgets with
          //stack discipline.It allows us navigate pages.
          //stack discipline.It allows us navigate pages.
          //Navigator.of(context).push(route);
        );

      },
    ),
  );




    return new Scaffold(

      body: ListView(
        //shrinkWrap: true,
       // physics: BouncingScrollPhysics(),
          children: [
            Column(

              children: <Widget>[
                Image.network( widget.empresa.logo,width: MediaQuery.of(context).size.width,height: 300,fit: BoxFit.cover ),
                //Image.asset('android/assets/images/img1.jpg',width: 600,height: 240,fit: BoxFit.cover,),
                //loading,
                titleSection,
                textSection,
                buttonSection,
                mapSection,

                


              ],
            ),
            Container(
              child: carrusel,
              height: 300.0,

            ),
            Container(
              child: publicaciones,
                height: MediaQuery.of(context).size.height + 100.0,

            )


          ],
        ),

        appBar: new AppBar(
          title: new Text( widget.empresa.nombre),
        ),

    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

 
}