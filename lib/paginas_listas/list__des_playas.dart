 import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/carrusel.dart';
import 'package:cabofind/main.dart';
import 'package:http/http.dart' as http;
import 'package:cabofind/utilidades/carousel_pro.dart';
import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(new MaterialApp(
    home: new ListaPlayas(),

  ));
}

class ListaPlayas extends StatefulWidget {
  @override
  _ListaAcuaticas createState() => new _ListaAcuaticas();

}

class _ListaAcuaticas extends State<ListaPlayas> {

  List data;

  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/descubre/list_descubre_playas.php"),
       
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
        data[1]["NEG_NOMBRE"]);


    return "Success!";
  }

  @override
  void initState() {
    super.initState(
    );
    this.getData(
    );
  }
  @override
void dispose() {
 // _audioPlayer?.dipose();
  super.dispose();
}
  




  Widget build(BuildContext context) {

    Widget listado = ListView.builder(
       shrinkWrap: true,
      physics: BouncingScrollPhysics(),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {

          return new ListTile(


            title: new Card(

              elevation: 5.0,
              child: new Container(


                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10.0),
                    border: Border.all(
                        color: Colors.lightBlueAccent)
                ),
                padding: EdgeInsets.all(
                    10.0),
                margin: EdgeInsets.all(
                    10.0),

                child: Column(

                  children: <Widget>[

                    FadeInImage(

                      image: NetworkImage(data[index]["GAL_FOTO"]),
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: 220,

                      // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                      placeholder: AssetImage('android/assets/images/loading.gif'),
                      fadeInDuration: Duration(milliseconds: 200),

                    ),
                    Row(
                        children: <Widget>[

                          Padding(

                              child: Text(

                                  data[index]["SUB_NOMBRE"]),
                              padding: EdgeInsets.all(
                                  1.0)),
                          Text(
                              " | "),
                          Padding(
                              child: new Text(
                                  data[index]["NEG_NOMBRE"]),
                              padding: EdgeInsets.all(
                                  1.0)),
                          Text(
                              " | "),
                          Padding(
                              child: new Text(
                                  data[index]["NEG_LUGAR"]),
                              padding: EdgeInsets.all(
                                  1.0)),

                        ]),
                  ],

                ),

              ),

            ),

            onTap: () {
              String id_sql = data[index]["ID_NEGOCIO"];
              String nombre_sql = data[index]["NEG_NOMBRE"];
              String cat_sql = data[index]["CAT_NOMBRE"];
              String subcat_sql = data[index]["SUB_NOMBRE"];
              String foto_sql = data[index]["GAL_FOTO"];
              String etiquetas_sql = data[index]["NEG_ETIQUETAS"];
              String desc_sql = data[index]["NEG_DESCRIPCION"];
              String mapa_sql = data[index]["NEG_MAP"];
              String fb_sql = data[index]["NEG_FACEBOOK"];
              String ins_sql = data[index]["NEG_INSTAGRAM"];
              String web_sql = data[index]["NEG_WEB"];
              String tel = data[index]["NEG_TEL"];
              String cor = data[index]["NEG_CORREO"];




              Navigator.push(context, new MaterialPageRoute
                (builder: (context) => new Empresa_det_fin(empresa: new Empresa(id_sql,nombre_sql,cat_sql,subcat_sql,foto_sql,etiquetas_sql,desc_sql,mapa_sql,fb_sql,ins_sql,web_sql,tel,cor))
              )
              );

            },
            //A Navigator is a widget that manages a set of child widgets with
            //stack discipline.It allows us navigate pages.
            //Navigator.of(context).push(route);
          );

        },

    );
    return new Scaffold(

        body: Container(

                child: new ListView(
                 // shrinkWrap: true,
                  //physics: BouncingScrollPhysics(),
                  children: [
                Column(
                children: <Widget>[
                 // slider,

                  ],
                ),
              Container(


                  child: listado,
                  height: MediaQuery.of(context).size.height -120

                // height: 550.0,

              ),
                  ],
          ),

        ),


    );






  }
}