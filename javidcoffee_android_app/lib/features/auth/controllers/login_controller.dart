import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/features/home/controllers/home_controller.dart';
import 'package:javidcoffee_android_app/utils/status_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  final SupabaseClient supabaseClient = Supabase.instance.client;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final HomeController homeController = Get.find<HomeController>();

  RxBool isHidePass = true.obs;
  RxBool loginLoading = false.obs;

  void toggleHidePass() {
    isHidePass.value = !isHidePass.value;
  }

  Future<void> loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      loginLoading.value = true;

      try {
        final response = await supabaseClient.auth.signInWithPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (response.user != null) {
          await homeController.getIsAdmin();
        }

        loginLoading.value = false;

        Get.back();

        StatusDialog().showSuccess("ورود با موفقیت انجام شد.");

        emailController.clear();
        passwordController.clear();
      } catch (e) {
        loginLoading.value = false;

        StatusDialog().showError("در ورود مشکلی پیش آمد!");
      }
    } else {
      loginLoading.value = false;

      StatusDialog().showWarning("لطفا همه فرم ها را پر کنید!");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
