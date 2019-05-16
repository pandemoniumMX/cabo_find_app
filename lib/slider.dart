import 'package:cabofind/carousel_pro.dart';
import 'package:flutter/material.dart';

class Slider extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Center(

      child: Container(

        margin: EdgeInsets.only(bottom: 100.0),
        padding: EdgeInsets.all(100.0),
        height: 600.0,
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

    );
  }
}