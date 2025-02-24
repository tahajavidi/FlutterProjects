import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/admin/pages/admin_panel_page.dart';
import 'package:javidcoffee_android_app/features/home/components/home_slider.dart';
import 'package:javidcoffee_android_app/features/home/components/home_slider_indicator.dart';
import 'package:javidcoffee_android_app/features/home/components/product_carousel.dart';
import 'package:javidcoffee_android_app/features/home/controllers/home_controller.dart';
import 'package:javidcoffee_android_app/features/profile/pages/profile_page.dart';

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
          title: Obx(
            () {
              if (homeController.isAdmin.value) {
                if (homeController.userData.isEmpty) {
                  return CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.secondary,
                    ),
                  );
                }

                return Animate(
                  effects: [
                    const FadeEffect(delay: Duration(milliseconds: 100))
                  ],
                  child: FilledButton.tonalIcon(
                    onPressed: () => Get.toNamed(AdminPanelPage.routeName),
                    label: const Text(
                      "پنل مدیریت",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    icon: const Icon(
                      Icons.person_rounded,
                      size: 22,
                    ),
                  ),
                );
              } else {
                if (homeController.userData.isEmpty) {
                  return CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.secondary,
                    ),
                  );
                }

                return Animate(
                  effects: [
                    const FadeEffect(delay: Duration(milliseconds: 100))
                  ],
                  child: FilledButton.tonalIcon(
                    onPressed: () => Get.toNamed(ProfilePage.routeName),
                    label: Text(
                      homeController.userData["name"].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        fontFamily: "",
                      ),
                    ),
                    icon: const Icon(
                      Icons.person_rounded,
                      size: 22,
                    ),
                  ),
                );
              }
            },
          ),
          actions: [
            Animate(
              effects: [const FadeEffect(delay: Duration(milliseconds: 100))],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton.filledTonal(
                  onPressed: () => homeController.logoutUser(),
                  icon: const Icon(Icons.logout_rounded),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12.0,
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
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "دستگاه قهوه ساز",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () {
                      if (homeController.isLoadingMachines.value) {
                        return Animate(
                          effects: [
                            const ShimmerEffect(
                              delay: Duration(milliseconds: 100),
                              duration: Duration(milliseconds: 300),
                              blendMode: BlendMode.overlay,
                            ),
                          ],
                          child: Container(
                            height: SizeConfig.screenHeight * 0.22,
                            width: SizeConfig.screenWidth,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }
                      return ProductCarousel(
                        snapshot: homeController.machines,
                      );
                    },
                  ),
                ],
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
