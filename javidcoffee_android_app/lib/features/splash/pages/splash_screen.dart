import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Responsive().init(100.w);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/animations/Animation - 1727624280826.json",
              fit: BoxFit.fill,
              height: 80.w,
              width: 80.w,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: GradientText(
                "قهوه جاوید",
                colors: [
                  Colors.blue,
                  Colors.red,
                  Colors.teal,
                ],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "IranianSans",
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ).animate().fade(delay: const Duration(milliseconds: 500)),
            ),
          ],
        ),
      ),
    );
  }
}
