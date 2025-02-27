import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/utils/status_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  final SupabaseClient supabaseClient = Supabase.instance.client;

  RxMap<String, dynamic> userData = RxMap<String, dynamic>();
  RxBool isLoading = false.obs;  

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  Future<void> fetchUserData() async {
    final user = supabaseClient.auth.currentUser;

    try {
      isLoading.value = true;

      if (user == null) {
        isLoading.value = false;
        return;
      }

      final response = await supabaseClient
          .from("users")
          .select()
          .eq("user_id", user.id)
          .single();

      userData.assignAll(response);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      StatusDialog().showError("خطا در دریافت اطلاعات!");
      if (kDebugMode) {
        print("Error fetching user: ${e.toString()}");
      }
    }
  }
}
