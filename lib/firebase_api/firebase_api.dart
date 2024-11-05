import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';

class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future initPushNotification() async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );
  }
  Future<void> initNotification() async{
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    userFCMToken = fCMToken!;
    initPushNotification();
  }
}
