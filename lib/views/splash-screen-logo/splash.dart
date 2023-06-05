import 'package:pharma_glow/consts/consts.dart';
import 'package:pharma_glow/views/home_page/home_page.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  changeScreen(){
  Future.delayed(const Duration(seconds:5),(){
  Get.to(()=>HomePage());
  });
  }
  @override
  void initState(){
    changeScreen();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001D66),
      body: Center(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(logo, width: 300),
            ],
          ),
        ),
      ),
    );
  }
}

