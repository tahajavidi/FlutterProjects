import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/auth/components/auth_field.dart';
import 'package:javidcoffee_android_app/features/auth/controllers/login_controller.dart';
import 'package:javidcoffee_android_app/features/auth/pages/forgot_page.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Responsive().init(100.w);

    return Sizer(
      builder: (p0, p1, p2) => Scaffold(
        body: Obx(
          () => Center(
            child: loginController.loginLoading.value == false
                ? SingleChildScrollView(
                    child: Column(
                      spacing: Responsive.isMobile ? 8.h : 10.h,
                      children: [
                        FadeInDown(
                          animate: true,
                          delay: const Duration(milliseconds: 300),
                          duration: const Duration(milliseconds: 800),
                          child: Text(
                            "دوست عزیز\nلطفا به حساب خود وارد شوید!",
                            style: TextStyle(
                                fontSize: 19.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        FadeInUp(
                          animate: true,
                          delay: const Duration(milliseconds: 300),
                          duration: const Duration(milliseconds: 800),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Responsive.isMobile ? 8.w : 16.w,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AuthField(
                                  controller: loginController.emailController,
                                  labelText: "آدرس ایمیل",
                                  suffixIcon:
                                      const Icon(FontAwesomeIcons.envelope),
                                  obscureText: false,
                                ),
                                SizedBox(height: 2.h),
                                AuthField(
                                  controller:
                                      loginController.passwordController,
                                  labelText: "رمز عبور",
                                  suffixIcon: IconButton(
                                    onPressed: loginController.toggleHidePass,
                                    icon: loginController.isHidePass.value
                                        ? const Icon(FontAwesomeIcons.eye)
                                        : const Icon(FontAwesomeIcons.eyeSlash),
                                  ),
                                  obscureText: loginController.isHidePass.value,
                                ),
                                SizedBox(
                                    height: Responsive.isTablet ? 10.h : 8.h),
                                SizedBox(
                                  height: 7.h,
                                  width: Responsive.isTablet ? 60.w : 80.w,
                                  child: FilledButton(
                                    onPressed: loginController.loginUser,
                                    child: Center(
                                      child: Text(
                                        "ورود",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Responsive.isMobile
                                              ? 20.sp
                                              : 18.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 3.3.h),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Get.toNamed(ForgotPage.routeName);
                                    },
                                    child: Text(
                                      "رمز عبور خود را فراموش کرده اید؟",
                                      style: TextStyle(
                                        fontSize:
                                            Responsive.isTablet ? 15.sp : 16.sp,
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
                                      Text(
                                        "حساب کاربری ندارید؟",
                                        style: TextStyle(
                                          fontSize: Responsive.isMobile
                                              ? 14.sp
                                              : 13.sp,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                          textBaseline:
                                              TextBaseline.ideographic,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          "ثبت نام کنید",
                                          style: TextStyle(
                                            fontSize: Responsive.isMobile
                                                ? 16.sp
                                                : 15.sp,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                            textBaseline:
                                                TextBaseline.ideographic,
                                            overflow: TextOverflow.fade,
                                            decoration:
                                                TextDecoration.underline,
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
      ),
    );
  }
}
