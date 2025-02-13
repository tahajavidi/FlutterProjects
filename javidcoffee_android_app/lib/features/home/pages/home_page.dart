import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/home/components/home_slider.dart';
import 'package:javidcoffee_android_app/features/home/components/home_slider_indicator.dart';
import 'package:javidcoffee_android_app/features/home/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (Responsive.isMobile(context)) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Home"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton.filledTonal(
                onPressed: () => homeController.logoutUser(),
                icon: const Icon(Icons.logout_rounded),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 5.0),
                color: Theme.of(
                  context,
                ).colorScheme.primaryContainer.withValues(alpha: 0.5),
                child: Obx(
                  () => Column(
                    children: [
                      HomeSlider(
                        homeController: homeController,
                        onPageChanged: (index) {
                          homeController.currentBanner.value = index;
                        },
                        viewportFraction: 1.0,
                      ),
                      HomeSliderIndicator(
                        currentBanner: homeController.currentBanner.value,
                        homeController: homeController,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(),
      );
    }
  }
}
