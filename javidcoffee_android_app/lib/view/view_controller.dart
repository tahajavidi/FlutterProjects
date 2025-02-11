import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewController extends GetxController {
  final PageController pageController = PageController();
  RxInt selectedIndex = 0.obs;
}