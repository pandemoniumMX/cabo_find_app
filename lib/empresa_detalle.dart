import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cabofind/listado_test.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:url_launcher/url_launcher.dart';

class Empresa_detalle extends StatefulWidget {
  
@override
_Empresa_detalle createState() => new _Empresa_detalle();
}

<<<<<<< HEAD
class _Empresa_detalle extends State<Empresa_detalle> {
 final Person person;

  // In the constructor, require a Person
  _Empresa_detalle({Key key, @required this.person}) : super(
      key: key);
  
  List data;

  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/list_vida_bares.php?='${person.nombre}'"),
        // "https://cabofind.com.mx/app_php/get_slider.php"),

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

    print(
        data[2]["GAL_FOTO"]);

    return "Success!";
  }

  @override
  void initState() {
    super.initState(
    );
    this.getData(
    );
  }
  Widget loading = Center(
    child: new CircularProgressIndicator(),

  );



  Widget build(BuildContext context) {

    return new Scaffold(

      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {

          return new ListTile(


            title: new Card(

              elevation: 5.0,
              child: new Container(


                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.orange)),
                padding: EdgeInsets.all(
                    20.0),
                margin: EdgeInsets.all(
                    20.0),

                child: Column(

                  children: <Widget>[

                    Padding(

                      child: Image.network(

                          data[index]["GAL_FOTO"]
                      ),
                      padding: EdgeInsets.only(
                          bottom: 8.0),
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
                        ]),
                  ],

                ),

              ),

            ),

            onTap: () {
              String nombre_sql = data[index]["NEG_NOMBRE"];
              String cat_sql = data[index]["CAT_NOMBRE"];
              String subcat_sql = data[index]["SUB_NOMBRE"];
              String foto_sql = data[index]["GAL_FOTO"];
              String etiquetas_sql = data[index]["NEG_ETIQUETAS"];
              String desc_sql = data[index]["NEG_DESCRIPCION"];
              String mapa_sql = data[index]["NEG_MAP"];




              Navigator.push(context, new MaterialPageRoute
                (builder: (context) => new Empresa_det_fin(person: new Person(nombre_sql,cat_sql,subcat_sql,foto_sql,etiquetas_sql,desc_sql,mapa_sql))
              )
              );

            },
            //A Navigator is a widget that manages a set of child widgets with
            //stack discipline.It allows us navigate pages.
            //Navigator.of(context).push(route);
          );

        },
      ),

    );
  }
@override
Widget build(BuildContext context) { 
 
}
}
=======

class _Empresa_detalle extends State<Empresa_detalle> {
  String url = 'https://randomuser.me/api/?results=15';
  List data;
  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var extractdata = json.decode(response.body);
      data = extractdata["results"];
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
  void initState() {
    this.makeRequest();
  }
}


>>>>>>> 098eba4f9351fb60c092ffb066040acbc1e7c46a





class Empresa_det_fin extends StatelessWidget {
  List data;

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
  final Person person;

  // In the constructor, require a Person
  Empresa_det_fin({Key key, @required this.person}) : super(
      key: key);



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
      padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
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
        children: [RaisedButton(
          child: Text('Mostrar caracteristicas'),
          color: Colors.red,
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


    Widget loading = Center(
      child: new CircularProgressIndicator(),

    );
    return new Scaffold(

        body: ListView(
          children: [
            Image.network('${person.logo}',width: 400,height: 300, ),
            //Image.asset('android/assets/images/img1.jpg',width: 600,height: 240,fit: BoxFit.cover,),
            //loading,
            titleSection,
            textSection,
            mapSection,
            textServicios,
            buttonSection,
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
