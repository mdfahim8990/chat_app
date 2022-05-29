import 'dart:async';
import 'package:chat_app/public_variables/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'controller/data_controller.dart';

void main() {
  final DataController dataController = Get.put(DataController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
    //  print( " Phone Width ${MediaQuery.of(context).size.width.toString()}");

    Timer(Duration(seconds: 3), () {
      /*Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) =>  SignInPage()));*/
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
