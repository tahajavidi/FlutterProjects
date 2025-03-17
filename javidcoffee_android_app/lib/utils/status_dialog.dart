import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class StatusDialog {
  void showError(String message) {
    var showError = GetSnackBar(
      duration: const Duration(seconds: 6),
      mainButton: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.close, color: Colors.white),
      ),
      padding: const EdgeInsets.all(5.0),
      snackPosition: SnackPosition.BOTTOM,
      titleText: Center(
        child: Text(
          "خطا",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
            fontFamily: "IranianSans",
          ),
        ),
      ),
      messageText: Center(
        child: Text(
          message,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Vazir",
            color: Colors.white,
          ),
        ),
      ),
    );

    Get.showSnackbar(showError);
  }

  void showSuccess(String message) {
    var showSuccess = GetSnackBar(
      duration: const Duration(seconds: 6),
      mainButton: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.close, color: Colors.white),
      ),
      padding: const EdgeInsets.all(5.0),
      snackPosition: SnackPosition.BOTTOM,
      titleText: Center(
        child: Center(
          child: Text(
            "موفق",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.green,
              fontFamily: "IranianSans",
            ),
          ),
        ),
      ),
      messageText: Center(
        child: Text(
          message,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Vazir",
            color: Colors.white,
          ),
        ),
      ),
    );

    Get.showSnackbar(showSuccess);
  }

  void showWarning(String message) {
    var showWarning = GetSnackBar(
      mainButton: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.close, color: Colors.white),
      ),
      padding: const EdgeInsets.all(5.0),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 6),
      titleText: Center(
        child: Text(
          "هشدار",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
            fontFamily: "IranianSans",
          ),
        ),
      ),
      messageText: Center(
        child: Text(
          message,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Vazir",
            color: Colors.white,
          ),
        ),
      ),
    );

    Get.showSnackbar(showWarning);
  }
}
