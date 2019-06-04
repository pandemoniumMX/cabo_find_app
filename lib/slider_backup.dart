import 'package:cabofind/carousel_pro.dart';
import 'package:cabofind/listado_test.dart';
import 'package:cabofind/main.dart';
import 'package:cabofind/publicaciones.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class ImageCarousel2 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Container(

        child: Stack(

          children: <Widget>[

            Container(

              margin: EdgeInsets.only(
                  top: 0.0),
              padding: EdgeInsets.all(
                  10.10),
              height: 350.0,
              child: Carousel(
                boxFit: BoxFit.cover,
                images: [
                  AssetImage(
                      'android/assets/images/img1.jpg'),
                  AssetImage(
                      'android/assets/images/img2.jpg'),
                  AssetImage(
                      'android/assets/images/img3.jpg'),
                  AssetImage(
                      'android/assets/images/img4.jpg'),
                  AssetImage(
                      'android/assets/images/img5.jpg'),
                  /*
                Image.network(
                  'http://cabofind.com.mx/app_php/varialbess.php',
                  fit: BoxFit.cover,
                  height: 100.0,
                  width: 100.0,
                ),
*/

                ],
                animationCurve: Curves.fastOutSlowIn,
                animationDuration: Duration(
                    milliseconds: 2000),
              ),
            ),

          ],
        )


    );
  }
}