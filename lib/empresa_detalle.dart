import 'dart:async';
import 'dart:convert';
import 'package:cabofind/list_antros.dart';
import 'package:cabofind/listado_backup.dart';
import 'package:cabofind/main.dart';
import 'package:custom_chewie/custom_chewie.dart';
import 'package:http/http.dart' as http;
import 'package:cabofind/classes.dart';

import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Empresa_detalle extends StatefulWidget {

@override
_Empresa_detalle createState() => new _Empresa_detalle();


}
List data;

class _Empresa_detalle extends State<Empresa_detalle> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
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



class Empresa_det_fin extends StatelessWidget {
  List data;

  final Empresa empresa;

  // In the constructor, require a Person
  Empresa_det_fin({Key key, @required this.empresa}) : super(
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

    Widget carrusel =   Container(
     child: new ListView.builder(

       scrollDirection: Axis.horizontal,

       itemCount: data == null ? 0 : data.length,
       itemBuilder: (BuildContext context, int index) {

         return  new Container(
           padding: EdgeInsets.only( left: 5.0, right: 1.0),
        //   width: MediaQuery.of(context).size.width,
          // height:MediaQuery.of(context).size.height,
           child: Column(
             children: <Widget>[
               Padding(
                 child: Image.network(
                   data[index]["GAL_FOTO"],
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




   Widget video = Container(

     decoration: BoxDecoration(
         border: Border.all(
             color: Colors.blue)),
     child: FutureBuilder<Quote>(
       //data == null ? 0 : data.length,

       future: getQuote(),
       //sets the getQuote method as the expected Future
       builder: (context, snapshot) {
         if (snapshot.hasData) { //checks if the response returns valid data
           return Center(
             child: Column(
               children: <Widget>[
                 Text(
                 'Video',
                   style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 25.0
                   ),
                 ), //displays the quote
                 SizedBox(
                   height: 0.0,
                 ),
             Chewie(
               new VideoPlayerController.network(
                   'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4'
               ),
               aspectRatio: 3 / 2,
               autoPlay: true,
               looping: false,
               // showControls: false,
                materialProgressColors: ChewieProgressColors(
                 playedColor: Colors.red,
                handleColor: Colors.blue,
                  backgroundColor: Colors.grey,
                  bufferedColor: Colors.lightGreen,
                ),
               // placeholder: Container(
               //   color: Colors.grey,
               // ),
               // autoInitialize: true,

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
          ],)

          
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
        '${empresa.desc}',
        maxLines: 10,
        softWrap: true,
        textAlign: TextAlign.center,
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
      child: RaisedButton(
        textColor: Colors.white,
        color: Colors.green,
        onPressed: mapa,
        child: Text('Abrir Mapa'),
      ),
    );


    Widget buttonSection = Container(
      width: MediaQuery.of(context).size.width +30,

      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.blue)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton(
          child: Text('Cracteristicas'),
          color: Colors.pinkAccent,
         onPressed: () => _displayDialog(context),
        ),
          RaisedButton(
            child: Text('Servicios'),
            color: Colors.yellow,
            onPressed: () => _displayDialog(context),
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

              child: slider,
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