import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

class DataController extends GetxController {
  static DataController dc = Get.find();
  RxBool isPhone = true.obs;
  RxBool isConnected = true.obs;
  RxDouble size = 360.0.obs;
  var feedbackController = TextEditingController(text: '').obs;

  void updateFeedController(String val) {
    feedbackController.value.text = val;
    update();
  }

  void clearFeedController() {
    feedbackController.value.clear();
    update();
  }

  void getSize(BuildContext context) {
    final Size s = MediaQuery.of(context).size;
    if (s.width <= 500) {
      size(s.width);
    } else if (s.width > 500) {
      size(s.width);
    }
    update();
    if (kDebugMode) {
      print('Size: w=${s.width}, h=${s.height}');
    }
  }

  Future<void> sendNotification(String receiverId ,String receiverToken ) async {
    User? users = FirebaseAuth.instance.currentUser;
    UserModel loggedInUser = UserModel();
/*    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(users!.uid).get().then((value) {
        loggedInUser = UserModel.fromMap(value.data());
    });*/

    // DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("users").doc(users!.uid).get();
   /* FirebaseFirestore.instance
        .collection("users")
        .doc(users!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());

      print("Tokenn : ${loggedInUser.token}");
    });*/

    // final List<QueryDocumentSnapshot> user = snapshot.docs;
    final String token = loggedInUser.token.toString();

    final data = <String, dynamic>{
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'message': '${loggedInUser.name}sent you a massage',
      'sender': '',
      'receiver': receiverId,
    };

    try {
      http.Response response =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization':
                    'key=AAAAYoYZ4yk:APA91bE3QSSsdMW-TZNbGocpX9LxZrwTtK32B_WThi31Coc0_hTjn6CQEa4yaqQ-4WAm2eb1Wa2vxNoIh7NjwGCvFWfjg0N6MTUglSNqpaZ7Nii0RKxNe9JXCsbs60TQlQM_LlS-p0mH'
              },
              body: jsonEncode(<String, dynamic>{
                'notification': <String, dynamic>{
                  'title': 'Notification from Chat App',
                  'body': ' sent you a request'
                },
                'priority': 'high',
                'data': data,
                'to': receiverToken
              }));
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Request sent successfully');
        }
      } else {
        if (kDebugMode) {
          print('Request Failed!');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error>>>$e');
      }
    }
  }

  Future<void> checkConnectivity() async {
    await (Connectivity().checkConnectivity()).then((result) {
      if (result == ConnectivityResult.none) {
        isConnected.value = false;
      } else if (result == ConnectivityResult.mobile) {
        isConnected.value = true;
      } else if (result == ConnectivityResult.wifi) {
        isConnected.value = true;
      }
      update();
      print('Internet Connected: ${isConnected.value}');
    });
  }
}
