import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_glow/Login.dart';
import 'package:pharma_glow/Sign-up.dart';

class SplashScreenController extends GetxController{
  static SplashScreenController get find => Get.find();
  RxBool animate = false.obs;

  Future startAnimation() async{
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
  }
}