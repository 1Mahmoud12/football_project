import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Messaging {
  const Messaging({Key? key}) ;

  Future<void> message()async{
    var tokenMessaging = await FirebaseMessaging.instance.getToken();
    print("token : $tokenMessaging");
    FirebaseMessaging.onMessage.listen((event) {
      print('on message');

      print(event.data.toString());
      //showToast(text: 'in app', state: ToastStates.SUCCESS);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('openedApp message');

      print(event.data.toString());
      //showToast(text: 'on message opened app', state: ToastStates.ERROR);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }
}
