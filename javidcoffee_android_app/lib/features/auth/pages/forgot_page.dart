import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/auth/components/auth_field.dart';
import 'package:javidcoffee_android_app/features/auth/controllers/forgot_controller.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  static const routeName = "/forgot_password";

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final ForgotController forgotController = Get.put(ForgotController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (Responsive.isMobile(context)) {
      return Scaffold(
        body: Obx(
          () => Center(
            child: forgotController.sendLoading.value == false
                ? SingleChildScrollView(
                    child: Column(
                      spacing: 50,
                      children: [
                        FadeInDown(
                          animate: true,
                          delay: const Duration(milliseconds: 300),
                          duration: const Duration(milliseconds: 800),
                          child: const Text(
                            "دوست عزیز\nاینجا ایمیل خود را وارد کنید!",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        FadeInUp(
                          animate: true,
                          delay: const Duration(milliseconds: 300),
                          duration: const Duration(milliseconds: 800),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.08,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AuthField(
                                  controller: forgotController.emailController,
                                  labelText: "آدرس ایمیل",
                                  suffixIcon:
                                      const Icon(FontAwesomeIcons.envelope),
                                  obscureText: false,
                                ),
                                const SizedBox(height: 60),
                                SizedBox(
                                  height: 55,
                                  width: SizeConfig.screenWidth * 0.8,
                                  child: FilledButton(
                                    onPressed: forgotController.sendEmail,
                                    child: const Center(
                                      child: Text(
                                        "بازنشانی",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "بازگشت به صفحه قبل",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.italic,
                                        textBaseline: TextBaseline.ideographic,
                                        overflow: TextOverflow.fade,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Obx(
          () => Center(
            child: forgotController.sendLoading.value == false
                ? SingleChildScrollView(
                    child: Column(
                      spacing: 60,
                      children: [
                        FadeInDown(
                          animate: true,
                          delay: const Duration(milliseconds: 300),
                          duration: const Duration(milliseconds: 800),
                          child: const Text(
                            "دوست عزیز\nاینجا ایمیل خود را وارد کنید!",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        FadeInUp(
                          animate: true,
                          delay: const Duration(milliseconds: 300),
                          duration: const Duration(milliseconds: 800),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.1,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AuthField(
                                  controller: forgotController.emailController,
                                  labelText: "آدرس ایمیل",
                                  suffixIcon:
                                      const Icon(FontAwesomeIcons.envelope),
                                  obscureText: false,
                                ),
                                const SizedBox(height: 60),
                                SizedBox(
                                  height: 65,
                                  width: SizeConfig.screenWidth * 0.8,
                                  child: FilledButton(
                                    onPressed: forgotController.sendEmail,
                                    child: const Center(
                                      child: Text(
                                        "بازنشانی",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: SizeConfig.screenWidth * 0.05,
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "بازگشت به صفحه قبل",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.italic,
                                          textBaseline:
                                              TextBaseline.ideographic,
                                          overflow: TextOverflow.fade,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const CircularProgressIndicator(),
          ),
        ),
      );
    }
  }
}
