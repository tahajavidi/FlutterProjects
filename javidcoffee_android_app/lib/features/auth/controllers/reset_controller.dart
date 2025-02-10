import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/features/auth/pages/login_page.dart';
import 'package:javidcoffee_android_app/utils/status_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final SupabaseClient supabaseClient = Supabase.instance.client;

  RxBool resetLoading = false.obs;
  RxBool isHidePass = true.obs;

  Future<void> resetPassword() async {
    if (passwordController.text.isNotEmpty) {
      resetLoading.value = true;

      try {
        await supabaseClient.auth.updateUser(
          UserAttributes(
            password: passwordController.text.trim(),
          ),
          emailRedirectTo: "return://javidcoffee.app",
        );

        resetLoading.value = false;

        StatusDialog()
            .showSuccess("بازنشانی با موفقیت انجام شد. لطفا وارد شوید.");

        passwordController.clear();

        Get.until((route) => route.settings.name == LoginPage.routeName);
      } catch (e) {
        resetLoading.value = false;
        StatusDialog().showError("در بازنشانی مشکلی پیش آمد!");
      }
    } else {
      resetLoading.value = false;

      StatusDialog().showWarning("لطفا همه فرم ها را پر کنید!");
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
