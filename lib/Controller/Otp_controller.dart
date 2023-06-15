import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_glow/authentication/authentication_epository.dart';
import 'package:pharma_glow/main.dart';
import 'package:pharma_glow/views/home_page/home_page.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  Future<void> verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(HomePage()) : Get.back();
  }
}