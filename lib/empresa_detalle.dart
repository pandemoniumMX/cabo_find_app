import 'dart:async';
import 'dart:convert';
import 'package:cabofind/listado_backup.dart';
import 'package:cabofind/main.dart';
import 'package:http/http.dart' as http;
import 'package:cabofind/listado_test.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Empresa_detalle extends StatefulWidget {

@override
_Empresa_detalle createState() => new _Empresa_detalle();

}
List data;

class _Empresa_detalle extends State<Empresa_detalle> {


  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/fotos.php"),
       
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
        data[2]["GAL_FOTO"]);

    return "Success!";
  }
  //galeria

  @override
  void initState() {
    super.initState(
    );
    this.getData(
    );
  }

  Widget build(BuildContext context) {

    return new Scaffold(

      body: new ListView.builder(
        scrollDirection: Axis.horizontal,

        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {

          return  new Container(
            padding: EdgeInsets.only( left: 5.0, right: 1.0),
            child: Column(
              children: <Widget>[

                Padding(
                  child: Image.network(
                    data[index]["GAL_FECHA"],
                    fit: BoxFit.cover,
                    height: 400.0,
                    width: 400.0,
                  ),
                  padding: EdgeInsets.all(0.0),
                ),
              ],
            ),
          );

        },
      ),

    );
  }

}

Future<Quote> getQuote() async {
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

class PhotosList {
  final List<Quote> photos;

  PhotosList({
    this.photos,
  });

  factory PhotosList.fromJson(List<dynamic> parsedJson) {

    List<Quote> photos = new List<Quote>();
    photos = parsedJson.map((i)=>Quote.fromJson(i)).toList();

    return new PhotosList(
        photos: photos
    );
  }
}


class Empresa_det_fin extends StatelessWidget {
  List data;

  final Person person;

  // In the constructor, require a Person
  Empresa_det_fin({Key key, @required this.person}) : super(
      key: key);

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

  @override

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('ListView in Dialog'),
            content: Container(
              width: double.maxFinite,
              height: 300.0,
              child: ListView(
                padding: EdgeInsets.all(8.0),
                //map List of our data to the ListView
                children: _listViewData.map((data) => Text(data)).toList(),
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
  List<String> _listViewData = [
    "A List View with many Text - Here's one!",
    "A List View with many Text - Here's another!",
    "A List View with many Text - Here's more!",
    "A List View with many Text - Here's more!",
    "A List View with many Text - Here's more!",
    "A List View with many Text - Here's more!",
    "A List View with many Text - Here's more!",
    "A List View with many Text - Here's more!",
    "A List View with many Text - Here's more!",
  ];
 Widget build(BuildContext context){

   Widget galeria = Container(

     child: FutureBuilder<Quote>(
       //data == null ? 0 : data.length,

       future: getQuote(), //sets the getQuote method as the expected Future
       builder: (context, snapshot) {
         if (snapshot.hasData) { //checks if the response returns valid data
           return Center(
             child: Column(
               children: <Widget>[
                 Text(snapshot.data.quote), //displays the quote
                 SizedBox(
                   height: 10.0,
                 ),
                 Padding(

                   child: Image.network(

                       "${snapshot.data.author}"                    ),
                   padding: EdgeInsets.all(
                       18.0),
                 ),
               ],
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
      padding: const EdgeInsets.all(32),
      child: Row(
        children:[
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    '${person.nombre}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        fontSize: 20.0
                    ),
                  ),

                ),
                Text(
                  '${person.cat}-${person.subs}',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),

              ],
            ),
          ),
          /*3*/

          Text(
            'Rango de precios:',
            style: TextStyle(
              color: Colors.blue[500],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('101'),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

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





    Widget textSection = Container(
      padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
      child: Text(
        '${person.desc}',
        softWrap: true,
      ),

    );
    mapa() async {
      final url = '${person.maps}';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    Widget mapSection = Container(
      padding: const EdgeInsets.only(bottom: 10,left: 125,right: 125),
      child: RaisedButton(
        textColor: Colors.white,
        color: Colors.green,
        onPressed: mapa,
        child: Text('Abrir Mapa'),
      ),
    );


    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton(
          child: Text('Mostrar caracteristicas'),
          color: Colors.pinkAccent,
         onPressed: () => _displayDialog(context),
        ),
          RaisedButton(
            child: Text('Mostrar servicios'),
            color: Colors.yellow,
            onPressed: () => _displayDialog(context),
          ),
        ],
      ),
    );



    Widget textServicios = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Servicios',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                    ),
                  ),

                ),


              ],
            ),
          ),

        ],
      ),
    );


    return new Scaffold(

      body: ListView(
          children: [
            Column(
              children: <Widget>[
                Image.network('${person.logo}',width: 400,height: 300, ),
                //Image.asset('android/assets/images/img1.jpg',width: 600,height: 240,fit: BoxFit.cover,),
                //loading,
                titleSection,
                textSection,
                mapSection,
                textServicios,
                buttonSection,
                galeria,

                galeria2,


              ],
            ),
            Container(

              child: slider,
              height: 300.0,

            ),
          ],
        ),

        appBar: new AppBar(
          title: new Text('Descubre'),
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