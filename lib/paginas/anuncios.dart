
import 'package:cabofind/paginas_ing/anuncios.dart';
import 'package:cabofind/paginas_listas/list__anun_autos.dart';
import 'package:cabofind/paginas_listas/list__anun_electronica.dart';
import 'package:cabofind/paginas_listas/list__anun_empleo.dart';
import 'package:cabofind/paginas_listas/list__anun_inmuebles.dart';

import 'package:cabofind/utilidades/buscador_market.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Anuncios extends StatefulWidget {
@override
_Servicios createState() => new _Servicios();
}

class _Servicios extends State<Anuncios> {
  int id=0;

  @override
Widget build(BuildContext context) {
  final tabpages=<Widget>[

    new Lista_anun_autos(),
    new Lista_anun_inmueble(),
    new Lista_anun_electronica(),
    new Lista_anun_empleo(),
    


  ];

  final bnbi=<BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.car,),title: Text("Autos")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.sign,),title: Text("Inmuebles")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.laptop,),title: Text("Tecnología")),
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userCheck,),title: Text("Bolsa de trabajo")),





  ];


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
    appBar: new AppBar(
      title: new Text('Marketplace'),
      actions: <Widget>[          
                       
       new InkResponse(
                onTap: () {
                
              //Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Anuncios_ing()
                        )
                        );
            },
                child: new Center(
                  //padding: const EdgeInsets.all(13.0),
                  
                  child: new Container(
                   decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: ExactAssetImage('assets/usaflag.png'),
                      fit: BoxFit.fill,
                    ),
                  
                      
                      ),
                      child: new Text("     ",
                    
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                    
                    

                  ),
                )
                ),

          
          new IconButton(
            icon: new Icon(Icons.search),
              onPressed: () {
                //Use`Navigator` widget to push the second screen to out stack of screens
                Navigator.of(context)
                    .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new Buscador_market();
                }));
              }, ),

        ],
    ),
  );
}
}