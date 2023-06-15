import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pharma_glow/Controller/signup_controller.dart';
import 'package:pharma_glow/Sign-up.dart';
import 'package:get/get.dart';
import 'package:pharma_glow/Signup_with_phone.dart';
import 'package:pharma_glow/Splash%20Screen.dart';
import 'package:pharma_glow/views/home_page/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(SignupController());
  final _LoginformKey = GlobalKey <FormState> ();
  bool _obscureText = true;
  void toggle(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                SizedBox(height: 55,),
                Container(
                  height: 150,
                  width: 150,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/logo_symbol.png'),
                  ),
                ),
                 Container(
                    height: 600,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child:  Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                            Form(
                              key: _LoginformKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextField(
                                    controller: controller.email,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: 'User email',
                                      icon: Icon(Icons.mail_outline),
                                    ),
                                  ),
                                  SizedBox(height: 10, width: 10,),
                                  TextField(
                                    controller: controller.password,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      hintText: 'User Password',
                                      icon: InkWell(
                                        onTap: (){
                                          toggle();
                                        },
                                        child: Icon(
                                            Icons.remove_red_eye_rounded
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10, width: 10,),
                                  InkWell(
                                    onTap:(){
                                      SignupController.instance.forgetPassword(controller.email.text.trim());
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 100, width: 100,),
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Signup_phone()));
                                    },
                                    child: Text(
                                      'Login with phone?',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  InkWell(
                                    onTap: () {
                                      print(_LoginformKey.currentState);
                                      if(_LoginformKey.currentState!= null && _LoginformKey.currentState!.validate()){
                                        SignupController.instance.LoginUser(controller.email.text.trim(), controller.password.text.trim());
                                      }
                                    },
                                    child: Container(
                                      width: 300,
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          'LOGIN',
                                          style: TextStyle(
                                            fontFamily: 'Alkatra',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors. white,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Colors.blue[900]!,
                                            Colors.greenAccent,
                                          ],
                                      ),
                                    ),
                                  ),
                                  ),
                                  SizedBox(height: 20,),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SplashScreen()));
                                    },
                                    child: Container(
                                      width: 300,
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          'SIGNUP',
                                          style: TextStyle(
                                            fontFamily: 'Alkatra',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors. white,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Colors.blue[900]!,
                                            Colors.greenAccent,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ),
                        ),
                    ],
          ),
        ),
      ),
    );
  }
}