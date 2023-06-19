import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_glow/Login.dart';
import 'package:pharma_glow/Prescription.dart';
import 'package:pharma_glow/Sign-up.dart';
import 'package:pharma_glow/ToastMessage/Utilis.dart';
import 'package:pharma_glow/authentication/exception/signup_email_passwor_failure.dart';
import 'package:pharma_glow/main.dart';
import 'package:pharma_glow/views/home_page/home_page.dart';
import 'package:pharma_glow/views/splash-screen-logo/splash.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId =''.obs;

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
        : Get.offAll(() => SplashScreen());
  }
  // _setInitialScreen(User? user) {
  //   Get.offAll(()=> HomePage());
  //   user == null
  //       ? Get.offAll(() => LoginScreen())
  //       : Get.offAll(() => HomePage());
  //   if (user != null) {
  //     Get.offAll(() => HomePage());
  //   }
  // }

  // phone authentication code
  Future<void> phoneAuthentication(String phoneNo) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The provided phone number is not valid.');
          } else {
            Get.snackbar('Error', 'Something went wrong. Please try again.');
          }
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }

// OTP verification code
  Future<bool> verifyOTP(String otp) async {
    try {
      var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: this.verificationId.value,
          smsCode: otp,
        ),
      );
      return credentials.user != null;
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify OTP. Please try again.');
      return false;
    }
  }

 Future <void> createUserWithEmailAndPassword(String email, String password) async{

   //creates a user
   try {
     await _auth.createUserWithEmailAndPassword(email: email, password: password);
     firebaseUser.value = _auth.currentUser;
   //   if (firebaseUser.value != null) {
   //     Get.offAll(() =>  HomePage());
   //   }
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
        Get.offAll(() => HomePage());
      } else{
        Get.to(() => const LoginScreen());
      }
    }on FirebaseAuthException catch(e){
       final ex = SignUpWithEmailAndpasswordFailure.code(e.code);
       print('FIREBASE AUTH EXCEPTION - ${ex.message}');
       Utilis().toastMessage('The email is already in use by another account');
       throw ex;
    }catch(_){
      const ex = SignUpWithEmailAndpasswordFailure();
      print('EXCEPTION - ${ex.message}');
      Utilis().toastMessage('${ex.message}');
      throw ex;
    }
  }
  Future<void> logout() async {
    await _auth.signOut() ;
    Get.offAll(LoginScreen());
  }

  // Forget Password
Future<void> ForgetPassword(String email) async{
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      Utilis().toastMessage('Recovery Password has been sent to your email');
    }).onError((error, stackTrace) {
       Utilis().toastMessage(error.toString());
    }
    );
}
}
