import 'dart:convert';
import 'package:cabofind/paginas/domicilio.dart';
import 'package:cabofind/paginas/list_manejador_rec_obtenidas.dart';
import 'package:cabofind/paginas/menu_detalle.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'carrito_check.dart';
import 'dados.dart';
import 'list_manejador_menus.dart';
import 'list_manejador_recompensas.dart';
import 'package:cabofind/paginas/direccion.dart';

class Preparing extends StatefulWidget {
  final Users negocio;

  const Preparing({Key key, this.negocio}) : super(key: key);
  @override
  _Compras createState() => new _Compras();
}

class _Compras extends State<Preparing> {
  int _value = 1;
  //bool isLoggedIn = false;
  //final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  void initState() {
    //sesionLog();
    super.initState();
  }

  Future<Map> _check2() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");
    print(widget.negocio.correo);
    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/check_pedidos.php?IDF=$_mail2&IDN=${widget.negocio.correo}");

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: FutureBuilder(
            future: _check2(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Login2();
                  } else {
                    return Carritox(
                      negocio: Users(widget.negocio.correo),
                    );
                  }
              }
            }));
  }
}

class Carritox extends StatefulWidget {
  final Users negocio;

  const Carritox({Key key, this.negocio}) : super(key: key);
  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<Carritox> {
  String latd = "";
  String longd = "";
  final _formKey = GlobalKey<FormState>();
  List data;
  List ext;
  String id_extra;
  int _value = 1;
  double envio3 = 0.0;
  double total = 0;
  String ciudad;
  String idx;
  var location = Location();
  DateFormat dateFormat;
  double tiempoprep;
  double tiemporuta;
  double tiempototal;
  double distanciafinal;
  int tiempox;
  int tiempptxt = 0;
  int secs = 60;
  var listy = 0;
  String valpago;
  TextEditingController cupon = TextEditingController();
  TextEditingController forma = TextEditingController();

  Future<Map> _check() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/check_pedidos.php?IDF=$_mail2&IDN=${widget.negocio.correo}");
    return json.decode(response.body);
  }

  Future<Map> _checkDireccion() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/check_direccion_api.php?IDF=$_mail2");
    return json.decode(response.body);
  }

  Future<String> _eliminarItem(String id) async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/delete_pedidos_api.php?IDP=${id}");
  }

  Future<String> _confirmarOrden(String pago) async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _mail2 = "";
    _mail2 = login.getString("stringID");

    http.Response response = await http.get(
        "http://cabofind.com.mx/app_php/APIs/esp/insert_carrito_all.php?IDP=${idx}&IDN=${widget.negocio.correo}&IDF=$_mail2&FORMA=${pago}&DISTANCIA=$distanciafinal&TIEMPO=$tiempototal&ENVIO=$envio3&TIPO=$_value");
  }

  _getCurrentLocation(double latn, double longn, double tiempo) async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    }

    geo.Position position = await geo.Geolocator().getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.bestForNavigation);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);

    print(coordinates.longitude);

    double coor = coordinates.latitude;
    double long = coordinates.longitude;

    http.Response response = await http.get(
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=kilometer&origins=$coor,$long&destinations=$latn,$longn&key=AIzaSyA152PLBZLFqFlUMKQhMce3Z18OMGhPY6w");
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["rows"];
    print(data[0]['elements'][0]['distance']['text']);
    int distancia = data[0]['elements'][0]['distance']['value'];
    double subdistancia = distancia / 1000;

    print('distancia numerica' + distanciafinal.toString());

    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var ciudad2 = addresses.first.locality; //= ciudad
    ciudad = ciudad2;

    tiempox = data[0]['elements'][0]['duration']['value'];

    tiemporuta = tiempox / secs;

    double tiemposub = tiemporuta + tiempo; //tiempoprep;
    tiempototal = tiemposub;

    if (tiempptxt == 0) {
      setState(() {
        if (distancia <= 2999) {
          envio3 = 30.0;
          print('costo 3 de envio' + envio3.toString());
        } else if (distancia >= 3000 && distancia <= 4999) {
          envio3 = 50.0;
          print('costo 3 de envio' + envio3.toString());
        } else if (distancia >= 5000) {
          double distanciaplus = distancia / 110;
          envio3 = distanciaplus.roundToDouble();
          print('costo 3 de envio' + envio3.toString());
        }

        distanciafinal = subdistancia;
        tiempptxt = tiempototal.round();
      });
    }
  }

  Future<String> _cargarPedido() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    String _status = "";
    String _mail = "";
    String _mail2 = "";
    String _idusu = "";
    _status = login.getString("stringLogin");
    _mail2 = login.getString("stringID");

    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_pedidos_api.php?IDF=$_mail2&IDN=${widget.negocio.correo}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });
  }

  Future<String> _cargarExtra() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/APIs/esp/list_check_extras_api.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      ext = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    this._cargarPedido();
    this._cargarExtra();
    dateFormat = new DateFormat.jms('es');
  }

  @override
  void dispose() {
    cupon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Regresar'),
        backgroundColor: Color(0xff60032D),
      ),
      body: ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.all(10),
              child: Text(
                'Mi orden',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )),
          Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Row(children: <Widget>[
                Flexible(
                  child: Text(
                    'Estás ordenando en ' + data[0]["NEG_NOMBRE"],
                    style: TextStyle(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ])),
          FutureBuilder(
              future: _check(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => Carrito_check()),
                          (Route<dynamic> route) => false);
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: data == null ? 0 : data.length,
                          itemBuilder: (BuildContext context, int index) {
                            String idx = data[index]["ID_PEDIDOS"];
                            String idn = data[index]["ID_NEGOCIO"];
                            var latx = double.parse(data[0]["NEG_MAP_LAT"]);
                            var longx = double.parse(data[0]["NEG_MAP_LONG"]);
                            latd = latx.toString();
                            longd = longx.toString();
                            tiempoprep =
                                double.parse(data[0]["MENU_TIEMPO_PREP"]);

                            _getCurrentLocation(latx, longx, tiempoprep);

                            return new Card(
                              elevation: 1.0,
                              child: new Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                // return object of type Dialog
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  title: new Text("Alerta"),
                                                  content: new Text(
                                                    "¿Seguro que desea eliminar?",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  actions: <Widget>[
                                                    // usually buttons at the bottom of the dialog
                                                    new FlatButton(
                                                      child: new Text(
                                                        "Cerrar",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    new FlatButton(
                                                      child: new Text(
                                                        "Confirmar",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff773E42)),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _eliminarItem(idx);
                                                        });
                                                        _cargarPedido();
                                                        _cargarPedido();
                                                        Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                            () {});
                                                        Navigator.of(context)
                                                            .pop();

                                                        /*_eliminarItem(idx);
                                                        setState(() {});

                                                        Navigator.of(context)
                                                            .pop();
                                                        if (snapshot.hasError) {
                                                          /*
                                                          Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      new Menu_manejador(
                                                                          manejador: new Users(widget
                                                                              .negocio
                                                                              .correo))));*/
                                                        } else if (snapshot
                                                            .hasData) {
                                                          setState(() {});
                                                          _cargarPedido();
                                                        } else {
                                                           Navigator.of(context)
                                                              .pop();
                                                          Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      new Menu_manejador(
                                                                          manejador: new Users(widget
                                                                              .negocio
                                                                              .correo))));*/
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            child: Icon(
                                              FontAwesomeIcons.trashAlt,
                                              color: Colors.red,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(children: <Widget>[
                                          Text(
                                              data[index]["PED_CANTIDAD"] + 'X',
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                                color: Color(0xff773E42),
                                              )),
                                        ]),
                                        Text(data[index]["MENU_NOMBRE"],
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18.0,
                                              color: Colors.black,
                                            )),
                                        new Text(
                                          '\$ ' + data[index]["PED_TOTAL"],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 0),
                                      padding: EdgeInsets.all(5),
                                      child: data[index]["MENU_EXTRA_TIPO"] !=
                                              null
                                          ? Text(
                                              data[index]["MENU_EXTRA_TIPO"] +
                                                  ':',
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                                color: Colors.black,
                                              ))
                                          : SizedBox(),
                                    ),
                                    idx == idx
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            itemCount:
                                                ext == null ? 0 : ext.length,
                                            itemBuilder:
                                                (BuildContext contexts, int a) {
                                              String idp =
                                                  ext[a]["pedidos_ID_PEDIDOS"];
                                              String idx2 =
                                                  data[index]["ID_PEDIDOS"];

                                              if (idp == idx2) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 30),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Text(
                                                        ext[a]["EXT_NOMBRE"],
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 15),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Text(
                                                        '\$' +
                                                            ext[a]
                                                                ["EXT_PRECIO"],
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              } else {
                                                return SizedBox();
                                              }
                                            })
                                        : Text(''),
                                    Container(
                                      margin: EdgeInsets.only(left: 0),
                                      padding: EdgeInsets.all(5),
                                      child: data[index]["PED_NOTA"] != null
                                          ? Container(
                                              child: Text('Nota(s): ',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.black,
                                                  )),
                                            )
                                          : SizedBox(),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 25),
                                      padding: EdgeInsets.all(10),
                                      child: data[index]["PED_NOTA"] != null
                                          ? Text(
                                              data[index]["PED_NOTA"],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            )
                                          : SizedBox(),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                }
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Subtotal',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$' + data[0]["Total"],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          Divider(
            thickness: 1,
          ),
          Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.all(10),
              child: Text(
                'Acerca de la orden',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Tipo de orden',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )),
              DropdownButton(
                  isExpanded: false,
                  value: _value,
                  items: [
                    DropdownMenuItem(child: Text("Domicilio"), value: 1),
                    DropdownMenuItem(child: Text("Recoger"), value: 2),
                  ],
                  onChanged: (valuex) {
                    setState(() {
                      _value = valuex;
                    });
                  }),
            ],
          ),
          _value == 1
              ? //domicilio
              FutureBuilder(
                  future: _checkDireccion(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        if (snapshot.hasError) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new Mi_direccion(
                                            ubicacion: Latlong(
                                                widget.negocio.correo,
                                                latd,
                                                longd),
                                          )));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(left: 10),
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Dirección',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )),
                                Text(
                                  'Agrega tu dirección',
                                  style: TextStyle(color: Colors.red),
                                ),
                                Icon(FontAwesomeIcons.chevronRight),
                              ],
                            ),
                          );
                        } else {
                          total = envio3 +
                              double.parse(data[0]["Total"]); //suma totalx
                          return distanciafinal <= 8.0
                              ? Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      new Mi_direccion(
                                                        ubicacion: Latlong(
                                                            widget
                                                                .negocio.correo,
                                                            latd,
                                                            longd),
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                padding: EdgeInsets.all(10),
                                                child: Text(
                                                  'Dirección',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                )),
                                            Flexible(
                                              child: Text(
                                                snapshot.data['DIC_CALLE'],
                                                style: TextStyle(
                                                    color: Color(0xff773E42),
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  FontAwesomeIcons.check,
                                                  color: Color(0xff773E42),
                                                  size: 18,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(left: 10),
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                'Costo de envío',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(left: 10),
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                '\$' + envio3.toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(left: 10),
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                'Tiempo de entrega ',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(left: 10),
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                tiempptxt.toString() +
                                                    ' Minutos',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                      Divider(
                                        thickness: 2,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(left: 10),
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            '¿Cupón de descuento?',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(left: 10),
                                              padding: EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.4,
                                              child: TextField(
                                                readOnly: true,
                                                controller: cupon,
                                                enabled: true,
                                                decoration: InputDecoration(
                                                    focusColor:
                                                        Color(0xffD3D7D6),
                                                    hoverColor:
                                                        Color(0xffD3D7D6),
                                                    hintText:
                                                        'Ingresa un cupon válido'),
                                              )),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              padding: EdgeInsets.all(1),
                                              child: FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      side: BorderSide(
                                                          color: Color(
                                                              0xffD3D7D6))),
                                                  onPressed: () {},
                                                  child: Text('Check')))
                                        ],
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(left: 10),
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            'Forma de pago',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(left: 10),
                                              padding: EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.4,
                                              child: Text(
                                                'Efectivo',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18),
                                              ) /*DropdownButtonFormField<String>(
                                          items: [
                                            DropdownMenuItem<String>(
                                              child: Text('Efectivo'),
                                              value: 'Efectivo',
                                            ),
                                            /*  DropdownMenuItem<String>(
                                              child: Text('Tarjeta'),
                                              value: null,

                                            ),*/
                                          ],
                                          onChanged: (String value) {
                                            setState(() {
                                              valpago = value;
                                            });
                                          },
                                          hint:
                                              Text('Selecciona forma de pago'),
                                          value: valpago,
                                          validator: (value) => value == null
                                              ? 'Campo requerido'
                                              : null,
                                        ),*/
                                              )
                                        ],
                                      ),
                                      Container(
                                        //color: Color(0xffD3D7D6),
                                        margin: EdgeInsets.only(
                                            left: 50, right: 50),
                                        decoration: BoxDecoration(
                                          color: Color(0xffD3D7D6),
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          //  border: Border.all(width: 1, color: Color(0xffD3D7D6))
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                'Total',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                '\$' + total.toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: RaisedButton(
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  // return object of type Dialog
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                    title: new Text("Alerta"),
                                                    content: new Text(
                                                      "¿Seguro que desea confirmar orden?",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    actions: <Widget>[
                                                      // usually buttons at the bottom of the dialog
                                                      new FlatButton(
                                                        child: new Text(
                                                          "Cerrar",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),

                                                      new FlatButton(
                                                        child: new Text(
                                                          "Confirmar",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff773E42)),
                                                        ),
                                                        onPressed: () {
                                                          _confirmarOrden(
                                                              valpago);

                                                          Navigator.of(context)
                                                              .pushReplacement(
                                                            MaterialPageRoute(
                                                                builder: (context) => Domicilio(
                                                                    numeropagina:
                                                                        Categoria(
                                                                            2),
                                                                    numtab:
                                                                        Categoria(
                                                                            0))),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          color: Color(0xff773E42),
                                          textColor: Colors.white,
                                          child: Text(
                                            'Confirmar orden',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Column(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    new Mi_direccion(
                                                      ubicacion: Latlong(
                                                          widget.negocio.correo,
                                                          latd,
                                                          longd),
                                                    )));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(left: 10),
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                'Dirección',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              )),
                                          Text(
                                            'Agrega tu dirección',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          Icon(FontAwesomeIcons.chevronRight),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.only(left: 10),
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              'Comisión por entrega',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(left: 10),
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              '\$ 30',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 10),
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          '¿Cupón de descuento?',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.only(left: 10),
                                            padding: EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.4,
                                            child: TextField(
                                              controller: cupon,
                                              enabled: false,
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                  focusColor: Color(0xffD3D7D6),
                                                  hoverColor: Color(0xffD3D7D6),
                                                  hintText:
                                                      'Ingresa un cupon válido'),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(right: 10),
                                            padding: EdgeInsets.all(1),
                                            //color: Color(0xff773E42),
                                            child: FlatButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    side: BorderSide(
                                                        color:
                                                            Color(0xffD3D7D6))),
                                                onPressed: () {},
                                                child: Text('Check')))
                                      ],
                                    ),
                                    Container(
                                      //color: Color(0xffD3D7D6),
                                      margin:
                                          EdgeInsets.only(left: 50, right: 50),
                                      decoration: BoxDecoration(
                                        color: Color(0xffD3D7D6),
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        //  border: Border.all(width: 1, color: Color(0xffD3D7D6))
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              'Total',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              '\$ 0',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      child: RaisedButton(
                                        onPressed: null,
                                        color: Colors.grey,
                                        textColor: Colors.white,
                                        child: Text(
                                          'Distancia demasiado lejana :(',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                        }
                    }
                  })
              : Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Tiempo de preparación ',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )),
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                tiempoprep.toString() + ' Minutos',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            '¿Cupón de descuento?',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: TextField(
                                readOnly: true,
                                controller: cupon,
                                enabled: true,
                                decoration: InputDecoration(
                                    focusColor: Color(0xffD3D7D6),
                                    hoverColor: Color(0xffD3D7D6),
                                    hintText: 'Ingresa un cupon válido'),
                              )),
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.all(1),
                              child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side:
                                          BorderSide(color: Color(0xffD3D7D6))),
                                  onPressed: () {},
                                  child: Text('Check')))
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Forma de pago',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                      Row(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: Text(
                                'Efectivo',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 18),
                              ))
                        ],
                      ),
                      Container(
                        //color: Color(0xffD3D7D6),
                        margin: EdgeInsets.only(left: 50, right: 50),
                        decoration: BoxDecoration(
                          color: Color(0xffD3D7D6),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0),
                          //  border: Border.all(width: 1, color: Color(0xffD3D7D6))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Total',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '\$' + data[0]["Total"],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    title: new Text("Alerta"),
                                    content: new Text(
                                      "¿Seguro que desea confirmar orden?",
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      new FlatButton(
                                        child: new Text(
                                          "Cerrar",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),

                                      new FlatButton(
                                        child: new Text(
                                          "Confirmar",
                                          style: TextStyle(
                                              color: Color(0xff773E42)),
                                        ),
                                        onPressed: () {
                                          _confirmarOrden(valpago);

                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) => Domicilio(
                                                    numeropagina: Categoria(2),
                                                    numtab: Categoria(0))),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          color: Color(0xff773E42),
                          textColor: Colors.white,
                          child: Text(
                            'Confirmar orden',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
