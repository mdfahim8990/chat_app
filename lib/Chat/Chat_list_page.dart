import 'package:chat_app/Chat/massage_page.dart';
import 'package:chat_app/public_variables/size_config.dart';
import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("Chat List")),
      body: _buildListView(),
    ));
  }

  ListView _buildListView(){
    return ListView.builder(
      itemCount: 10,
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
                  boxShadow: [
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
                      "Fahim $index",
                      style: TextStyle(
                        fontSize: dynamicSize(0.05),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0,left: 8),
                    child: Text(
                      "Have some new massage",
                      style: TextStyle(
                        fontSize: dynamicSize(0.03),),
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>  MassagePage(index: index,)));
          },
        );
      },
    );
  }
}
