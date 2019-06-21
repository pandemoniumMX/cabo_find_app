import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/paginas_listas/list_publicaciones.dart';
//import 'package:custom_chewie/custom_chewie.dart';
import 'package:http/http.dart' as http;
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/*
class Publicacion_detalle extends StatelessWidget {

   List data;
   final Publicacion publicacion;
   final Empresa empresa;

  Publicacion_detalle({Key key, @required this.publicacion, this.empresa}) : super(key: key);              



  @override  
  Widget build(BuildContext context) {

              var nom ='${publicacion.nombre}';
              var neg ='${publicacion.neg}';
              var cat ='${publicacion.cat}';
              var sub ='${publicacion.subs}';
              var gal ='${publicacion.logo}';
              var tit ='${publicacion.titulo}';
              var det ='${publicacion.det}';
              var fec ='${publicacion.fec}';

              var nombre_n = '${empresa.nombre}';
              var cat_n = '${empresa.cat}';
              var sub_n = '${empresa.subs}';
              var log_n = '${empresa.logo}';
              var eti_n = '${empresa.etiquetas}';
              var desc_n = '${empresa.desc}';
              var map_n = '${empresa.maps}';



              return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Publicacion_detalle_fin(publicacion: Publicacion(nom,neg,cat,sub,gal,tit,det,fec), empresa: Empresa(nombre_n, cat_n, sub_n, log_n, eti_n, desc_n, map_n))


    );
  }
}
*/

class Publicacion_detalle_fin extends StatefulWidget {

  List data;
 final Publicacion publicacion;
  final Empresa empresa;
  Publicacion_detalle_fin({Key key, @required this.publicacion, this.empresa}) : super(
      key: key);





  @override

  _Publicacion_detalles createState() => new _Publicacion_detalles();
}

class _Publicacion_detalles extends State<Publicacion_detalle_fin> {
  List data;

  YoutubePlayerController _controller = YoutubePlayerController();
  var _idController = TextEditingController();
  var _seekToController = TextEditingController();
  double _volume = 100;
  bool _muted = false;
  String _playerStatus = "";
  String _errorCode = '0';

  String _videoId = "64t3a2qV_rg";

  void listener() {

    setState(() {
      _playerStatus = _controller.value.playerState.toString();
      _errorCode = _controller.value.errorCode.toString();
      print(_controller.value.toString());
    });
  }

  @override
  void deactivate() {
    // This pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }
  Widget setupAlertDialoadContainer() {

    return Container(
        height: 300.0, // Change as per your requirement
        width: 300.0,
        child: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, i) {
              return new ListTile(
                title: new Text(data[i]["name"]),
              );
            }
        )
    );
  }

  // Declare a field that holds the Person data
  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Lista de caracteristicas'),
            content: setupAlertDialoadContainer()

          );
        });
  }
  // Declare a field that holds the Person data




  @override

 Widget build(BuildContext context){
   
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Center(
                  child: Text(
                    widget.publicacion.titulo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        fontSize: 25.0

                    ),
                  ),

                ),

                Center(
                //  padding: const EdgeInsets.only(bottom: 10,left: 150.0),
                  child: Text(
                    widget.publicacion.cat,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      color: Color(0xff2E85DC)

                    ),
                  ),

                ),
             

              ],
            ),
          ),
          /*3*/

          
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget textSection = Card(
      child: Container(

        padding: const EdgeInsets.only(left:20.0,bottom: 20.0,),
        child: Text(
                    widget.publicacion.det,
          //softWrap: true,
          style: TextStyle(fontSize: 20.0,

          ),
        ),
        
      ),


    );

 Widget video = Container(
      child:
      Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Center(child: Text('Video promocional',style: TextStyle(fontSize: 23.0,color: Colors.blueAccent ),)),
        SizedBox(
            height: 20.0,
          ),
          YoutubePlayer(
            context: context,
            videoId: _videoId,
            autoPlay: true,
            showVideoProgressIndicator: true,
            videoProgressIndicatorColor: Colors.amber,
            progressColors: ProgressColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
            onPlayerInitialized: (controller) {
              _controller = controller;
              _controller.addListener(listener);
            },
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
                       
        
      
        
    );
    

    Widget boton = Container(
      padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
      child: RaisedButton(

        //child: Text(‘Send data to the second page’),
        onPressed: () {
          
              var nombre = widget.empresa.nombre;
              var cat = widget.empresa.cat;
              var subs = widget.empresa.subs;
              var logo = widget.empresa.logo;
              var etiquetas = widget.empresa.etiquetas;
              var desc = widget.empresa.desc;
              var maps = widget.empresa.maps;

//print('$empresa.desc');


          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new Empresa_det_fin(empresa: Empresa(nombre, cat, subs, logo, etiquetas, desc, maps)),

            )
          );
        },
        
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
        color: Colors.blue,
        child: Text('Más informacion', style: TextStyle(fontSize: 20, color: Colors.white)),

      ),

    );


    return new Scaffold(

        body: ListView(
          //scrollDirection: Axis.horizontal,
          children: [
            Image.network(widget.publicacion.logo
,width: MediaQuery.of(context).size.width,height: 300,fit: BoxFit.fill ),
            //Image.asset('android/assets/images/img1.jpg',width: 600,height: 240,fit: BoxFit.cover,),
            //loading,
            titleSection,
            textSection,
            video,
            boton,



          ],
        ),
        appBar: new AppBar(
          title: new Text(widget.publicacion.nombre,
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0

    ),

        ),

    )
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
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
    State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

  
  



