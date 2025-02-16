import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/chat/pages/chat_page.dart';
import 'package:javidcoffee_android_app/features/home/pages/home_page.dart';
import 'package:javidcoffee_android_app/features/search/pages/search_page.dart';
import 'package:javidcoffee_android_app/features/products/pages/products_page.dart';
import 'package:javidcoffee_android_app/view/view_controller.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final ViewController viewController = Get.put(ViewController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (Responsive.isMobile(context)) {
      return Scaffold(
        body: PageView(
          controller: viewController.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const HomePage(),
            const SearchPage(),
            const ProductsPage(),
            const ChatPage(),
          ],
        ),
        bottomNavigationBar: Localizations.override(
          context: context,
          locale: const Locale("en"),
          child: Obx(
            () => WaterDropNavBar(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              bottomPadding: 10.0,
              inactiveIconColor:
                  Theme.of(context).colorScheme.secondaryContainer,
              onItemSelected: (index) {
                viewController.selectedIndex.value = index;
                viewController.pageController.animateToPage(
                  viewController.selectedIndex.value,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
              selectedIndex: viewController.selectedIndex.value,
              barItems: [
                BarItem(
                  filledIcon: Icons.home_rounded,
                  outlinedIcon: Icons.home_outlined,
                ),
                BarItem(
                  filledIcon: Icons.search_rounded,
                  outlinedIcon: Icons.search_outlined,
                ),
                BarItem(
                  filledIcon: Icons.dashboard_rounded,
                  outlinedIcon: Icons.dashboard_outlined,
                ),
                BarItem(
                  filledIcon: Icons.chat_rounded,
                  outlinedIcon: Icons.chat_outlined,
                ),
              ],
            ),
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
