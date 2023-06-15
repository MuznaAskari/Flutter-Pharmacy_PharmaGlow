import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_glow/Controller/signup_controller.dart';
import 'package:pharma_glow/Controller/Otp_controller.dart';
import 'package:pharma_glow/Login.dart';
import 'package:pharma_glow/OTP_Screen.dart';
import 'package:pharma_glow/ToastMessage/Utilis.dart';

import 'authentication/authentication_epository.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final controller = Get.put(SignupController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  bool _obscureText = true;
  void _toggle(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue[900],
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: controller.email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'User email',
                                icon: Icon(Icons.mail_outline),
                              ),
                            ),

                            SizedBox(height: 15, ),
                            TextFormField(
                              controller: controller.password,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                hintText: 'User Password',
                                icon: InkWell(
                                  onTap: (){
                                    _toggle();
                                  },
                                    child: Icon(Icons.remove_red_eye_rounded),
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),
                            TextFormField(
                              controller: controller.confirmPassword,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                icon: InkWell(
                                  onTap: (){
                                    _toggle();

                                  },
                                    child: Icon(Icons.remove_red_eye_rounded)
                                ),
                              ),
                            ),

                            SizedBox(height: 15, width: 10,),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                              },
                              child: Text(
                                'Already have an account? Login',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            SizedBox(height: 100, width: 100,),

                            InkWell(
                              onTap: () {
                                if (_formKey.currentState != null && _formKey.currentState!.validate()  ){
                                  SignupController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                                }
                                else{
                                  // Utilis().toastMessage('Password does not match');
                                }
                              },
                              child: Container(
                                width: 300,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'SIGN UP with Email',
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
            ],),
        ),
      ),

    );
  }
}
