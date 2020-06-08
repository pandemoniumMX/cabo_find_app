
import 'dart:async';

import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'list_manejador.dart';

class Ruleta extends StatefulWidget {


  @override
_Restaurantes createState() => new _Restaurantes();
}

class _Restaurantes extends State<Ruleta> {
      final StreamController _dividerController = StreamController<int>();  
  dispose() {
    _dividerController.close();
  }

  @override
  void initState(){
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
      title: new Text('Ruleta'),
    ),
      
      body: Center(
          child: Container(child:
            SpinningWheel(
              Image.asset('assets/ruleta.png'),
              width: 310,
              height: 310,
              dividers: 6,
              onUpdate: _dividerController.add,
              onEnd: _dividerController.add,
            ),
          ),
        )
    );
  }
}
