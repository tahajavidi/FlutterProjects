import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/utils/status_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminPanelController extends GetxController {
  final SupabaseClient supabaseClient = Supabase.instance.client;

  RxList<dynamic> products = <dynamic>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getProductsData();
    super.onInit();
  }

  Future<void> getProductsData() async {
    try {
      isLoading.value = true;

      final List<dynamic> response = await supabaseClient
          .from('ads')
          .select()
          .order('id', ascending: true);
      products.assignAll(response);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      StatusDialog().showError("خطا در دریافت محصولات");
      if (kDebugMode) {
        print("Error fetching products: ${e.toString()}");
      }
    }
  }

  Future<void> deleteProduct(int productId) async {
    isLoading.value = true;
    try {
      await supabaseClient.from('ads').delete().eq("id", productId);
      if (kDebugMode) {
        print("Product deleted successfully");
      }

      StatusDialog().showSuccess("محصول با موفقیت حذف شد.");
      getProductsData();
    } catch (e) {
      StatusDialog().showError(e.toString());
      if (kDebugMode) {
        print("Error deleting product: ${e.toString()}");
      }
    }
    isLoading.value = false;
  }
}
