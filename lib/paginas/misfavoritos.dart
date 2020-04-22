import 'package:flutter/material.dart';

class Mis_favoritos extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Mis_favoritos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    
  colors: [
    Color(0xff01969a),
    Colors.white,
    
  ])),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100.0,),
            ClipRRect(borderRadius: BorderRadius.circular(8.0),child: Image.asset("assets/splash.png",fit: BoxFit.fill,width: 150.0,height: 150.0,)),
            SizedBox(height: 50.0,),
            Text("Crea tu cuenta",style: TextStyle(fontSize:25, color: Colors.white,fontWeight: FontWeight.bold ),),
            Text("Para agregar tus favoritos!",style: TextStyle(fontSize:25, color: Colors.white,fontWeight: FontWeight.bold ),),
            SizedBox(height: 50.0,),
            ClipRRect(borderRadius: BorderRadius.circular(8.0),child: Image.asset("assets/corazon2.png",fit: BoxFit.fill,width: 80.0,height: 80.0,)),
            
            

          ],
        ),
      ),
    );
  }
}