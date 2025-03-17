import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/chat/pages/chat_page.dart';
import 'package:javidcoffee_android_app/features/home/pages/home_page.dart';
import 'package:javidcoffee_android_app/features/search/pages/search_page.dart';
import 'package:javidcoffee_android_app/features/products/pages/products_page.dart';
import 'package:javidcoffee_android_app/view/view_controller.dart';
import 'package:sizer/sizer.dart';

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
    Responsive().init(100.w);

    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Localizations.override(
          context: context,
          locale: const Locale("en"),
          child: Obx(
            () => CurvedNavigationBar(
              items: List.generate(
                viewController.itemIcons.length,
                (index) {
                  return CurvedNavigationBarItem(
                    child: Icon(
                      viewController.itemIcons[index],
                      size: 19.sp,
                      color: index == viewController.selectedIndex.value
                          ? Theme.of(context).colorScheme.secondary
                          : Get.isDarkMode
                              ? Colors.white
                              : Colors.grey.shade900,
                    ),
                    label: viewController.itemLabels[index],
                    labelStyle: TextStyle(
                      fontFamily: "Yekan",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: index == viewController.selectedIndex.value
                          ? Theme.of(context).colorScheme.secondary
                          : Get.isDarkMode
                              ? Colors.white
                              : Colors.grey.shade900,
                    ),
                  );
                },
              ),
              height: 7.5.h,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              backgroundColor: Colors.transparent,
              buttonBackgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHighest,
              index: viewController.selectedIndex.value,
              onTap: (index) {
                viewController.selectedIndex.value = index;

                viewController.pageController.animateToPage(
                  viewController.selectedIndex.value,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// WaterDropNavBar(
//   backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
//   bottomPadding: Responsive.isMobile ? 1.5.h : 1.h,
//   iconSize: Responsive.isMobile ? 22.sp : 20.sp,
//   inactiveIconColor:
//       Theme.of(context).colorScheme.secondaryContainer,
//   onItemSelected: (index) {
//     viewController.selectedIndex.value = index;

//     viewController.pageController.animateToPage(
//       viewController.selectedIndex.value,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.ease,
//     );
//   },
//   selectedIndex: viewController.selectedIndex.value,
//   barItems: [
//     BarItem(
//       filledIcon: Icons.home_rounded,
//       outlinedIcon: Icons.home_outlined,
//     ),
//     BarItem(
//       filledIcon: Icons.search_rounded,
//       outlinedIcon: Icons.search_outlined,
//     ),
//     BarItem(
//       filledIcon: Icons.dashboard_rounded,
//       outlinedIcon: Icons.dashboard_outlined,
//     ),
//     BarItem(
//       filledIcon: Icons.chat_rounded,
//       outlinedIcon: Icons.chat_outlined,
//     ),
//   ],
// ),
