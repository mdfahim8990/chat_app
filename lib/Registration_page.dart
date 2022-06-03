
import 'package:chat_app/Login_page.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/public_variables/size_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController = new TextEditingController();


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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            color: Colors.black, fontSize: dynamicSize(.05)),
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
                        child: TextFormField(
                          controller: nameController,
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Enter User Name");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            nameController.text = value!;
                          },
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
                        child: TextFormField(
                          controller: emailController,
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please enter your Email");
                            }
                            if (!RegExp("@").hasMatch(value)) {
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
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{6,}$');
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
                        child: TextFormField(
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (confirmPasswordController.text !=
                                passwordController.text ) {
                              return ("Password Not Match");
                            }
                            return null;
                          },
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
                      padding:
                          EdgeInsets.symmetric(horizontal: dynamicSize(0.08)),
                      child: ElevatedButton(
                        onPressed: () {
                          signUp(emailController.text, passwordController.text);

                        },
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
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    final FirebaseMessaging fcm = FirebaseMessaging.instance;
    final fcmToken = await fcm.getToken();

    UserModel userModel = UserModel();

    userModel.uid = user!.uid;
    userModel.name = nameController.text;
    userModel.email = user.email;
    userModel.token = fcmToken;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap(),SetOptions(merge: true));
    Fluttertoast.showToast(msg: "Account Create Successfully");
    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }
}
