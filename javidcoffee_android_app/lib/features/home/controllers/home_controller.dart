import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/features/home/components/slider_banner.dart';
import 'package:javidcoffee_android_app/utils/status_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  final SupabaseClient supabaseClient = Supabase.instance.client;
  final CarouselSliderController carouselController =
      CarouselSliderController();

  final RxList<SliderBanner> sliderBanners = List.generate(7, (index) {
    return SliderBanner(
      bannerUrl: "assets/images/Image${index + 1}.png",
    );
  }).obs;

  RxInt currentBanner = 0.obs;
  RxInt indexes = 0.obs;
  RxBool isAdmin = false.obs;
  RxMap<String, dynamic> userData = RxMap<String, dynamic>();
  RxList<dynamic> machines = <dynamic>[].obs;
  RxBool isLoadingUser = false.obs;
  RxBool isLoadingMachines = false.obs;

  @override
  void onInit() {
    fetchUserData();
    fetchMachinesData();
    getIsAdmin();

    super.onInit();
  }

  Future<void> logoutUser() async {
    await supabaseClient.auth.signOut();
    isAdmin.value = false;
    userData.value = {};
  }

  Future<void> fetchUserData() async {
    final user = supabaseClient.auth.currentUser;

    try {
      isLoadingUser.value = true;

      if (user == null) {
        isLoadingUser.value = false;
        return;
      }

      final response = await supabaseClient
          .from("users")
          .select()
          .eq("user_id", user.id)
          .single();

      userData.assignAll(response);
      isLoadingUser.value = false;
    } catch (e) {
      isLoadingUser.value = false;
      StatusDialog().showError("خطا در دریافت اطلاعات!");
      if (kDebugMode) {
        print("Error fetching user: ${e.toString()}");
      }
    }
  }

  Future<void> fetchMachinesData() async {
    try {
      isLoadingMachines.value = true;

      final response = await supabaseClient
          .from("ads")
          .select()
          .eq("category", "دستگاه")
          .order("id", ascending: true);

      machines.assignAll(response);
      isLoadingMachines.value = false;
    } catch (e) {
      isLoadingMachines.value = false;
      StatusDialog().showError("خطا در دریافت محصولات");
      if (kDebugMode) {
        print("Error fetching products: ${e.toString()}");
      }
    }
  }

  Future<void> getIsAdmin() async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) {
      isAdmin.value = false;
      return;
    }

    final response = await supabaseClient
        .from('users')
        .select('isAdmin')
        .eq('user_id', user.id)
        .single();

    isAdmin.value = response["isAdmin"];
  }
}
