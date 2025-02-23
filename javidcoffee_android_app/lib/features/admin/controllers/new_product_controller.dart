import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:javidcoffee_android_app/utils/status_dialog.dart';
import 'package:javidcoffee_android_app/utils/translate_path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewProductController extends GetxController {
  final SupabaseClient supabaseClient = Supabase.instance.client;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final ImagePicker? picker = ImagePicker();

  RxString selectedCategory = "انتخاب کنید".obs;
  RxList<XFile> selectedImages = <XFile>[].obs;
  RxBool isLoading = false.obs;

  Future<void> pickImages() async {
    final List<XFile>? images = await picker?.pickMultiImage();
    if (picker != null && images != null) {
      selectedImages.assignAll(images);
    }
  }

  Future<List<String>> uploadImagesToStorage(String descText) async {
    final DateTime now = DateTime.now();
    List<String> uploadedUrls = [];

    try {
      for (XFile image in selectedImages) {
        File file = File(image.path);

        String fileName = TranslatePath().transliteratePersianToEnglish(
            "${DateTime.now().millisecondsSinceEpoch}_${image.name}");
        String folderName =
            "${TranslatePath().transliteratePersianToEnglish(descText).length >= 10 ? TranslatePath().transliteratePersianToEnglish(descText).substring(0, 10) : TranslatePath().transliteratePersianToEnglish(descText)}_$now";

        String encodedFileName = Uri.encodeComponent(fileName);
        String encodedFolderName = Uri.encodeComponent(folderName);

        String encodedUri = "$encodedFolderName/$encodedFileName";

        if (kDebugMode) {
          print(encodedUri);
        }

        await supabaseClient.storage
            .from('product-images')
            .upload(encodedUri, file);

        String imageUrl = supabaseClient.storage
            .from('product-images')
            .getPublicUrl(encodedUri);
        uploadedUrls.add(imageUrl);
      }
    } catch (e) {
      StatusDialog().showError(e.toString());

      if (kDebugMode) {
        print("Error uploading image: ${e.toString()}");
      }
    }
    return uploadedUrls;
  }

  Future<void> sendProduct() async {
    if (selectedImages.isNotEmpty) {
      if (selectedCategory.value != "انتخاب کنید") {
        if (titleController.text.isNotEmpty &&
            priceController.text.isNotEmpty &&
            descController.text.isNotEmpty) {
          isLoading.value = true;

          try {
            List<String> imageUrls = await uploadImagesToStorage(descController.text.trim());

            await supabaseClient.from('ads').insert({
              'title': titleController.text.trim(),
              'price': priceController.text.trim(),
              'category': selectedCategory.value,
              'desc': descController.text.trim(),
              'image': imageUrls,
            });

            isLoading.value = false;

            selectedCategory.value = "انتخاب کنید";
            selectedImages.clear();
            titleController.clear();
            priceController.clear();
            descController.clear();

            StatusDialog().showSuccess("محصول با موفقیت ارسال شد.");
          } catch (e) {
            isLoading.value = false;
            StatusDialog().showError(e.toString());

            if (kDebugMode) {
              print("Error sending product: ${e.toString()}");
            }
          }
        } else {
          StatusDialog().showWarning("لطفا تمامی فرم ها را پر کنید!");
        }
      } else {
        StatusDialog().showWarning("لطفا دسته بندی را انتخاب کنید!");
      }
    } else {
      StatusDialog().showWarning("لطفا حداقل یک تصویر انتخاب کنید!");
    }
  }
}
