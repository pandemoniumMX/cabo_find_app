import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/paginas_listas/list_publicaciones.dart';
import 'package:custom_chewie/custom_chewie.dart';
import 'package:http/http.dart' as http;
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class Publicacion_detalle extends StatefulWidget {
  
  




@override
  // In the constructor, require a Person



_Publicacion_detalle createState() => new _Publicacion_detalle();
}


class _Publicacion_detalle extends State<Publicacion_detalle> {
   List data;
    final Publicacion publicacion;
  final Empresa empresa;
  Publicacion_detalle({GlobalKey key, @required this.publicacion, this.empresa}) : super(
      key: key);
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
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    '${publicacion.titulo}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        fontSize: 20.0

                    ),
                  ),

                ),

                Center(
                //  padding: const EdgeInsets.only(bottom: 10,left: 150.0),
                  child: Text(
                    '${publicacion.cat}',
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
          '${publicacion.det}',
          //softWrap: true,
          style: TextStyle(fontSize: 20.0,

          ),
        ),
        
      ),


    );

     Widget video = Container(
      child:  Chewie(
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

    );
    

    Widget boton = Container(
      padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
      child: RaisedButton(

        //child: Text(‘Send data to the second page’),
        onPressed: () {
          
          //int id = '${empresa.id}';
          String nombre = '${empresa.nombre}';
          String cat = '${empresa.cat}';
          String subs = '${empresa.subs}';
          String logo = '${empresa.logo}';
          String etiquetas = '${empresa.etiquetas}';
          String desc = '${empresa.desc}';
          String maps = '${empresa.maps}';

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
            Image.network('${publicacion.logo}',width: MediaQuery.of(context).size.width,height: 300,fit: BoxFit.fill ),
            //Image.asset('android/assets/images/img1.jpg',width: 600,height: 240,fit: BoxFit.cover,),
            //loading,
            titleSection,
            textSection,
            boton,
            video,


          ],
        ),
        appBar: new AppBar(
          title: new Text(
    '${publicacion.nombre}',
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
  }

  
  



