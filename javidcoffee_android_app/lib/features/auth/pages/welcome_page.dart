import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/auth/controllers/welcome_controller.dart';
import 'package:javidcoffee_android_app/features/auth/pages/login_page.dart';
import 'package:javidcoffee_android_app/features/auth/pages/register_page.dart';
import 'package:javidcoffee_android_app/utils/status_dialog.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  static const routeName = "/welcome";

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final WelcomeController welcomeController = Get.put(WelcomeController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Responsive().init(100.w);

    return Scaffold(
      appBar: kIsWeb
          ? AppBar(
              titleSpacing: 1.5.w,
              title: Text(
                "قهوه جاوید",
                style: TextStyle(
                    fontSize: Responsive.isMobile
                        ? 20.sp
                        : Responsive.isTablet
                            ? 19.sp
                            : 15.sp),
              ),
              centerTitle: false,
              actions: [
                Obx(
                  () => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                    child: Row(
                      spacing: 0.7.w,
                      children: [
                        Icon(
                          Icons.light_mode_rounded,
                          size: Responsive.isMobile
                              ? 21.sp
                              : Responsive.isTablet
                                  ? 19.sp
                                  : 16.5.sp,
                        ),
                        Transform.scale(
                          scale: Responsive.isMobile
                              ? 4.sp
                              : Responsive.isTablet
                                  ? 3.4.sp
                                  : 2.8.sp,
                          child: Switch(
                            value: welcomeController.isDarkMode,
                            onChanged: (value) {
                              welcomeController.toggleTheme(value);
                            },
                          ),
                        ),
                        Icon(
                          Icons.dark_mode_rounded,
                          size: Responsive.isMobile
                              ? 21.sp
                              : Responsive.isTablet
                                  ? 19.sp
                                  : 16.5.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : null,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInUp(
                    animate: true,
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(seconds: 1),
                    child: CircleAvatar(
                      radius: Responsive.isMobile ? 35.sp : 32.sp,
                      backgroundImage:
                          const AssetImage("assets/icon/AppIcon.jpeg"),
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  FadeInUp(
                    animate: true,
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(seconds: 1),
                    child: Text(
                      "سلام دوست عزیز\nخوش آمدید",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Responsive.isTablet ? 18.sp : 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.isTablet ? 8.h : 12.h),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeIn(
                        animate: true,
                        delay: const Duration(milliseconds: 500),
                        duration: const Duration(seconds: 1),
                        child: SizedBox(
                          height: 7.h,
                          width: Responsive.isMobile ? 80.w : 65.w,
                          child: FilledButton.tonal(
                            onPressed: () {
                              Get.toNamed(LoginPage.routeName);
                            },
                            child: Center(
                              child: Text(
                                "ورود",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.5.h),
                      FadeIn(
                        animate: true,
                        delay: const Duration(milliseconds: 500),
                        duration: const Duration(seconds: 1),
                        child: SizedBox(
                          height: 7.h,
                          width: Responsive.isMobile ? 80.w : 65.w,
                          child: FilledButton(
                            onPressed: () {
                              Get.toNamed(RegisterPage.routeName);
                            },
                            child: Center(
                              child: Text(
                                "ثبت نام",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
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
          Positioned(
            bottom: 40,
            width: 100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 8.w,
              children: [
                IconButton.filled(
                  onPressed: () async {
                    final contact = "+989171282707";
                    final androidUrl =
                        "whatsapp://send?phone=$contact&text=Hi, I need some help";
                    final iosUrl =
                        "https://wa.me/$contact?text=${Uri.parse("Hi, I need some help")}";
                    final isWeb =
                        "https://web.whatsapp.com/send?phone=$contact&text=${Uri.parse("Hi, I need some help")}";
    
                    try {
                      if (kIsWeb) {
                        await launchUrl(Uri.parse(isWeb));
                      } else {
                        if (Platform.isIOS) {
                          await launchUrl(Uri.parse(iosUrl));
                        } else {
                          await launchUrl(Uri.parse(androidUrl));
                        }
                      }
                    } catch (e) {
                      if (kDebugMode) {
                        print(e.toString());
                      }
                      StatusDialog().showError("واتساپ نصب نشده است!");
                    }
                  },
                  icon: Icon(FontAwesomeIcons.whatsapp,
                      size: Responsive.isTablet ? 25.sp : 26.sp),
                ),
                IconButton.filled(
                  onPressed: () {},
                  icon: Icon(FontAwesomeIcons.instagram,
                      size: Responsive.isTablet ? 25.sp : 26.sp),
                ),
                IconButton.filled(
                  onPressed: () {},
                  icon: Icon(FontAwesomeIcons.envelope,
                      size: Responsive.isTablet ? 25.sp : 26.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
