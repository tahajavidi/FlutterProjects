import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WelcomeController extends GetxController {
  final _box = GetStorage();
  final _isDarkMode = false.obs;

  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    _isDarkMode.value = _box.read('isDarkMode') ?? false;
    super.onInit();
  }

  void toggleTheme(bool isDark) {
    _isDarkMode.value = isDark;
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    _box.write('isDarkMode', isDark);
  }
}
