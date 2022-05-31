import 'dart:ffi';

import 'package:chat_app/Chat/Chat_list_page.dart';
import 'package:chat_app/Registration_page.dart';
import 'package:chat_app/public_variables/size_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            color: Colors.black, fontSize: dynamicSize(.05)),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Login',
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
                        child: TextFormField(
                          controller: emailController,
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please enter your Email");
                            }
                            if (!RegExp("@gmail.com").hasMatch(value)) {
                              return ("Please Enter valid Email");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email*',
                              hintStyle:
                                  TextStyle(fontSize: dynamicSize(0.04))),
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
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Password is required for login");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("please enter min 6 character password");
                            }
                          },
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password*',
                              hintStyle:
                                  TextStyle(fontSize: dynamicSize(0.04))),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: dynamicSize(.06)),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: dynamicSize(0.08)),
                      child: ElevatedButton(
                        onPressed: () {
                          signIn(emailController.text, passwordController.text);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('Login',
                                  style:
                                      TextStyle(fontSize: dynamicSize(0.05))),
                            )
                          ],
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                    child: Expanded(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                //height: dynamicSize(0.12),
                                child: Text("Don't have any account?")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) =>
                                          const RegistrationPage()));
                                },
                                child: Text("SignUp")),
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
      ),
    ));
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const ChatList())),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
