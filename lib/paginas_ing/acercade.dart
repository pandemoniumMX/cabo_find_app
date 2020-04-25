
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Acercade_ing extends StatefulWidget {
@override
_Acercade createState() => new _Acercade();
}

class _Acercade extends State<Acercade_ing> {

  

   
@override
Widget build(BuildContext context) {

  celular() async {
     final url =  "tel:${6241543710}";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

   celular2() async {
     final url =  "tel:${6245939325}";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }


   correo() async {
       final url =  "mailto:cabofind@cabofind.com.mx";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

   facebook() async {
     final url =  "https://www.facebook.com/CaboFind/";
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

   

return new Scaffold(
appBar: new AppBar(
title: new Text('About us'),
),
body: Center(
  child: Column(
    children: <Widget>[ 

      Center(
        child: Padding(
          padding: const EdgeInsets.only(top:150.0),
          child: ClipRRect(borderRadius: BorderRadius.circular(8.0),child: Image.asset("assets/splash.png",fit: BoxFit.cover,width: 150.0,height: 150.0,)),
        ),
      ),
      Text('Contacto',style: 
      TextStyle(
        color: Color(0XFF000000),
        fontSize:25.0,
        fontWeight: FontWeight.bold),),

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('Report bugs or more information about Cabofind',style: 
      TextStyle(
          color: Color(0XFF000000),
          fontSize:18.0,
          ),),
        ),

        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
               
                FloatingActionButton(child: Icon(FontAwesomeIcons.phone), onPressed:celular,backgroundColor:Color(0xff01969A),heroTag: "bt1",),
                Text('Phone 1', style: TextStyle(color: Colors.black),),
              ],
            ),

            Column(
              children: <Widget>[
               
                FloatingActionButton(child: Icon(FontAwesomeIcons.phone), onPressed:celular2,backgroundColor:Color(0xff01969A),heroTag: "bt2",),
                Text('Phone 2', style: TextStyle(color: Colors.black),),
              ],
            ),
            
            Column(
              children: <Widget>[
                FloatingActionButton(child: Icon(FontAwesomeIcons.envelope), onPressed:correo,backgroundColor:Color(0xff01969A),heroTag: "bt3",),
                Text('Mail', style: TextStyle(color: Colors.black),),
              ],
            ),

            

            Column(
              children: <Widget>[
                FloatingActionButton(child: Icon(FontAwesomeIcons.facebook), onPressed:facebook,backgroundColor:Color(0xff01969A),heroTag: "bt5",),
                Text('Facebook', style: TextStyle(color: Colors.black),),
              ],
            ),

            
             
          ],
        ),

        
    ],
  ),

),
);
}
}
