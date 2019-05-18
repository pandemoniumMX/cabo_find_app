import 'package:cabofind/carousel_pro.dart';
import 'package:cabofind/main.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class ImageCarousel2 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new  Container(
//fondo
            margin: EdgeInsets.only(top: 380.0, left: 10.0),
            padding: EdgeInsets.all(10.10),
            height: 200.0,
            width: 520,
            color: Colors.grey,
          ),

          Container(
            margin: EdgeInsets.only(top: 0.0),
            padding: EdgeInsets.all(10.10),
            height: 350.0,
            child: Carousel(
              boxFit: BoxFit.cover,
              images: [
                AssetImage('android/assets/images/img1.jpg'),
                AssetImage('android/assets/images/img2.jpg'),
                AssetImage('android/assets/images/img3.jpg'),
                AssetImage('android/assets/images/img4.jpg'),
                AssetImage('android/assets/images/img5.jpg'),

              ],
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: Duration(milliseconds: 2000),
            ),
          ),



//texto
          Container(
            child: Text(
              'Las mejores playas están aquí',
              textAlign: TextAlign.center,
              //overflow: TextOverflow.ellipsis,

              style: TextStyle(

                  color: Color(0XFF000000),
                  fontSize:25.0,
                  fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.only(top: 330.0, left: 10.0),
            padding: EdgeInsets.all(10.10),

          ),




        ],

      ),


    );
  }
}