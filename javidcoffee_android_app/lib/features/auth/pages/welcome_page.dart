import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/auth/pages/login_page.dart';
import 'package:javidcoffee_android_app/features/auth/pages/register_page.dart';
import 'package:javidcoffee_android_app/utils/status_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  static const routeName = "/welcome";

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (Responsive.isMobile(context)) {
      return Scaffold(
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FadeInUp(
                      animate: true,
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(seconds: 1),
                      child: const CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage("assets/icon/AppIcon.jpeg"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInUp(
                      animate: true,
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(seconds: 1),
                      child: const Text(
                        "سلام دوست عزیز\nخوش آمدید",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FadeIn(
                          animate: true,
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(seconds: 1),
                          child: SizedBox(
                            height: 60,
                            width: SizeConfig.screenWidth * 0.8,
                            child: FilledButton.tonal(
                              onPressed: () {
                                Get.toNamed(LoginPage.routeName);
                              },
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "ورود",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeIn(
                          animate: true,
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(seconds: 1),
                          child: SizedBox(
                            height: 60,
                            width: SizeConfig.screenWidth * 0.8,
                            child: FilledButton(
                              onPressed: () {
                                Get.toNamed(RegisterPage.routeName);
                              },
                              child: const Center(
                                child: Text(
                                  "ثبت نام",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 30,
                  children: [
                    IconButton.filled(
                      onPressed: () async {
                        final contact = "+989171282707";
                        final androidUrl =
                            "whatsapp://send?phone=$contact&text=Hi, I need some help";
                        final iosUrl =
                            "https://wa.me/$contact?text=${Uri.parse("Hi, I need some help")}";

                        try {
                          if (Platform.isIOS) {
                            await launchUrl(Uri.parse(iosUrl));
                          } else {
                            await launchUrl(Uri.parse(androidUrl));
                          }
                        } catch (e) {
                          StatusDialog()
                              .showError("واتساپ نصب نشده است!");
                        }
                      },
                      icon: const Icon(FontAwesomeIcons.whatsapp, size: 40),
                    ),
                    IconButton.filled(
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.instagram, size: 40),
                    ),
                    IconButton.filled(
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.envelope, size: 40),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FadeInUp(
                  animate: true,
                  delay: const Duration(milliseconds: 500),
                  duration: const Duration(seconds: 1),
                  child: const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("assets/icon/AppIcon.jpeg"),
                  ),
                ),
                const SizedBox(height: 25),
                FadeInUp(
                  animate: true,
                  delay: const Duration(milliseconds: 500),
                  duration: const Duration(seconds: 1),
                  child: const Text(
                    "سلام دوست عزیز\nخوش آمدید",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 100),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeIn(
                      animate: true,
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(seconds: 1),
                      child: SizedBox(
                        height: 70,
                        width: SizeConfig.screenWidth * 0.6,
                        child: FilledButton.tonal(
                          onPressed: () {
                            Get.toNamed(LoginPage.routeName);
                          },
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Text(
                                "ورود",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    FadeIn(
                      animate: true,
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(seconds: 1),
                      child: SizedBox(
                        height: 70,
                        width: SizeConfig.screenWidth * 0.6,
                        child: FilledButton(
                          onPressed: () {
                            Get.toNamed(RegisterPage.routeName);
                          },
                          child: const Center(
                            child: Text(
                              "ثبت نام",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 30,
                  children: [
                    IconButton.filled(
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.whatsapp, size: 40),
                    ),
                    IconButton.filledTonal(
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.instagram, size: 40),
                    ),
                    IconButton.filled(
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.envelope, size: 40),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
