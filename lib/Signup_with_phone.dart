import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_glow/Controller/signup_controller.dart';
import 'package:pharma_glow/Controller/Otp_controller.dart';
import 'package:pharma_glow/Login.dart';
import 'package:pharma_glow/OTP_Screen.dart';
import 'authentication/authentication_epository.dart';

class Signup_phone extends StatefulWidget {
  const Signup_phone({Key? key}) : super(key: key);

  @override
  State<Signup_phone> createState() => _Signup_phoneState();
}

class _Signup_phoneState extends State<Signup_phone> {
  final controller = Get.put(SignupController());
  final _SignupformKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

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
                    key: _SignupformKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/otp_gif.gif'),
                        TextFormField(
                          controller: controller.phoneNo,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: '+92 ----------',
                            icon: Icon(Icons.phone),
                          ),
                        ),


                        SizedBox(height: 100, width: 100,),

                        InkWell(
                          onTap: () {
                            if (_SignupformKey.currentState != null && _SignupformKey.currentState!.validate()){
                              SignupController.instance.phoneAuthentication(controller.phoneNo.text.trim());
                              Get.to(() => const OTP_Screen());
                            }
                          },
                          child: Container(
                            width: 300,
                            height: 50,
                            child: Center(
                              child: Text(
                                'SIGN UP with Phone No.',
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


