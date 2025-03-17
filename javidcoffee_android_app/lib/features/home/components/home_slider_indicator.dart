import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/features/home/controllers/home_controller.dart';
import 'package:sizer/sizer.dart';

class HomeSliderIndicator extends StatelessWidget {
  final HomeController homeController;
  final int currentBanner;

  const HomeSliderIndicator({
    super.key,
    required this.homeController,
    required this.currentBanner,
  });

  @override
  Widget build(BuildContext context) {
    Responsive().init(100.w);

    return Animate(
      effects: [const FadeEffect(delay: Duration(milliseconds: 100))],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: homeController.sliderBanners.asMap().entries.map((entry) {
          return Container(
            width: Responsive.isMobile
                ? currentBanner == entry.key
                    ? 5.w
                    : 2.2.w
                : currentBanner == entry.key
                    ? 3.w
                    : 1.5.w,
            height: Responsive.isMobile ? 2.2.w : 1.5.w,
            margin: EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: Responsive.isMobile ? 4.0 : 7.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(
                    alpha: currentBanner == entry.key ? 0.9 : 0.3,
                  ),
              borderRadius: BorderRadius.circular(50),
            ),
          );
        }).toList(),
      ),
    );
  }
}
