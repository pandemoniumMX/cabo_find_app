
/*
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'dart:async';

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

      onMessage: ( info ) {

        print('======= On Message ========');
        print( info );

        String argumento = 'no-data';
        if ( Platform.isIOS  ) {
          argumento = info['data']['id_n']['id_p'] ?? 'no-data';
        } else {
          argumento = info['data']['id_n']['id_p'] ?? 'no-data';
        }

        _mensajesStreamController.sink.add(argumento);

      },
      onLaunch: ( info ) {

        print('======= On Launch ========');
        print( info );

        String argumento = 'no-data';
        if ( Platform.isIOS  ) {
          argumento = info['data']['id_n']['id_p'] ?? 'no-data';
        } else {
          argumento = info['data']['id_n']['id_p'] ?? 'no-data';
        }

        _mensajesStreamController.sink.add(argumento);

        

      },

      onResume: ( info ) {

        print('======= On Resume ========');
        print( info );

        String argumento = 'no-data';
        if ( Platform.isIOS  ) {
          argumento = info['data']['id_n']['id_p'] ?? 'no-data';
        } else {
          argumento = info['data']['id_n']['id_p'] ?? 'no-data';
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