import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Screens/Splash/SplashScreen.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Routes.dart';
import 'package:soul_milan/view_model/InstantChat_ViewModel.dart';
import 'package:soul_milan/view_model/MessengerChat_ViewModel.dart';
import 'package:soul_milan/view_model/SoulProfile_ViewModel.dart';
import 'package:soul_milan/view_model/SoulProfilesTimeline_ViewModel.dart';
import 'package:soul_milan/view_model/SubscriptionPackage_ViewModel.dart';
import 'package:soul_milan/view_model/TourPartners_ViewModel.dart';
import 'Utils/CustomTheme.dart';
import 'firebase_api/firebase_api.dart';
import 'firebase_options.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message: ${message.notification!.title.toString()}");
}

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  //initializing firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //end

  runApp(const MyApp());

  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async { 
    if(Platform.isAndroid){
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initStaticVariable().initialization();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InstantChats_ViewModel()),
        ChangeNotifierProvider(create: (_) => SubscriptionPackage_ViewModel()),
        ChangeNotifierProvider(create: (_) => SoulProfile_ViewModel()),
        ChangeNotifierProvider(create: (_) => SoulProfilesTimeline_ViewModel()),
        ChangeNotifierProvider(create: (_) => TourPartners_ViewModel()),
        ChangeNotifierProvider(create: (_) => MessengerChat_ViewModel()),
      ], 
      child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SOUL MILAN',
      theme: (CustomTheme()).theme(),
      initialRoute: RoutesClass.getSplash(),
      getPages: RoutesClass.routes,
      // home: const SplashScreen(),
    ) 
    );
  }
}

