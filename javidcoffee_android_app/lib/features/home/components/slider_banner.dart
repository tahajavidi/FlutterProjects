import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SliderBanner extends StatelessWidget {
  final String bannerUrl;

  const SliderBanner({super.key, required this.bannerUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 8.0,
        bottom: 15.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage(bannerUrl),
          fit: BoxFit.fill,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(Get.isDarkMode ? 0.3 : 0.6),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
    );
  }
}
