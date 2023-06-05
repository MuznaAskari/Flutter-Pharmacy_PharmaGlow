import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pharma_glow/Sign-up.dart';
import 'package:pharma_glow/Splash_Screen_Design/fade_in_animation_model.dart';

import '../Controller/Splash_screen_controller.dart';
import 'Signup_with_phone.dart';
import 'Splash_Screen_Design/animation_design.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SplashController = Get.put(SplashScreenController());
    SplashController.startAnimation();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF001D66),
        body: Stack(
          children: [
            animationModel(
              durationInMs: 2000,
              animatePosition: TAnimatePosition(topBefore: 40, topAfter:200,leftAfter: 40, leftBefore: 80),
              child: Column(
                children: [
                  Image.asset(
                    'assets/Pharmacy_Splash_Screen-removebg-preview (1).png',
                    width: 300,
                    // height: 50,
                    // Adjust the fit property as needed
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 200,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Signup_phone()));
                          },
                          style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  width: 2, // the thickness
                                  color: Colors.white// the color of the border
                              ),
                            backgroundColor: Color(0xFF001D66),
                          ),
                          child: Text(
                            "Signup with Phone",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                      ),
                      SizedBox(width: 20,),
                      ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                          },
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                width: 2, // the thickness
                                color: Colors.white// the color of the border
                            ),
                            backgroundColor: Color(0xFF001D66),
                          ),
                          child: Text(
                            "Signup with Email",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                      ),
                    ],
                  ),
                ],
              ),
              )
          ],
        ),
      ),
    );
  }
}