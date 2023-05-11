import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_glow/Login.dart';
import 'package:pharma_glow/Sign-up.dart';
import 'package:pharma_glow/authentication/exception/signup_email_passwor_failure.dart';
import 'package:pharma_glow/main.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 6));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => LoginScreen())
        : Get.offAll(() => PharmaGlow());
  }
 Future <void> createUserWithEmailAndPassword(String email, String password) async{

   //creates a user
   try {
     await _auth.createUserWithEmailAndPassword(email: email, password: password);
     firebaseUser.value = _auth.currentUser;
     _setInitialScreen(firebaseUser.value);
   } on FirebaseAuthException catch (e) {
     // Handle the exception
   } catch (_) {
     // Handle other exceptions
   }
  }
  Future <void> LoginUserWithEmailAndPassword(String email, String password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (firebaseUser.value != null) {
        Get.offAll(() => const PharmaGlow());
      } else{
        Get.to(() => const LoginScreen());
      }
    }on FirebaseAuthException catch(e){
       final ex = SignUpWithEmailAndpasswordFailure.code(e.code);
       print('FIREBASE AUTH EXCEPTION - ${ex.message}');
       throw ex;
    }catch(_){
      const ex = SignUpWithEmailAndpasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }
  Future<void> logout() async {
    await _auth.signOut() ;
    Get.offAll(LoginScreen());
  }
}
