import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pharma_glow/Splash_Screen_Design/fade_in_animation_model.dart';

import '../Controller/Splash_screen_controller.dart';

class animationModel extends StatelessWidget {
  animationModel({Key? key, required this.durationInMs, required this.animatePosition, required this.child}) : super(key: key);

  final SplashController = Get.put(SplashScreenController());
  final int durationInMs;
  final TAnimatePosition? animatePosition;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF001D66),
      body: Stack(
        children: [
          Obx(() => AnimatedPositioned(
              child: AnimatedOpacity(
                opacity: SplashController.animate.value ? 1 : 0 ,
                duration: Duration(milliseconds: durationInMs,) ,
                child: child,
              ),
              duration: Duration(milliseconds: durationInMs),
              top: SplashController.animate.value ? animatePosition!.topAfter : animatePosition!.topBefore,
              left: SplashController.animate.value ? animatePosition!.leftAfter : animatePosition!.leftBefore,
              bottom: SplashController.animate.value ? animatePosition!.bottomBefore : animatePosition!.bottomAfter,
              right: SplashController.animate.value ? animatePosition!.rightBefore : animatePosition!.rightAfter,
          )),
        ],
      ),
    );
  }
}
