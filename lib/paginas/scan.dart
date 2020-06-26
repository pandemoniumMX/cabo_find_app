import 'package:barcode_scan/barcode_scan.dart';
import 'package:cabofind/paginas/menu.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException, rootBundle;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Escanear_menu extends StatefulWidget {
  @override
  _Escanear_menuState createState() => _Escanear_menuState();




  
}

class _Escanear_menuState extends State<Escanear_menu> {
String barcode = "";
ScanResult scanResult;


    Future<String> _getIDNegocio() async {

    if (scanResult.rawContent  == ''){

    //   _showRecompensa();

    }else{

              String id_n = scanResult.rawContent;
              Navigator.push(context, new MaterialPageRoute
              (builder: (context) => new Menu_comidas(
              manejador: new Users('37'),//idnegocio 
            )));
    }  
  }

    Future scan() async {
        try {    

      var result = await BarcodeScanner.scan();

      setState(() => scanResult = result);
      _getIDNegocio();
      print('****************************************'+scanResult.rawContent);
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
          
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      setState(() {
        scanResult = result;
        
        
        
      });
    }
  }

  @override
  void initState() {
    super.initState(
    );

    scan();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Regresar'),),
      body:Center(
      
      child: RaisedButton(
                  onPressed: (){                
                      scan();

                  },  
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
                  color: Colors.orange,
                  child: new Row (
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,

                                          children: <Widget>[
                                            
                                            new Text(' Escanear QR', style: TextStyle(fontSize: 20, color: Colors.white)), 
                                            new Icon(FontAwesomeIcons.qrcode, color: Colors.white,),
                                            
                                          ],
                                        )
                )
      
    )
    ) ;
  }
}