import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/auth/components/auth_field.dart';
import 'package:javidcoffee_android_app/features/auth/controllers/forgot_controller.dart';
import 'package:sizer/sizer.dart';

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
    Responsive().init(100.w);

    return Scaffold(
      body: Obx(
        () => Center(
          child: forgotController.sendLoading.value == false
              ? SingleChildScrollView(
                  child: Column(
                    spacing: Responsive.isMobile ? 8.h : 10.h,
                    children: [
                      FadeInDown(
                        animate: true,
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(milliseconds: 800),
                        child: Text(
                          "دوست عزیز\nاینجا ایمیل خود را وارد کنید!",
                          style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FadeInUp(
                        animate: true,
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(milliseconds: 800),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.isTablet ? 16.w : 8.w,
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
                              SizedBox(
                                  height: Responsive.isTablet ? 10.h : 8.h),
                              SizedBox(
                                height: 7.h,
                                width: Responsive.isTablet ? 60.w : 80.w,
                                child: FilledButton(
                                  onPressed: forgotController.sendEmail,
                                  child: Center(
                                    child: Text(
                                      "بازنشانی",
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
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "بازگشت به صفحه قبل",
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
