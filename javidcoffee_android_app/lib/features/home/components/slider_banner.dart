import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:sizer/sizer.dart';

class SliderBanner extends StatelessWidget {
  final String bannerUrl;

  const SliderBanner({super.key, required this.bannerUrl});

  @override
  Widget build(BuildContext context) {
    Responsive().init(100.w);

    return Container(
      margin: EdgeInsets.only(
        left: Responsive.isMobile
            ? 1.5.w
            : Responsive.isTablet
                ? 2.w
                : 0.5.w,
        right: Responsive.isMobile
            ? 1.5.w
            : Responsive.isTablet
                ? 2.w
                : 0.5.w,
        top: 1.0.h,
        bottom: 0.8.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0.sp),
        image: DecorationImage(
          image: AssetImage(bannerUrl),
          fit: BoxFit.fill,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(Get.isDarkMode ? 0.3 : 0.6),
            spreadRadius: 2.sp,
            blurRadius: 10.sp,
            offset: const Offset(0, 3),
          )
        ],
      ),
    );
  }
}
