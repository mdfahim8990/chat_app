import 'package:chat_app/Chat/Chat_list_page.dart';
import 'package:chat_app/Registration_page.dart';
import 'package:chat_app/public_variables/size_config.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color:Colors.black, fontSize: dynamicSize(.05)),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Login\n',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: dynamicSize(.09))),
                            TextSpan(
                              text: 'Password !',
                              style: TextStyle(
                                fontSize: dynamicSize(0.07),
                              ),
                            ),
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
                    SizedBox(height: dynamicSize(.06)),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: dynamicSize(0.08)),
                        child: ElevatedButton(
                          onPressed: () {

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const ChatList()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('Login',
                                    style: TextStyle(fontSize: dynamicSize(0.05))),
                              )
                            ],
                          ),
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8,top: 10),
                      child: Expanded(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Container(
                                //height: dynamicSize(0.12),
                                child: Text("Don't have any account?")
                              ),
                              TextButton(onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => const RegistrationPage()));

                              }, child: Text("SignUp")),
                            ],
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
