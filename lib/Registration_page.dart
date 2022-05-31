import 'package:chat_app/public_variables/size_config.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        children: [
          Container(
            height: dynamicSize(0.5),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/clip_path_shape.png"),
                  //fit:BoxFit.cover
                  alignment: Alignment.topRight),
            ),
          ),
          Column(
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
                      controller: nameController,
                      obscureText: false,
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
                       controller: emailController,
                      obscureText: false,
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
                     controller: passwordController,
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
                       controller: confirmPasswordController,
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
        ],
      ),
    ));
  }
}
