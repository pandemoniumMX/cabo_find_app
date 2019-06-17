import 'dart:async';
import 'dart:convert';
import 'package:cabofind/carousel_pro.dart';
import 'package:cabofind/carrusel.dart';
import 'package:cabofind/list_antros.dart';
import 'package:cabofind/listado_backup.dart';
import 'package:cabofind/main.dart';
import 'package:custom_chewie/custom_chewie.dart';
import 'package:http/http.dart' as http;
import 'package:cabofind/classes.dart';

import 'package:video_player/video_player.dart';
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
/*
Future<Post> fetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

void main() => runApp(Empresa_det_fin(post: fetchPost()));
*/
class Empresa_det_fin extends StatelessWidget {


  //MyApp({Key key, this.post}) : super(key: key);

  List data;
  List data1;

  final Empresa empresa;
   Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/fotos1.php"),
       
        headers: {
          "Accept": "application/json"
        }
    );




    print(
        data1[1]["ID_GALERIA"]);

    return "Success!";
  }
  // In the constructor, require a Person
  Empresa_det_fin({Key key, @required this.empresa,this.data1}) : super(
      key: key);
/*
  Future<List<User>> _getUsers() async {
    var data= await http.get("http://cabofind.com.mx/app_php/get_slider.php");

    var jsonData = json.decode(data.body);

    List <User> users =[];
    for(var u in jsonData){
      User user = User(u["NEG_NOMBRE"], u["GAL_FOTO"]);
      users.add(user);
    }
    print(users.length);

    return users;
  }
*/


  @override

  _alertSer(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Servicios'),
            content: Container(
              width: double.maxFinite,
              height: 300.0,
              child: ListView(
                padding: EdgeInsets.all(8.0),
                //map List of our data to the ListView
                children: _ListCaracteristicas.map((data) => Text(data)).toList(),
              ),
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
              child: ListView(
                padding: EdgeInsets.all(8.0),
                //map List of our data to the ListView
                children: _ListServicios.map((data) => Text(data)).toList(),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  List<String> _ListServicios = [
    'Cerveza',
    'Desayunos, comidas y cenas',
    'Promociones',
    'Platillos preparados al gusto',
  ];

  List<String> _ListCaracteristicas = [
    'Aire acondicionado',
    'Ballete parking',
    'Wifi',
    'Espacio para mascotas',
    'Servicio a domicilio',
  ];

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

              Image.network("${snapshot.data.author}"),

             
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
/*
  Widget galeria = Container(

  child: FutureBuilder<Quote>(
        future: getQuote(), //sets the getQuote method as the expected Future
        builder: (context, snapshot) {
          if (snapshot.hasData) { //checks if the response returns valid data
            return ListView.builder(

              //scrollDirection: Axis.horizontal,

              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {

                return  new Container(
                  padding: EdgeInsets.only( left: 5.0, right: 1.0),
                  child: Column(
                    children: <Widget>[
                      FadeInImage(
                        image: NetworkImage("${snapshot.data.author}"),
                         fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                          height: 220,

                          // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                          placeholder: AssetImage('android/assets/images/loading.gif'),
                          fadeInDuration: Duration(milliseconds: 200),
                        
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) { //checks if the response throws an error
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),

    );
*/
    
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
                  '${empresa.nombre}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                      fontSize: 20.0
                  ),
                ),

              

            ],
          ),
          Column(children: <Widget>[
                Text(
                '${empresa.cat}-${empresa.subs}',
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
/*
    Widget galeria2 =  Container(
      margin: const EdgeInsets.all(10.0),
      color: Colors.amber[600],
      width: 100.0,
      height: 100.0,
      child:  ListView.builder(

        scrollDirection: Axis.horizontal,

        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {

          return  new Container(
            padding: EdgeInsets.only( left: 5.0, right: 1.0),
            child: Column(
              children: <Widget>[
                Padding(
                  child: Image.network(
                    data[index]["GAL_FOTO"],
                    fit: BoxFit.cover,
                    height: 300.0,
                    width: 300.0,
                  ),
                  padding: EdgeInsets.all(0.0),
                ),
              ],
            ),
          );
        },
      ),
    );
    
    Widget test = Container(
      child: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),

    );

*/




    Widget textSection = Container(
      padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
      child: Card(
              child: Text(
          '${empresa.desc}',
          maxLines: 10,
          softWrap: true,
          textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
        ),
      ),

    );
    mapa() async {
      final url = '${empresa.maps}';
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





    return new Scaffold(

      body: ListView(
        //shrinkWrap: true,
       // physics: BouncingScrollPhysics(),
          children: [
            Column(

              children: <Widget>[
                Image.network('${empresa.logo}',width: MediaQuery.of(context).size.width,height: 300,fit: BoxFit.cover ),
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


          ],
        ),

        appBar: new AppBar(
          title: new Text('${empresa.nombre}'),
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

  @override

  State<StatefulWidget> createState() {

    // TODO: implement createState

    return null;
  }
}