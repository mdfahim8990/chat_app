import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controller/data_controller.dart';
import '../model/massage_model.dart';
import '../public_variables/size_config.dart';

class MassagePage extends StatefulWidget {
  const MassagePage(
      {Key? key,
      required this.Name,
      required this.userId,
      required this.receiverId,
      required this.receiverToken
      })
      : super(key: key);
  final String Name, userId, receiverId, receiverToken;

  @override
  State<MassagePage> createState() => _MassagePageState();
}

class _MassagePageState extends State<MassagePage> {
  CollectionReference chats = FirebaseFirestore.instance.collection("chats");

  final _formKey = GlobalKey<FormState>();
  final TextEditingController massage = new TextEditingController();

  List<MassageModel> messageList = [];

  @override
  void initState() {
    super.initState();
    DataController.dc.checkConnectivity();
  }

  getMassageData() async {
    DataController.dc.checkConnectivity();
    messageList.clear();
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .doc('${widget.userId}')
        .collection('messages')
        .doc('chat')
        .collection('${widget.receiverId}')
        .get();
    qn.docs.forEach((element) {
      print("message : ${element.data()} list of data : ");

      MassageModel userdata = MassageModel.fromMap(element.data());

        messageList.add(userdata);
      print("message : ${element.data()} list of data : ${userdata.message}");
    }

    );

    setState(() {
      messageList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.Name),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("users")
            .doc('${widget.userId}').collection('messages').doc('chat')
            .collection('${widget.receiverId}').snapshots(),
          builder: (context,snapshot) {
            if(snapshot.hasData){
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                          child: Row(
                            mainAxisAlignment: getSender(snapshot.data!.docs[index]['senderId']) % 2 == 0
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getSender(snapshot.data!.docs[index]['senderId']) % 2 == 0
                                  ? CircleAvatar(
                                radius: dynamicSize(.04),
                                child: Icon(Icons.person_sharp,
                                    color: Colors.white),
                              )
                                  : Container(),
                              SizedBox(width: 10),
                              Container(
                                  width: MediaQuery.of(context).size.width * .6,
                                  child: Text(
                                    snapshot.data!.docs[index]['message'],
                                    textAlign: getSender(snapshot.data!.docs[index]['senderId']) % 2 == 0
                                        ? TextAlign.start
                                        : TextAlign.end,
                                  )),
                              SizedBox(width: 10),
                              getSender(snapshot.data!.docs[index]['senderId']) % 2 == 0
                                  ? Container()
                                  : CircleAvatar(
                                radius: dynamicSize(.04),
                                child: Icon(Icons.person, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///Message box
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              maxLines: 5,
                              minLines: 1,
                              controller: massage,
                              obscureText: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("");
                                }
                                return null;
                              },
                              onSaved: (value) {
                                massage.text = value!;
                              },
                              decoration: InputDecoration(
                                  fillColor: Colors.grey,
                                  filled: true,
                                  contentPadding: EdgeInsets.all(5),
                                  isDense: true,
                                  prefixIcon: Icon(Icons.chat,
                                      size: dynamicSize(.07),
                                      color: Colors.grey.shade700),
                                  hintText: 'Write Message...',
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                            ),
                          ),
                          SizedBox(width: 3),
                          ///New Message
                          IconButton(
                              onPressed: () {
                                if (massage.text.isEmpty) {

                                } else {
                                  sendMassage("${widget.userId}");
                                  massage.text = '';
                                  DataController.dc.sendNotification(widget.receiverId,widget.receiverToken);
                                }
                              },
                              icon: Icon(Icons.send,
                                  color: Colors.blue, size: dynamicSize(.09)),
                              splashRadius: dynamicSize(.07))
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }else if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }else{
              return const Center(child: Text('No chat yet'));
            }

          }
        ),
      ),
    );
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  void sendMassage(String userId) async {
    var unique_id = new DateTime.now().millisecondsSinceEpoch.toString() + generateRandomString(8);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('messages')
        .doc('chat')
        .collection(widget.receiverId)
        .doc(unique_id)
        .set({
      'receiverId': widget.receiverId,
      'senderId': widget.userId,
      'message': massage.text.toString(),
      'timeStamp': DateTime.now().millisecondsSinceEpoch,
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.receiverId)
        .collection('messages')
        .doc('chat')
        .collection(userId)
        .doc(unique_id)
        .set({
      'receiverId': widget.receiverId,
      'senderId': widget.userId,
      'message': massage.text.toString(),
      'timeStamp': DateTime.now().millisecondsSinceEpoch,
    });
    getMassageData();
  }

  int getSender(String senderId) {

        if(senderId == widget.userId ) {
          return 1;
        }
        else{
          return 2;
        }
  }
}
