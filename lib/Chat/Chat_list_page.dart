import 'package:chat_app/Chat/massage_page.dart';
import 'package:chat_app/Login_page.dart';
import 'package:chat_app/public_variables/size_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../controller/data_controller.dart';
import '../model/user_model.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  User user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  List<UserModel> loggedInUserList = [];
  @override
  void initState() {
    super.initState();
    DataController.dc.checkConnectivity();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((value) {
      setState(() {
        this.loggedInUser = UserModel.fromMap(value.data());
        getData();
      });
      print("Name : ${loggedInUser}");
    });
  }

   getData() async{
     DataController.dc.checkConnectivity();
     loggedInUserList.clear();
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("users").get();
    qn.docs.forEach((element) {
      UserModel userdata  = UserModel.fromMap(element.data());
      print("message  list : ${element.data()}  ");

      if(userdata.uid !=  loggedInUser.uid){
        loggedInUserList.add(userdata);
      }

    });
    setState(() {loggedInUserList; });
    print("Name : ${loggedInUserList}");
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("${loggedInUser.name}"),
          actions: <Widget>[
          IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to Logout !'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  TextButton(
                    onPressed: () {

                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => LoginPage()));
                    } ,
                    child: new Text('Yes',style: TextStyle(color: Colors.pink),),
                  ),
                ],
              ),
            );
          },
        ), 
   
      ],
      ),
      body: FutureBuilder(
        builder: (context,snapshot){
          return ListView.builder(
            itemCount: loggedInUserList.length,
            itemBuilder: (context, index) {

              return ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: dynamicSize(0.15),
                    width: dynamicSize(1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                              color: Colors.black38)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            " ${loggedInUserList[index].name}",
                            style: TextStyle(
                              fontSize: dynamicSize(0.05),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 8),
                          child: Text(
                            "Have some new massage",
                            style: TextStyle(
                              fontSize: dynamicSize(0.03),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MassagePage(
                        Name: "${loggedInUserList[index].name}", userId: '${loggedInUser.uid}', receiverId: '${loggedInUserList[index].uid}', receiverToken: '${loggedInUserList[index].token}',
                      )));
                },
              );
            },
          );
        },
      ),
    ));
  }

}
