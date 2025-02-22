import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:javidcoffee_android_app/utils/status_dialog.dart';
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

  String transliteratePersianToEnglish(String persianText) {
    Map<String, String> transliterationMap = {
      'ا': 'a',
      'ب': 'b',
      'پ': 'p',
      'ت': 't',
      'ث': 'th',
      'ج': 'j',
      'چ': 'ch',
      'ح': 'h',
      'خ': 'kh',
      'د': 'd',
      'ذ': 'z',
      'ر': 'r',
      'ز': 'z',
      'ژ': 'zh',
      'س': 's',
      'ش': 'sh',
      'ص': 's',
      'ض': 'z',
      'ط': 't',
      'ظ': 'z',
      'ع': 'a',
      'غ': 'gh',
      'ف': 'f',
      'ق': 'gh',
      'ک': 'k',
      'گ': 'g',
      'ل': 'l',
      'م': 'm',
      'ن': 'n',
      'و': 'v',
      'ه': 'h',
      'ی': 'y',
      'ئ': 'e',
      'آ': 'aa',
      'او': 'oo'
    };

    String result = '';
    for (int i = 0; i < persianText.length; i++) {
      String char = persianText[i];
      if (transliterationMap.containsKey(char)) {
        result += transliterationMap[char]!;
      } else {
        result += char;
      }
    }
    return result;
  }

  Future<void> pickImages() async {
    final List<XFile>? images = await picker?.pickMultiImage();
    if (picker != null && images != null) {
      selectedImages.assignAll(images);
    }
  }

  Future<List<String>> uploadImagesToStorage() async {
    final DateTime now = DateTime.now();
    List<String> uploadedUrls = [];

    try {
      for (XFile image in selectedImages) {
        File file = File(image.path);

        String fileName = transliteratePersianToEnglish(
            "${DateTime.now().millisecondsSinceEpoch}_${image.name}");
        String folderName =
            "${transliteratePersianToEnglish(descController.text).length >= 10 ? transliteratePersianToEnglish(descController.text).substring(0, 10) : transliteratePersianToEnglish(descController.text)}_$now";

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
            .getPublicUrl(fileName);
        uploadedUrls.add(imageUrl);
      }

      return uploadedUrls;
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
            List<String> imageUrls = await uploadImagesToStorage();

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
          StatusDialog().showWarning("لطفا دسته بندی را انتخاب کنید!");
        }
      }
    } else {
      StatusDialog().showWarning("لطفا حداقل یک تصویر انتخاب کنید!");
    }
  }
}
