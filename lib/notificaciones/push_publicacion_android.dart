
/*
import 'package:cabofind/paginas/publicacion_detalle.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';

class PushNotificationPubAndroid {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;


  initNotifications() {

    _firebaseMessaging.requestNotificationPermissions();


    _firebaseMessaging.getToken().then( (token) {


      print('===== FCM Token =====');
      print( token );

    });


    _firebaseMessaging.configure(

      onMessage: ( Map<String, dynamic> message ) async {

        print('======= On Message ========');
        print(" $message" );

       showDialog(
         context: context,
         builder: (context) => AlertDialog(
           content: ListTile(
             title: Text(message['notification']['title']),
             subtitle: Text(message['notification']['body']),

           ),
         )
       )

       

      },
      onLaunch: ( info ) {

        print('======= On Message ========');
        return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Reseña',style: TextStyle(fontSize: 25.0,),),
             content: Container(
                 width: MediaQuery.of(context).size.width,
                 height: 350.0,
                 child:  
                Column(
                                    children: <Widget>[  
              Text('Valoración'),  
                                        
              Text('Escribe una breve reseña'),
             
               
                ],
                 )
                 
             ),
             actions: <Widget>[
               new FlatButton(
                 child: new Text('Cancelar'),
                 onPressed: () {
                   Navigator.of(context).pop();
                 },
               ),
               new FlatButton(
                 child: new Text('Enviar'),
                 onPressed: (){ 
                 
                
                 
                 },
               )
             ],
           );
         });
      },

      onResume: ( info ) {

        print('======= On Message ========');
        print( info );

        String argumento = 'no-data';
        if ( Platform.isAndroid  ) {  
          argumento = info['data']['id_n']['id_p'] ?? 'no-data';
        } else {
          argumento = info['id_n']['id_p'] ?? 'no-data-ios';
        }

        _mensajesStreamController.sink.add(argumento);

      }


    );


  }


  dispose() {
    _mensajesStreamController?.close();
  }

}
*/