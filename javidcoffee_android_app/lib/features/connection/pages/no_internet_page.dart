import 'package:flutter/material.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20.0,
          children: [
            Image.asset(
              "assets/images/no_internet.png",
              height: SizeConfig.screenHeight * 0.2,
              width: SizeConfig.screenWidth * 0.5,
              fit: BoxFit.fill,
              color: Colors.redAccent,
            ),
            const Text(
              "اتصال اینترنت برقرار نیست!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
