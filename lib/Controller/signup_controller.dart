import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_glow/authentication/authentication_epository.dart';


class SignupController extends GetxController{
      static SignupController get instance => Get.find();

      final email = TextEditingController();
      final password = TextEditingController();
      final fullName = TextEditingController();

      void registerUser(String email, String password){
            AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
      }
      void LoginUser(String email, String password){
            AuthenticationRepository.instance.LoginUserWithEmailAndPassword(email, password);
      }
      void LogoutUser(){
            AuthenticationRepository.instance.logout();
      }
}