import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:cabofind/paginas/publicacion_detalle_estatica.dart';
import 'package:cabofind/utilidades/carousel_pro.dart';
import 'package:http/http.dart' as http;
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Empresa_det_fin_ing extends StatefulWidget {
List data;
//final Publicacion publicacion;
final Empresa empresa;

  Empresa_det_fin_ing({Key key, @required this.empresa}) : super(
    key: key);

@override
_Empresa_det_fin_ing createState() => new _Empresa_det_fin_ing();

}

class _Empresa_det_fin_ing extends State<Empresa_det_fin_ing> {
  ScrollController _scrollController = new ScrollController();

  List data;
  List data1;
  List data_list;
  List data_carrusel;
  List data_hor;








  Future<String> getCar() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/ing/list_caracteristicas_api.php?ID=${widget.empresa.id_nm}"),



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


  Future<String> getSer() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/ing/list_servicios_api.php?ID=${widget.empresa.id_nm}"),



        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
              data1 = json.decode(
              response.body);
        });
    print(
        data1[0]["SERV_NOMBRE"]);

    return "Success!";
  }



  Future<String> get_list() async {
    var response = await http.get(
        Uri.encodeFull(
         "http://cabofind.com.mx/app_php/APIs/ing/list_publicaciones_api.php?ID=${widget.empresa.id_nm}"),


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
        data_list[0]["NEG_LUGAR"]);

    return "Success!";
  }

   Future<String> getCarrusel() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/galeria_api.php?ID=${widget.empresa.id_nm}"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          data_carrusel = json.decode(
              response.body);
        });


    print(
        data_carrusel[2]["GAL_FOTO"]);

    return "Success!";
  }

  Future<String> getHorarios() async {
    var response = await http.get(
        Uri.encodeFull(
          //"http://cabofind.com.mx/app_php/list_caracteristicas_api.php?ID=${widget.empresa.id}"),
            "http://cabofind.com.mx/app_php/APIs/ing/list_horarios_api.php?ID=${widget.empresa.id_nm}"),
        //"http://cabofind.com.mx/app_php/list_caracteristicas.php"),



        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          data_hor = json.decode(
              response.body);
        });
    print(
        data_hor[0]["NEG_HORARIO_ING"]);

    return "Success!";
  }

  void initState() {
    super.initState(

    );
    this.getCar();
    this.get_list();
    this.getSer();
    this.getCarrusel();
    this.getHorarios();

  }

 Widget build(BuildContext context){

   _alertCar(BuildContext context) async {
     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Feactures',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: double.maxFinite,
                 height: 300.0,
                 child: ListView.builder(
                     itemCount: data == null ? 0 : data.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: <Widget>[
                           Container(child: Text(data[index]["CAR_NOMBRE_ING"],style: TextStyle(),),padding: EdgeInsets.only(bottom:15.0),) ,
                         ],
                       );
                     }
                 )
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


   _alertSer(BuildContext context) async {
     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Services',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: double.maxFinite,
                 height: 300.0,
                 child: ListView.builder(
                     itemCount: data1 == null ? 0 : data1.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: <Widget>[
                           Container(child: Text(data1[index]["SERV_NOMBRE_ING"],style: TextStyle(),),padding: EdgeInsets.only(bottom:15.0),) ,
                         ],
                       );
                     }
                 )
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

   _alertHorario(BuildContext context) async {
     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Schedules',style: TextStyle(fontSize: 25.0,),),
             content: Container(

                 child: Container(child: Text(data_hor[0]["NEG_HORARIO_ING"],style: TextStyle(),)
                 )
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

  Widget carrusel =   Container(
     child: new ListView.builder(

       scrollDirection: Axis.horizontal,

       itemCount: data_carrusel == null ? 0 : data_carrusel.length,
       itemBuilder: (BuildContext context, int index) {

         return  new Container(
           padding: EdgeInsets.only( left: 0.0, right: 10.0),
           child: Column(
             children: <Widget>[
               Padding(
                 child:  FadeInImage(

                   image: NetworkImage(data_carrusel[index]["GAL_FOTO"]),
                   fit: BoxFit.cover,
                   width: MediaQuery.of(context).size.width,
                   height: 400,

                   // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                   placeholder: AssetImage('android/assets/images/loading.gif'),
                   fadeInDuration: Duration(milliseconds: 200),

                 ),
                 padding: EdgeInsets.all(0.0),
               ),
             ],
           ),
         );
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



   Widget buttonSection = Container(
     width: MediaQuery.of(context).size.width +30,

     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.feather), onPressed:() => _alertCar(context),backgroundColor:Color(0xff189bd3),heroTag: "bt1",),
             Text('Feactures', style: TextStyle(color: Colors.black),),
           ],
         ),

         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.conciergeBell), onPressed:() => _alertSer(context),backgroundColor:Color(0xff189bd3),heroTag: "bt2",),
             Text('Services', style: TextStyle(color: Colors.black),),

           ],
         ),
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.clock), onPressed:() => _alertHorario(context),backgroundColor:Color(0xff189bd3),heroTag: "bt3",),
             Text('Schedules', style: TextStyle(color: Colors.black),),

           ],
         ),
         Column(
           children: <Widget>[
             FloatingActionButton(child: Icon(FontAwesomeIcons.mapMarkedAlt), onPressed:mapa,backgroundColor:Color(0xff189bd3),heroTag: "bt4",),
             Text('Open map', style: TextStyle(color: Colors.black),),

           ],
         ),
       ],
     ),

   );

facebook() async {
    final url =  widget.empresa.fb;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  web() async {
    final url =  widget.empresa.web;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  instagram() async {
    final url =  widget.empresa.inst;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

   telefono() async {
     final url =  "tel:${widget.empresa.tel}";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

   correo() async {
     final url =  "mailto:${widget.empresa.cor}";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

  Widget social(){
     return Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
         SizedBox(width: 30),
         FloatingActionButton(child: Icon(FontAwesomeIcons.instagram), onPressed: instagram,backgroundColor:Color(0xff189bd3),heroTag: "bt1",),
         Expanded(child: SizedBox(width: 5.0,)),
         FloatingActionButton(child: Icon(FontAwesomeIcons.facebook), onPressed: facebook,backgroundColor:Color(0xff189bd3),heroTag: "bt3",),
         Expanded(child: SizedBox(width: 5.0,)),
         FloatingActionButton(child: Icon(FontAwesomeIcons.globeAmericas), onPressed: web,backgroundColor:Color(0xff189bd3),heroTag: "bt4",),
         Expanded(child: SizedBox(width: 5.0,)),
         FloatingActionButton(child: Icon(FontAwesomeIcons.phone), onPressed: telefono,backgroundColor:Color(0xff189bd3),heroTag: "bt5",),
         Expanded(child: SizedBox(width: 5.0,)),
         FloatingActionButton(child: Icon(FontAwesomeIcons.envelope), onPressed: correo,backgroundColor:Color(0xff189bd3),heroTag: "bt6W",),
         Expanded(child: SizedBox(width: 5.0,)),

       ],
     );
   }

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

                        data_list[index]["PUB_TITULO_ING"],
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

                                data_list[index]["CAT_NOMBRE_ING"]),
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
            String cat = data_list[index]["CAT_NOMBRE_ING"];
            String sub = data_list[index]["SUB_NOMBRE_ING"];
            String gal = data_list[index]["GAL_FOTO"];
            String tit = data_list[index]["PUB_TITULO_ING"];
            String det = data_list[index]["PUB_DETALLE_ING"];
            String fec = data_list[index]["PUB_FECHA"];
            String vid = data_list[index]["PUB_VIDEO"];
            String tel = data_list[index]["NEG_TEL"];
            String cor = data_list[index]["NEG_CORREO"];

            Navigator.push(context, new MaterialPageRoute
              (builder: (context) => new Publicacion_detalle_fin_estatica(
              publicacion: new Publicacion(id_n,id,nom,lug,cat,sub,gal,tit,det,fec,vid,tel,cor),
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

                


              ],
            ),
            Container(
              child: carrusel,
              height: 400.0,

            ),

            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                 Center(child: Text('Social networks and contact',style: TextStyle(fontSize: 20.0,color: Colors.blueAccent ),)),
                  SizedBox(
                    height: 15.0,
                  ),
                 social(),

                ],
              )

            ),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(child: Text('Posts ${widget.empresa.nombre}',style: TextStyle(fontSize: 20.0,color: Colors.blueAccent ),)),
                ],
              ),
              height: 50.0,

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