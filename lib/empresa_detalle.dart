
import 'package:cabofind/listado_test.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Empresa_detalle extends StatefulWidget {
@override
_Empresa_detalle createState() => new _Empresa_detalle();
}


class _Empresa_detalle extends State<Empresa_detalle> {
@override
Widget build(BuildContext context) {
  final tabpages=<Widget>[
    //llamar classes siempre despues de un <Widget>
    //lo que se declare aqui, sera el contenido de los botones de navigacion al fondo
    // new ImageCarousel2(),
    //new ImageCarousel2(),

    //new Listviewx(),
    //new ImageCarousel2(),

    Center(child: Icon(Icons.map,size: 60.0,color: Colors.red,),),
    Center(child: Icon(Icons.mic,size: 60.0,color: Colors.red,),),
    Center(child: Icon(Icons.radio,size: 60.0,color: Colors.red,),),
    Center(child: Icon(Icons.music_video,size: 60.0,color: Colors.red,),),

  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.star,),title: Text("Actividades")),
    BottomNavigationBarItem(icon: Icon(Icons.favorite,),title: Text("Paseos")),
    BottomNavigationBarItem(icon: Icon(Icons.fiber_new,),title: Text("Cultura")),



  ];

  int id=0;

  final bnb=BottomNavigationBar(

    items: bnbi,
    currentIndex:id ,
    type: BottomNavigationBarType.fixed,
    onTap: (int value){
      setState(() {
        id=value;
      });
    },
  );

  return new Scaffold(
    body: tabpages[id],
    bottomNavigationBar: bnb,

  );
}
}

class Empresa_det_fin extends StatelessWidget {

  List<String> _listViewData = [
    "Área de niños",
    "Wifi",
    "Servicio a domicilio",
    "Aire acondicionado",

  ];
  // Declare a field that holds the Person data
  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Lista de caracteristicas'),
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
}
