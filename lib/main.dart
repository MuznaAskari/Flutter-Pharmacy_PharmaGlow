import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pharma_glow/authentication/authentication_epository.dart';
import 'package:pharma_glow/firebase_options.dart';
import 'package:pharma_glow/views/splash-screen-logo/splash.dart';
import 'Login.dart';
import 'Sign-up.dart';
import 'Prescription.dart';
import 'consts/styles.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(PharmaGlow());
}

class PharmaGlow extends StatefulWidget {
  const PharmaGlow({Key? key}) : super(key: key);

  @override
  State<PharmaGlow> createState() => _PharmaGlowState();
}

class _PharmaGlowState extends State<PharmaGlow> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent),
        fontFamily: regular,
      ),
      home: SplashScreen(),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     actions: [
    //       IconButton(
    //           onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));},
    //           icon: Icon(Icons.login)),
    //
    //     IconButton(
    //         onPressed: (){
    //           AuthenticationRepository.instance.logout();
    //         },
    //         icon: Icon(Icons.logout)),
    //   ],
    //   ),
    //   body: ElevatedButton(
    //     onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Prescription_Upload()));},
    //     child: Text(
    //       "Prescription",
    //     ),
    //   ),
    // );
  }
}

