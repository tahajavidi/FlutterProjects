import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/features/admin/controllers/new_product_controller.dart';
import 'package:javidcoffee_android_app/features/home/models/product.dart';
import 'package:javidcoffee_android_app/utils/status_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProductController extends GetxController {
  late Product data;

  final SupabaseClient supabaseClient = Supabase.instance.client;
  final NewProductController newProductController =
      Get.put(NewProductController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  RxMap<String, dynamic> productData = <String, dynamic>{}.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    data = Get.arguments;
    super.onInit();
    fetchProductData();
  }

  Future<dynamic> fetchProductData() async {
    try {
      isLoading.value = true;

      final response =
          await supabaseClient.from('ads').select().eq('id', data.id!).single();

      productData.value = response;
      newProductController.selectedCategory.value =
          productData['category'].toString();

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;

      StatusDialog().showError("خطا در دریافت محصول");

      if (kDebugMode) {
        print("Error fetching product data: ${e.toString()}");
      }
    }
  }

  Future<void> updateProduct() async {
    if (newProductController.selectedImages.isNotEmpty ||
        titleController.text.isNotEmpty ||
        priceController.text.isNotEmpty ||
        descController.text.isNotEmpty ||
        newProductController.selectedCategory.value != "انتخاب کنید" ||
        newProductController.selectedCategory.value !=
            productData['category']) {
      try {
        isLoading.value = true;

        List<String> imageUrls = await newProductController
            .uploadImagesToStorage(descController.text.isNotEmpty
                ? descController.text.trim()
                : data.desc.toString());

        await supabaseClient.from("ads").update({
          if (titleController.text.isNotEmpty)
            "title": titleController.text.trim(),
          if (priceController.text.isNotEmpty)
            "price": priceController.text.trim(),
          if (newProductController.selectedCategory.value != "انتخاب کنید" &&
              newProductController.selectedCategory.value !=
                  productData['category'])
            "category": newProductController.selectedCategory.value,
          if (descController.text.isNotEmpty)
            "desc": descController.text.trim(),
          if (newProductController.selectedImages.isNotEmpty)
            "image": imageUrls,
        }).eq("id", data.id!);

        newProductController.selectedCategory.value =
            productData['category'].toString();
        newProductController.selectedImages.clear();
        titleController.clear();
        priceController.clear();
        descController.clear();

        isLoading.value = false;

        StatusDialog().showSuccess("محصول با موفقیت ویرایش شد.");

        fetchProductData();
      } catch (e) {
        isLoading.value = false;

        StatusDialog().showError("خطا در ویرایش محصول");

        if (kDebugMode) {
          print("Error updating product: ${e.toString()}");
        }
      }
    } else {
      StatusDialog().showWarning("لطفا تمامی فرم ها را پر کنید");
    }
  }
}
