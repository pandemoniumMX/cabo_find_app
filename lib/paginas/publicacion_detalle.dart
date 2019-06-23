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
  List datacar;
  List dataneg;


  YoutubePlayerController _controller = YoutubePlayerController();
  var _idController = TextEditingController();
  var _seekToController = TextEditingController();
  double _volume = 100;
  bool _muted = false;
  String _playerStatus = "";
  String _errorCode = '0';

  // String _videoId = widget.publicacion.det;

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
    //_controller.pause();
    super.deactivate();
  }
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/list_negocios.php?ID=${widget.publicacion.id_n}"),
          //"http://cabofind.com.mx/app_php/list_negocios.php?"),


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
        data[0]["NEG_DESCRIPCION"]);

    return "Success!";
  }

  Future<String> getNeg() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/list_negocios.php?ID=${widget.publicacion.id_n}"),
        //"http://cabofind.com.mx/app_php/list_negocios.php?"),


        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
              dataneg = json.decode(
              response.body);
        });
    print(
        dataneg[0]["NEG_NOMBRE"]);

    return "Success!";
  }



  @override
  void initState() {
    super.initState(

    );
    this.getData();
    this.getNeg();

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
            //videoId: widget.publicacion.vid,
            videoId: widget.publicacion.vid,
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

              String id_nm = dataneg[0]["ID_EMPRESA"];
              String nom = dataneg[0]["NEG_NOMBRE"];
              String cat = dataneg[0]["CAT_NOMBRE"];
              String sub = dataneg[0]["SUB_NOMBRE"];
              String gal = dataneg[0]["GAL_FOTO"];
              String eti = dataneg[0]["NEG_ETIQUETAS"];
              String des = dataneg[0]["NEG_DESCRIPCION"];
              String map = dataneg[0]["NEG_MAP"];


          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new Empresa_det_fin(empresa: Empresa(id_nm,nom, cat, sub, gal, eti, des, map)),

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
            //video,
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










