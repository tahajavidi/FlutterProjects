import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:javidcoffee_android_app/features/profile/controllers/profile_controller.dart';
import 'package:javidcoffee_android_app/utils/status_dialog.dart';
import 'package:javidcoffee_android_app/utils/translate_path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfileController extends GetxController {
  final SupabaseClient supabaseClient = Supabase.instance.client;
  final ProfileController profileController = Get.find<ProfileController>();
  final TextEditingController usernameController = TextEditingController();
  final ImagePicker? picker = ImagePicker();

  RxBool isUploading = false.obs;
  Rx<XFile> selectedImage = XFile("").obs;
  RxString profileImageUrl = "".obs;

  Future<void> pickImage() async {
    final XFile? image = await picker?.pickImage(source: ImageSource.gallery);
    if (picker != null && image != null) {
      selectedImage.value = image;
      StatusDialog().showSuccess("عکس جدید انتخاب شد!");
    }
  }

  Future<String> updateImagesInStorage() async {
    RxString uploadedUrl = "".obs;

    try {
      File file = File(selectedImage.value.path);

      String fileName = TranslatePath().transliteratePersianToEnglish(
          "${DateTime.now().millisecondsSinceEpoch}_${selectedImage.value.name}");
      String folderName = TranslatePath().transliteratePersianToEnglish(
          "${profileController.userData["email"]}_${DateTime.now().millisecondsSinceEpoch}");

      String encodedFileName = Uri.encodeComponent(fileName);
      String encodedFolderName = Uri.encodeComponent(folderName);

      String encodedUri = "$encodedFolderName/$encodedFileName";

      String urlName = await supabaseClient.storage
          .from('prodile_images')
          .upload(encodedUri, file);

      String imageUrl = supabaseClient.storage
          .from('prodile_images')
          .getPublicUrl(urlName.toString());
      uploadedUrl.value = imageUrl;
      profileImageUrl.value = imageUrl;
    } catch (e) {
      StatusDialog().showError(e.toString());

      if (kDebugMode) {
        print("Error uploading image: ${e.toString()}");
      }
    }
    return uploadedUrl.value;
  }

  Future<void> updateProfile() async {
    try {
      isUploading.value = true;

      final user = supabaseClient.auth.currentUser;
      if (user == null) {
        return;
      }

      if (selectedImage.value.path.isNotEmpty) {
        await updateImagesInStorage();
      }

      await supabaseClient.from("users").update({
        if (usernameController.text.isNotEmpty)
          "name": usernameController.text.trim(),
        if (profileImageUrl.value.isNotEmpty)
          "profile_image": profileImageUrl.value
              .replaceAll("prodile_images/prodile_images", "prodile_images"),
      }).eq("user_id", user.id);

      usernameController.clear();

      profileController.fetchUserData();
      isUploading.value = false;
      StatusDialog().showSuccess("بروزرسانی با موفقیت انجام شد.");
    } catch (e) {
      isUploading.value = false;
      StatusDialog().showError("خطا در بروزرسانی اطلاعات!");
      if (kDebugMode) {
        print("Error updating profile: ${e.toString()}");
      }
    }
  }
}
