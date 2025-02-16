import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/features/home/controllers/home_controller.dart';

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
    return Animate(
      effects: [const FadeEffect(delay: Duration(milliseconds: 100))],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: homeController.sliderBanners.asMap().entries.map((entry) {
          return Container(
            width: Responsive.isTablet(context) ? 13 : 9,
            height: Responsive.isTablet(context) ? 13 : 9,
            margin: const EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 4.0,
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
