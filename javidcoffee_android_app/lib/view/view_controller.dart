import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewController extends GetxController {
  final PageController pageController = PageController();

  RxInt selectedIndex = 0.obs;
  RxList itemIcons = [
    Icons.home_rounded,
    Icons.search_rounded,
    Icons.dashboard_rounded,
    Icons.chat_rounded,
  ].obs;
  RxList itemLabels = [
    "خانه",
    "جستجو",
    "محصولات",
    "هوش مصنوعی",
  ].obs;
}
