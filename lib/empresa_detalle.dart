import 'dart:async';
import 'dart:convert';
import 'package:cabofind/list_bares.dart';
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
  }

}



class Empresa_det_fin extends StatelessWidget {
  List data;

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
          //new ListaBares(),
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
         // onPressed: () => _displayDialog(context),
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
           // new ListaBares(),

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