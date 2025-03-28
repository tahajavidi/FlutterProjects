import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/features/home/components/slider_banner.dart';
import 'package:javidcoffee_android_app/features/home/controllers/home_controller.dart';
import 'package:sizer/sizer.dart';

class HomeSlider extends StatelessWidget {
  final HomeController homeController;
  final void Function(int) onPageChanged;
  final double viewportFraction;

  const HomeSlider({
    super.key,
    required this.homeController,
    required this.onPageChanged,
    required this.viewportFraction,
  });

  @override
  Widget build(BuildContext context) {
    Responsive().init(100.w);

    return Animate(
      effects: [const FadeEffect(delay: Duration(milliseconds: 100))],
      child: CarouselSlider(
        carouselController: homeController.carouselController,
        items: homeController.sliderBanners
            .map(
              (url) => SliderBanner(bannerUrl: url.bannerUrl),
            )
            .toList(),
        options: CarouselOptions(
          height: Responsive.isMobile ? 28.h : 30.h,
          viewportFraction: viewportFraction,
          autoPlay: true,
          onPageChanged: (index, reason) => onPageChanged(index),
          enlargeCenterPage: true,
        ),
      ),
    );
  }
}
