import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DataController extends GetxController{
  static DataController dc = Get.find();
  RxBool isPhone = true.obs;
  RxDouble size = 360.0.obs;
  var feedbackController = TextEditingController(text:'').obs;

  void updateFeedController(String val){
    feedbackController.value.text=val;
    update();
  }
  void clearFeedController(){
    feedbackController.value.clear();
    update();
  }

  void getSize(BuildContext context){
    final Size s = MediaQuery.of(context).size;
    if(s.width<=500){
      size(s.width);
    }else if(s.width>500){
      size(s.width);
    }
    update();
    if (kDebugMode){
      print('Size: w=${s.width}, h=${s.height}');
    }
  }

}