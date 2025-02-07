import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/features/auth/pages/reset_page.dart';
import 'package:javidcoffee_android_app/utils/status_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgotController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final SupabaseClient supabaseClient = Supabase.instance.client;

  RxBool sendLoading = false.obs;

  Future<void> sendEmail() async {
    if (emailController.text.isNotEmpty) {
      sendLoading.value = true;

      try {
        await supabaseClient.auth.resetPasswordForEmail(
          emailController.text.trim(),
          redirectTo: "return://javidcoffee.app",
        );

        sendLoading.value = false;

        StatusDialog().showSuccess("ایمیل با موفقیت ارسال شد.");

        emailController.clear();

        Get.toNamed(ResetPage.routeName);
      } catch (e) {
        sendLoading.value = false;

        StatusDialog().showError("در ارسال ایمیل مشکلی پیش آمد!");
      }
    } else {
      sendLoading.value = false;

      StatusDialog().showWarning("لطفا همه فرم ها را پر کنید!");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
