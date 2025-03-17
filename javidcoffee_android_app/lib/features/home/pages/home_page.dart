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
import 'package:sizer/sizer.dart';

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
    Responsive().init(100.w);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Responsive.isTablet ? 70 : null,
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
                effects: [const FadeEffect(delay: Duration(milliseconds: 100))],
                child: Responsive.isMobile
                    ? FilledButton.tonalIcon(
                        onPressed: () => Get.toNamed(AdminPanelPage.routeName),
                        label: Text(
                          "پنل مدیریت",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5.sp,
                          ),
                        ),
                        icon: Icon(
                          Icons.person_rounded,
                          size: 18.5.sp,
                        ),
                      )
                    : Row(
                        spacing: 10,
                        children: [
                          IconButton.filledTonal(
                            onPressed: () =>
                                Get.toNamed(AdminPanelPage.routeName),
                            icon: Icon(
                              Icons.person_rounded,
                              size: 17.sp,
                            ),
                          ),
                          Text(
                            "پنل مدیریت",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.5.sp,
                            ),
                          ),
                        ],
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
                effects: [const FadeEffect(delay: Duration(milliseconds: 100))],
                child: FilledButton.tonalIcon(
                  style: Responsive.isTablet
                      ? FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: 0.8.h,
                            horizontal: 2.w,
                          ),
                        )
                      : null,
                  onPressed: () => Get.toNamed(ProfilePage.routeName),
                  label: Text(
                    homeController.userData["name"].toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Responsive.isMobile ? 15.5.sp : 16.5.sp,
                      fontFamily: "",
                    ),
                  ),
                  icon: Icon(
                    Icons.person_rounded,
                    size: Responsive.isMobile ? 18.5.sp : 19.5.sp,
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
              padding: EdgeInsets.symmetric(horizontal: 2.5.w),
              child: IconButton.filledTonal(
                onPressed: () => homeController.logoutUser(),
                icon: Icon(
                  Icons.logout_rounded,
                  size: 18.sp,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 2.h,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 1.h),
              width: 100.w,
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
                      viewportFraction: Responsive.isMobile ? 1.0 : 0.7,
                    ),
                    SizedBox(height: 1.h),
                    HomeSliderIndicator(
                      currentBanner: homeController.currentBanner.value,
                      homeController: homeController,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              spacing: 2.h,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                      child: Text(
                        "دستگاه قهوه ساز",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp,
                        ),
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
                          height: Responsive.isMobile ? 170 : 300,
                          width: 100.w,
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
                const Divider(thickness: 3),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                      child: Text(
                        "دانه قهوه",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () {
                    if (homeController.isLoadingCoffees.value) {
                      return Animate(
                        effects: [
                          const ShimmerEffect(
                            delay: Duration(milliseconds: 100),
                            duration: Duration(milliseconds: 300),
                            blendMode: BlendMode.overlay,
                          ),
                        ],
                        child: Container(
                          height: Responsive.isMobile ? 170 : 300,
                          width: 100.w,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                    return ProductCarousel(
                      snapshot: homeController.coffees,
                    );
                  },
                ),
                const Divider(thickness: 3),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                      child: Text(
                        "قطعات و لوازم جانبی",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp,
                        ),
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
                          height: Responsive.isMobile ? 170 : 300,
                          width: 100.w,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                    return ProductCarousel(
                      snapshot: homeController.parts,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
