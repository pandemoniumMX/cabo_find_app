import 'dart:convert';
import 'package:cabofind/paginas/cupones_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Mis_promos_manejador_obtenidas extends StatefulWidget {
 
 
  @override
  _Mis_promos_manejador_obtenidasState createState() => _Mis_promos_manejador_obtenidasState();
}

class _Mis_promos_manejador_obtenidasState extends State<Mis_promos_manejador_obtenidas> {
  List data;


  Future<String> _loadUser() async {

 final SharedPreferences login = await SharedPreferences.getInstance();
 String _status = "";
 String _mail ="";
 String _mail2 ="";
String _idusu="";  _status = login.getString("stringLogin");
 _mail2 = login.getString("stringMail"); 
 
  

  var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_cupones_api.php?CORREO=$_mail2"),  
       
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          data = json.decode(
              response.body);
        });            
  
}

  void initState(){
  super.initState();
  this._loadUser();

  }
  @override
  Widget build(BuildContext context) {
    Widget estructura = ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
          return new ListTile(


            title: new Card(

              elevation: 5.0,
              child: new Container(
                child: Column(

                  children: <Widget>[
                    //Text("Texto",
                    Row(
                      mainAxisAlignment : MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        
                      FadeInImage(
                      image: NetworkImage(data[index]["GAL_FOTO"]),
                      fit: BoxFit.fill,
                      width:  MediaQuery.of(context).size.width * .20,
                      height: MediaQuery.of(context).size.height * .10,
                      placeholder: AssetImage('android/assets/images/loading.gif'),
                      fadeInDuration: Duration(milliseconds: 200),
                      ),  
                        Text(data[index]["REC_TITULO"],overflow: TextOverflow.ellipsis,softWrap: true,   
                        style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0, color: Colors.black,)),
                      Row(
                          children: [
                            Column(children: [

                        new Icon(FontAwesomeIcons.gift, color: Colors.orange,size: 20,), 
                        new Text('Obtenido',style: TextStyle(fontSize: 10),),
                        //new Text('necesarios',style: TextStyle(fontSize: 10),)
                            ],),
                            
                        
                      ],
                        ),

                      ],
                        


                    ),
                  ],

                ),

              ),

            ),

            onTap: () {
              
            String id_re = data[index]["ID_CUPONES"];
            String id_n = data[index]["negocios_ID_NEGOCIO"];

            print(id_re);
            print(id_n);
              Navigator.push(context, new MaterialPageRoute
                (builder: (context) => new Cupones_detalles(
              publicacion: new Publicacion(id_re,id_n),
            )));

            },
            
          );

        },

    );
    return  Scaffold(
      appBar: AppBar(title:Text('Regresar')),
      body: ListView(
        physics: BouncingScrollPhysics(),   
        //addAutomaticKeepAlives: true,
        children: [
      //  Text('data'),
        estructura
      ],)
    
    );
  }
}