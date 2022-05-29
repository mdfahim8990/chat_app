import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/data_controller.dart';

class SizeConfig{
  final DataController dataController =Get.find();
  double width() {
    return dataController.size.value;
  }
}

double dynamicSize(double size){
  return SizeConfig().width()*size;
}