import 'package:chat_app/public_variables/size_config.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                    color:Colors.black, fontSize: dynamicSize(.05)),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Registration\n',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: dynamicSize(.09))),

                ],
              ),
            ),
          ),
          SizedBox(height: dynamicSize(.03)),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Expanded(
              child: Container(
                height: dynamicSize(0.12),
                child: TextField(
                  // controller: DataControllers.to.forgetPasswordMobile.value,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name*',
                      hintStyle: TextStyle(fontSize: dynamicSize(0.04))),
                ),
              ),
            ),
          ),
          SizedBox(height: dynamicSize(.03)),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Expanded(
              child: Container(
                height: dynamicSize(0.12),
                child: TextField(
                  // controller: DataControllers.to.forgetPasswordMobile.value,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email*',
                      hintStyle: TextStyle(fontSize: dynamicSize(0.04))),
                ),
              ),
            ),
          ),
          SizedBox(height: dynamicSize(.03)),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Expanded(
              child: Container(
                height: dynamicSize(0.12),
                child: TextField(
                  // controller: DataControllers.to.forgetPasswordMobile.value,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password*',
                      hintStyle: TextStyle(fontSize: dynamicSize(0.04))),
                ),
              ),
            ),
          ),
          SizedBox(height: dynamicSize(.03)),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Expanded(
              child: Container(
                height: dynamicSize(0.12),
                child: TextField(
                  // controller: DataControllers.to.forgetPasswordMobile.value,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ' Confirm Password*',
                      hintStyle: TextStyle(fontSize: dynamicSize(0.04))),
                ),
              ),
            ),
          ),
          SizedBox(height: dynamicSize(.06)),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: dynamicSize(0.08)),
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Submit',
                          style: TextStyle(fontSize: dynamicSize(0.05))),
                    )
                  ],
                ),
              )
          ),

        ],
      ),
    ));
  }
}
