import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/features/home/components/slider_banner.dart';
import 'package:javidcoffee_android_app/features/home/controllers/home_controller.dart';

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
    return CarouselSlider(
      carouselController: homeController.carouselController,
      items: homeController.sliderBanners
          .map(
            (url) => SliderBanner(bannerUrl: url.bannerUrl),
          )
          .toList(),
      options: CarouselOptions(
        height: Responsive.isTablet(context) ? 280 : 230,
        viewportFraction: viewportFraction,
        autoPlay: true,
        onPageChanged: (index, reason) => onPageChanged(index),
      ),
    ).animate().fade(
          delay: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 700),
          curve: Curves.ease,
        );
  }
}
