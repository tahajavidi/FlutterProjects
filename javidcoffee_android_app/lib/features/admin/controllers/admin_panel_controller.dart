import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/utils/status_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminPanelController extends GetxController {
  late Future<dynamic> getProducts;

  final SupabaseClient supabase = Supabase.instance.client;

  RxBool isLoading = false.obs;

  Future<dynamic> fetchProducts() async {
    final future =
        await supabase.from('ads').select().order('id', ascending: true);

    return future;
  }

  Future<void> deleteProduct(int productId) async {
    isLoading.value = true;

    try {
      await supabase.from('ads').delete().eq("id", productId);
      await fetchProducts();
      if (kDebugMode) {
        print("deleted");
      }

      isLoading.value = false;
      StatusDialog().showSuccess("محصول با موفقیت حذف شد.");
    } catch (e) {
      isLoading.value = false;
      StatusDialog().showError(e.toString());
      if (kDebugMode) {
        print('Error deleting product: ${e.toString()}');
      }
    }

    isLoading.value = false;
  }

  @override
  void onInit() {
    getProducts = fetchProducts();
    super.onInit();
  }
}
