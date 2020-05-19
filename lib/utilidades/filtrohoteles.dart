import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Filtro extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Filtro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filtrar'),),
      body: Cuerpo(),
      
    );
  }
}

class Cuerpo extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [   
          Divider(),         
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Text('Ordenar por',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            Text('Calidad-Precio',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          ],),
          Divider(),
          Text('Opciones de filtro',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20),),
          Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Text('Estrellas',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            Text('Cualquiera',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          ],),
          Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Text('Estilo de hotel',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            Text('Todos',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          ],),
          Divider(),
          RaisedButton(

                  onPressed: (){},  

                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5.0) ),

                  color: Color(0xff01969a),
                  
                  child: Container(
                    height: 80,
                    child: new Row (
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      

                      children: <Widget>[
                        new Text('Buscar  ', style: TextStyle(fontSize: 30, color: Colors.white)), 
                        new Icon(FontAwesomeIcons.search, color: Colors.white,)
                      ],
                    ),
                  )
                  
                )
        ],
      ),)
      ]);
  }
}