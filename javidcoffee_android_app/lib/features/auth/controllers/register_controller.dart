import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/features/auth/models/user_model.dart';
import 'package:javidcoffee_android_app/utils/status_dialog.dart';
import 'package:javidcoffee_android_app/utils/validate_checks.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController extends GetxController {
  final SupabaseClient supabaseClient = Supabase.instance.client;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  RxBool isHidePass = true.obs;
  RxBool isHideConf = true.obs;

  RxBool registerLoading = false.obs;

  void toggleHidePass() {
    isHidePass.value = !isHidePass.value;
  }

  void toggleHideConf() {
    isHideConf.value = !isHideConf.value;
  }

  Future<void> registerUser() async {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      if (confirmPasswordController.text == passwordController.text) {
        if (emailController.text.length < 8) {
          StatusDialog().showWarning("ایمیل باید بیشتر از 8 کاراکتر باشد!");
        }
        if (passwordController.text.length < 10) {
          StatusDialog().showWarning("رمز عبور باید بیشتر از 10 کاراکتر باشد!");
        } else {
          if (ValidateChecks().isEmail(emailController.text.trim())) {
            registerLoading.value = true;

            try {
              AuthResponse userCredential = await supabaseClient.auth.signUp(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
                emailRedirectTo: "return://javidcoffee.app",
              );

              await supabaseClient.from("users").insert(
                    UserModel(
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      created: DateTime.now(),
                      uid: userCredential.user!.id,
                    ).toJson(),
                  );

              registerLoading.value = false;

              StatusDialog().showSuccess(
                  "ثبت نام با موفقیت انجام شد. لطفا به ایمیل ارسال شده بروید.");

              nameController.clear();
              emailController.clear();
              passwordController.clear();
              confirmPasswordController.clear();
            } catch (e) {
              registerLoading.value = false;

              StatusDialog().showError(e.toString());
            }
          } else {
            registerLoading.value = false;

            StatusDialog().showWarning("لطفا یک ایمیل صحیح وارد کنید!");
          }
        }
      } else {
        registerLoading.value = false;

        StatusDialog().showWarning("رمز عبور با تایید رمز عبور مطابقت ندارد!");
      }
    } else {
      registerLoading.value = false;

      StatusDialog().showWarning("لطفا همه فرم ها را پر کنید!");
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
