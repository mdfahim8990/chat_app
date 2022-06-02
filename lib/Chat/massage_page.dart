import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../public_variables/size_config.dart';

class MassagePage extends StatefulWidget {
  const MassagePage({Key? key, required this.Name,required this.userId,required this.senderId}) : super(key: key);
  final String Name,userId,senderId;

  @override
  State<MassagePage> createState() => _MassagePageState();

}

class _MassagePageState extends State<MassagePage> {
  CollectionReference chats = FirebaseFirestore.instance.collection("chats");

  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController massage = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("${widget.Name}"),),
          body: Form(
            key:_formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context,index)=>Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: index%2==0
                            ?MainAxisAlignment.start
                            :MainAxisAlignment.end,
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          index%2==0
                              ?CircleAvatar(
                            radius: dynamicSize(.04),
                            child: Icon(Icons.person_sharp,color: Colors.white),
                          ):Container(),
                          SizedBox(width: 10),

                          Container(
                              width: MediaQuery.of(context).size.width*.6,
                              child: Text(
                                'Block G/1, 05/12, Mohammadpur, Mirpur-13, Dhaka 1216',
                                textAlign: index%2==0
                                    ?TextAlign.start:TextAlign.end,
                              )),

                          SizedBox(width: 10),
                          index%2==0
                              ?Container()
                              :CircleAvatar(
                            radius: dynamicSize(.04),
                            child: Icon(Icons.person,color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                ///Message box
                Padding(
                  padding: const EdgeInsets.only(bottom: 5,left: 10,right: 10),
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
                              return ("Enter User Name");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            massage.text = value!;
                          },
                          decoration: InputDecoration(
                              fillColor:Colors.grey,
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
                              isDense: true,
                              prefixIcon: Icon(Icons.chat,
                                  size: dynamicSize(.07),
                                  color: Colors.grey.shade700),
                              hintText: 'Write Message...',

                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(Radius.circular(50))
                              )
                          ),
                        ),
                      ),
                      SizedBox(width: 3),

                      ///New Message
                      IconButton(
                          onPressed: (){
                            if(massage.text.isEmpty){}else{sendMassage("${widget.userId}");}

                          },
                          icon: Icon(Icons.send,color: Colors.blue,size: dynamicSize(.1)),
                          splashRadius: dynamicSize(.07))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),);
  }


  void sendMassage(String userId)async{
    FirebaseFirestore.instance.collection('users').doc(userId).collection('messages').doc('chat').set({
      'id': widget.senderId,
      'message': massage.text.toString(),
      'timeStamp': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
