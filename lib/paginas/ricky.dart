import 'dart:async';
import 'dart:convert';
import 'package:cabofind/paginas/ricky_detalle_general.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;



class Rickys extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<Rickys> {
  final fromTextController = TextEditingController();
  List<String> currencies;
  String fromCurrency = "USD";
  String toCurrency = "MXN";
  String multi;
  String result;

  Icon actionIcon = new Icon(Icons.search);

  Widget appBarTitle = new Text("Cabofind");
  int id = 0;

  List data;

  //final List<Todo> todos;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/estructura_ricky.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  /*
  //Registro descarga en iOS
  @override
    Future<String> checkModelIos() async {
    String currentLocale;
    try {
      currentLocale = await Devicelocale.currentLocale;
      print(currentLocale);
    } on PlatformException {
      print("Error obtaining current locale");
    }
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    //print('Running on ${iosInfo.identifierForVendor}');
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/insertInfoiOS.php?MOD=${iosInfo.model}&BOOT=${iosInfo.utsname.nodename}&VERSION=${iosInfo.systemName}&IDIOMA=${currentLocale}"),

        headers: {
          "Accept": "application/json"
        }
    );

  }
*/

/*
    _getLocation() async
      {
        Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        debugPrint('location: ${position.latitude}');
        final coordinates = new Coordinates(position.latitude, position.longitude);
        var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var first = addresses.first;
        print("${first.featureName} : ${first.addressLine}");
      }
*/
  //final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    //addStringToSF();

    super.initState();

    //fcmSubscribe();

    //setupNotification();
    this.getData();

    final _mensajesStreamController = StreamController<String>.broadcast();

    dispose() {
      _mensajesStreamController?.close();
    }

    //this.checkModelIos();
    //this.checkModelAndroid();
    ///this._getLocation();
  }

  Widget build(BuildContext context) {
    //_alertCar(BuildContext context) async {
    alertCar(context) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type AlertDialog
          return AlertDialog(
            title: new Text("AlertDialog Class"),
            content: new Text(
                "Creates an alert dialog.Typically used in conjunction with showDialog." +
                    "The contentPadding must not be null. The titlePadding defaults to null, which implies a default."),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    /*
    return new MaterialApp(
      navigatorKey: navigatorKey,

      routes: {
        'publicacionx' : (BuildContext context) => Publicacion_detalle_fin_push(),
      },
        debugShowCheckedModeBanner:false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          //primaryColor: Colors.black
          primaryColor: Colors.black,
          accentColor: Colors.black26,
        ),
        home: new Container(
            child:           new MyHomePages()
        )



    );
    */
    // new Publicaciones();

    /*
routes: <String, WidgetBuilder>{
          "/inicio" : (BuildContext context) => data[index]["est_navegacion"],
         
        };
*/

    return Scaffold(
      appBar: AppBar(
        title: Text("RICKYS CORNER"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          new StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) => new Container(
              //color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.black,
                    )),
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.all(10.0),
                child: InkWell(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: FadeInImage(
                                image:
                                    NetworkImage(data[index]["EST_RICKY_FOTO"]),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                //height: MediaQuery.of(context).size.height * 0.38,
                                height: MediaQuery.of(context).size.height,
                                // placeholder: AssetImage('android/assets/images/loading.gif'),
                                placeholder: AssetImage(
                                    'android/assets/images/loading.gif'),
                                fadeInDuration: Duration(milliseconds: 200),
                              ),
                            ),
                            Positioned(
                              child: Center(
                                child: new Text(data[index]["EST_RICKY_NOMBRE"],
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w900,
                                        backgroundColor: Colors.black45)),
                              ),
                            ),
                          ],
                        ),
                      ),

/*
                  Row(
                      children: <Widget>[


                        Padding(
                            child: new Text(
                              data[index]["NEG_NOMBRE"],
                              overflow: TextOverflow.ellipsis,),
                            padding: EdgeInsets.all(
                                1.0)),
                        Text(
                            " | "),
                        Flexible(
                          child: new Text(
                            data[index]["CIU_NOMBRE"],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,),


                        ),



                      ]),
*/
                    ],
                  ),
                  onTap: () {
                    String ruta = data[index]["EST_RICKY_NAVEGACION"];
                    String id = data[index]["EST_RICKY_ID"];

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Ricky_general(empresa: new Empresa(id))));
                  },
                ),
              ),
            ),
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(2, index.isEven ? 2 : 2),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
