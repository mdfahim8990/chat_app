import 'dart:async';
import 'package:chat_app/public_variables/size_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'Login_page.dart';
import 'controller/data_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'controller/service.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message');
  print('\n\nEvent: ${message.data}\n\n');
  Future.delayed(const Duration(seconds: 5)).then((value) => print('............................'));
}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final DataController dataController = Get.put(DataController());
  Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<void> _fcmInit()async{
    FirebaseMessaging.instance.getInitialMessage();

    ///When App Running
    FirebaseMessaging.onMessage.listen((event) {
      if (kDebugMode) {
        print('!!FCM message Received!! (On Running)\n');
      }
      NotificationService.display(event);
    });

    ///When App Minimized
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (kDebugMode) {
        print('!!FCM message Received (On Minimize)!!');
      }
      NotificationService.display(event);
    });

    ///When App Destroyed
    FirebaseMessaging.instance.getInitialMessage().then((value){
      if (kDebugMode && value!=null) {
        NotificationService.display(value);
      }

    });
  }

  @override
  void initState() {
    super.initState();
    _fcmInit();
  }

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          canvasColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white),
      home: SplashScreen(),
    );
  }
}



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) =>  LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    DataController.dc.getSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: dynamicSize(0.5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.3),
                blurRadius: 7,
                spreadRadius: 5,
                offset: const Offset(0, 3), // Shadow position
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/chat_icon.jpg',
                height: dynamicSize(0.4),
              ),
              //SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
