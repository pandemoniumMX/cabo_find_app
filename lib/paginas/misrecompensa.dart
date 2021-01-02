import 'dart:convert';
import 'package:cabofind/paginas/list_manejador_rec_obtenidas.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:cabofind/utilidades/ruleta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'dados.dart';
import 'list_manejador_recompensas.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Mis_recompensas extends StatefulWidget {
  @override
  _Compras createState() => new _Compras();
}

class _Compras extends State<Mis_recompensas> {
  bool isLoggedIn = false;

  //final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  void initState() {
    //sesionLog();
    super.initState();
  }

  Future<bool> sesionLog() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    _status = login.getString("stringLogin") ?? '';
    _mail = login.getString("stringMail") ?? '';
    bool checkValue = login.containsKey('value');
    return checkValue = login.containsKey('stringLogin');

    if (_status == "True") {
      print("Sesión ya iniciada");
    } else {
      print("Sesión no iniciada");
    }
    http.Response response = await http.get("http://api.openrates.io/latest");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: FutureBuilder(
      future: sesionLog(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data
              ? Usuario(usuarios: new Users("testing@gmail.com"))
              : Login2();
        }
        return Login2(); // noop, this builder is called again when the future completes
      },
    ));
  }
}

class Usuario extends StatefulWidget {
  final Users usuarios;

  Usuario({Key key, @required this.usuarios}) : super(key: key);
  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {
  List data;
  DateFormat dateFormat;

  void initState() {
    super.initState();
    this._loadUser();
    dateFormat = new DateFormat.MMMMd('es');
  }

  Future<Map> _loaduserQR() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/list_userqr_api.php?IDF=$_mail2");
    return json.decode(response.body);
  }

  Future<Map> _loaduser2() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/list_recompensas_api2.php?IDF=$_mail2");
    return json.decode(response.body);
  }

  Future<Map> _loadUser() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_recompensas_api.php?IDF=$_mail2"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });
  }

  Future<String> deletefav(id_n) async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    _status = login.getString("stringLogin") ?? '';
    _mail = login.getString("stringMail") ?? '';

    if (_status == "True") {
      showFavorites();
    } else {
      //CircularProgressIndicator(value: 5.0,);

      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (BuildContext context) => Myapp1()));
    }
  }

  void showFavorites() {
    Fluttertoast.showToast(
      msg: "Borrado correctamente!",
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Color(0xffED393A),
      textColor: Colors.white,
    );
  }

  Future<Map> _cerrarsesion() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
//login.setString('stringLogin', "False");
    login.clear();
//login.setString('stringLogin', "True");
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) => new Myapp1()));
  }

  @override
  Widget build(BuildContext context) {
    _alertInstrucciones(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Instrucciones',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              content: Container(
                width: double.maxFinite,
                height: 200.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '1: Ve a uno de los comercios participantes.',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      '2: Compra producto/platillo/servicio',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      '3: Cuando pagues, pide que escaneé tu código QR.',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      '4: Obtendrás 100 puntos por tu visita (100 por negocio diario)',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      '5: Suma puntos y canjea por recompensas!',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      '6: Canjea tu rescompensa mostrando el QR al comercio participante',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Términos: Deberás tener algúna identificación oficial para el reclamo. Después de reclamar tu recompensa, tendrás 7 días para usarla. No podrás reclamar 2 veces la misma recompensa el mismo día.',
                      style: TextStyle(fontSize: 12),
                    ),

                    // Container(child: Text(data[index]["CAR_NOMBRE_ING"],style: TextStyle(),),padding: EdgeInsets.only(bottom:15.0),) ,
                  ],
                ),
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

    Widget tutorial = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RaisedButton(
            onPressed: () => _alertInstrucciones(context),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0)),
            color: Colors.black,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Icon(
                  FontAwesomeIcons.questionCircle,
                  color: Colors.white,
                ),
                new Text(' Instrucciones',
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              ],
            )),
        RaisedButton(
            onPressed: () {
              FlutterYoutube.playYoutubeVideoByUrl(
                  apiKey: "AIzaSyAmNDqJm2s5Fpualsl_VF6LhG733knN0BY",
                  videoUrl: 'https://www.youtube.com/watch?v=hsLSjImkf-c',
                  autoPlay: false, //default falase
                  fullScreen: false //default false
                  );
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0)),
            color: Colors.red,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Icon(
                  FontAwesomeIcons.youtube,
                  color: Colors.white,
                ),
                new Text('  Ver video',
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              ],
            )),
      ],
    );

    Widget miqr = Column(
      children: [
        FutureBuilder(
            future: _loaduserQR(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Error :(",
                      style: TextStyle(color: Colors.black, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    String _qrencryp = snapshot.data["ID_USUARIOS"];
                    //print();
                    return Center(
                      child: QrImage(
                        data: _qrencryp,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    );
                  }
              }
            }),
        Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Tú código QR',
              style: TextStyle(fontSize: 20),
              softWrap: true,
              overflow: TextOverflow.visible,
            ))
      ],
    );

    Widget estructura = FutureBuilder(
        future: _loaduser2(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                    'Aún no tienes puntos',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                );
              } else {
                return ListView.builder(
                    padding: EdgeInsets.zero,
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .20,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .10,
                                        imageUrl: data[index]["GAL_FOTO"],
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Container(
                                          margin: EdgeInsets.only(top: 1),
                                          child: Center(
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(data[index]["NEG_NOMBRE"],
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                              color: Colors.black,
                                            )),
                                        Row(
                                          children: [
                                            Text('Expira el: ',
                                                overflow: TextOverflow.ellipsis,
                                                style: new TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                            Text(
                                                dateFormat.format(
                                                    DateTime.parse(data[index]
                                                        ["PUN_CADUCIDAD"])),
                                                overflow: TextOverflow.ellipsis,
                                                style: new TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            new Text(
                                              data[index]["PUN_TOTAL"],
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            new Text(
                                              'Puntos  ',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            new Text(
                                              'obtenidos',
                                              style: TextStyle(fontSize: 10),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          String _usucorreo = widget.usuarios.correo;
                          String _idnegocio = data[index]["ID_NEGOCIO"];
                          setState(() {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        new Mis_promos_manejador(
                                          publicacion: new Publicacion(
                                              _usucorreo, _idnegocio),
                                        ))).then((value) => setState(() {}));
                          });
                        },
                      );
                    });
              }
          }
        });

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.black,
                Colors.white,
              ])),
              child: Text(
                "Mis Recompensas",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
          miqr,
          tutorial,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                new Mis_promos_manejador_obtenidas()));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  color: Colors.red,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Icon(
                        FontAwesomeIcons.gift,
                        color: Colors.white,
                      ),
                      new Text(' Recompensas obtenidas',
                          style: TextStyle(fontSize: 12, color: Colors.white)),
                    ],
                  )),
              RaisedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new DicePage()))
                          .then((value) => setState(() {}));
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  color: Colors.black,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Icon(
                        FontAwesomeIcons.diceSix,
                        color: Colors.white,
                      ),
                      new Text(' Obtener puntos',
                          style: TextStyle(fontSize: 12, color: Colors.white)),
                    ],
                  )),
            ],
          ),
          /* Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Ruleta()));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  color: Colors.orange,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Icon(
                        FontAwesomeIcons.spinner,
                        color: Colors.white,
                      ),
                      new Text(' Ruleta de la suerte',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ],
                  )),
            ],
          ),*/
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.black,
                Colors.white,
              ])),
              child: Text(
                "Mis puntos",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
          estructura,
        ],
      ),
    );
  }
}

class Login2 extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Login2> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      //addAutomaticKeepAlives: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        SizedBox(
          height: 100.0,
        ),
        Center(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                "assets/cabofind.png",
                fit: BoxFit.fill,
                width: 150.0,
                height: 150.0,
              )),
        ),
        SizedBox(
          height: 50.0,
        ),
        //SizedBox(height: 25.0,),
        Center(
            child: Text(
          "Crea tu cuenta",
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        )),
        Center(
            child: Text(
          "Para obtener recompensas!",
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        )),
        SizedBox(
          height: 20,
        ),
        Center(
            child: RaisedButton(
                onPressed: () {
                  FlutterYoutube.playYoutubeVideoByUrl(
                      apiKey: "AIzaSyAmNDqJm2s5Fpualsl_VF6LhG733knN0BY",
                      videoUrl: 'https://www.youtube.com/watch?v=hsLSjImkf-c',
                      autoPlay: false, //default falase
                      fullScreen: false //default false
                      );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
                color: Colors.red,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Icon(
                      FontAwesomeIcons.youtube,
                      color: Colors.white,
                    ),
                    new Text('  Ver video',
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                  ],
                ))),
      ],
    );
  }
}
