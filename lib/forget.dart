import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pkquiz/login.dart';

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  var firebaseAuth = FirebaseAuth.instance;

  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              height: height - 100,
              padding: const EdgeInsets.all(10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text(
                      "Welcome to",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.blue,
                          fontFamily: "times new roman",
                          fontWeight: FontWeight.bold),
                    ),
                    Center(
                      child: SizedBox(
                          width: 250,
                          height: 250,
                          child: Image.asset('assets/images/splace1.jfif')),
                    ),
                    Column(
                      children: [
                        CustomTextField(
                          controller: emailController,
                          labelText: "Email",
                          hintText: "Enter Email",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(width, 50),
                              backgroundColor: Colors.blue),
                          child: const Text(
                            ' Forget Password ',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            firebaseAuth
                                .sendPasswordResetEmail(
                                    email: emailController.text)
                                .then((value) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Reset Link Send Successfully In your Email Box");
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginDemo()));
                            }).onError((error, stackTrace) {
                              if (error is FirebaseAuthException) {
                                Fluttertoast.showToast(
                                    msg: error.message ?? "error");
                              } else {
                                Fluttertoast.showToast(msg: error.toString());
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ])),
        ),
      ),
    );
  }
}
