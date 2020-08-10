import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const request = "https://api.hgbrasil.com/finance?format=json&key=80f27c39";

void main() {
  runApp(MaterialApp(
    home: Calculadora_ing(),
    theme: ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      accentColor: Colors.black26,
    ),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

Future<Map> getData1() async {
  http.Response response = await http.get("http://api.openrates.io/latest");
  return json.decode(response.body);
}

class Calculadora_ing extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Calculadora_ing> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  List<String> currencies;
  String fromCurrency = "USD";
  String toCurrency = "MXN";

  //here we have decleared the variables, that store rates from API
  Future<String> _loadCurrencies() async {
    String uri = "http://api.openrates.io/latest";
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    Map curMap = responseBody['rates'];
    currencies = curMap.keys.toList();
    setState(() {});
    print(currencies);
    return "Success";
  }

  double dollar_buy;
  double euro_buy;

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dollar_buy).toStringAsFixed(2);
    euroController.text = (real / euro_buy).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dollar_buy).toStringAsFixed(2);
    euroController.text =
        (dolar * this.dollar_buy / euro_buy).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro_buy).toStringAsFixed(2);
    dolarController.text =
        (euro * this.euro_buy / dollar_buy).toStringAsFixed(2);
  }

  @override
  void initState() {
    _loadCurrencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("MONEY EXCHANGE"),
        //backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getData1(),
          //snapshot of the context/getData
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: Text(
                  "Loading...",
                  style: TextStyle(color: Colors.black, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "Error :(",
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                } else {
                  dollar_buy =
                      //here we pull the us and eu rate
                      snapshot.data["rates"]["MXN"];
                  euro_buy = snapshot.data["rates"]["USD"];
                  return SingleChildScrollView(
                      child: Column(
                    children: <Widget>[
                      Icon(Icons.monetization_on,
                          size: 150.0, color: Colors.black),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildTextField(
                            "DOLLARS", "US\$", dolarController, _dolarChanged),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildTextField(
                            "PESOS", "MX\$", euroController, _euroChanged),
                      ),
                    ],
                  ));
                }
            }
          }),
    );
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.black, fontSize: 25.0),
    onChanged: f,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}
