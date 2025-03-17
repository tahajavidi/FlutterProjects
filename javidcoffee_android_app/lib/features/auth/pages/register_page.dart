import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/auth/components/auth_field.dart';
import 'package:javidcoffee_android_app/features/auth/controllers/register_controller.dart';
import 'package:javidcoffee_android_app/features/policy/pages/policy_page.dart';
import 'package:sizer/sizer.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const routeName = "/register";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Responsive().init(100.w);

    return Scaffold(
      body: Obx(
        () => Center(
          child: registerController.registerLoading.value == false
              ? SingleChildScrollView(
                  child: Column(
                    spacing: 50,
                    children: [
                      FadeInDown(
                        animate: true,
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(milliseconds: 800),
                        child: const Text(
                          "دوست عزیز\nلطفا یک حساب بسازید!",
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
                                controller: registerController.nameController,
                                labelText: "نام کاربری",
                                suffixIcon: const Icon(FontAwesomeIcons.user),
                                obscureText: false,
                                maxLength: 10,
                              ),
                              const SizedBox(height: 20),
                              AuthField(
                                controller: registerController.emailController,
                                labelText: "آدرس ایمیل",
                                suffixIcon:
                                    const Icon(FontAwesomeIcons.envelope),
                                obscureText: false,
                              ),
                              const SizedBox(height: 20),
                              AuthField(
                                controller:
                                    registerController.passwordController,
                                labelText: "رمز عبور",
                                suffixIcon: IconButton(
                                  onPressed: registerController.toggleHidePass,
                                  icon: registerController.isHidePass.value
                                      ? const Icon(FontAwesomeIcons.eye)
                                      : const Icon(FontAwesomeIcons.eyeSlash),
                                ),
                                obscureText:
                                    registerController.isHidePass.value,
                              ),
                              const SizedBox(height: 20),
                              AuthField(
                                controller: registerController
                                    .confirmPasswordController,
                                labelText: "تایید رمز عبور",
                                suffixIcon: IconButton(
                                  onPressed: registerController.toggleHideConf,
                                  icon: registerController.isHideConf.value
                                      ? const Icon(FontAwesomeIcons.eye)
                                      : const Icon(FontAwesomeIcons.eyeSlash),
                                ),
                                obscureText:
                                    registerController.isHideConf.value,
                              ),
                              const SizedBox(height: 60),
                              SizedBox(
                                height: 60,
                                width: Responsive.isMobile ? 80.w : 60.w,
                                child: FilledButton(
                                  onPressed: registerController.registerUser,
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
                              const SizedBox(height: 25),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: () {
                                    Get.toNamed(PolicyPage.routeName);
                                  },
                                  child: const Text(
                                    "حریم خصوصی کاربران",
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
                              const SizedBox(height: 7),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "قبلا ثبت نام کرده اید؟",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        textBaseline: TextBaseline.ideographic,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text(
                                        "وارد شوید",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          textBaseline:
                                              TextBaseline.ideographic,
                                          overflow: TextOverflow.fade,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
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
