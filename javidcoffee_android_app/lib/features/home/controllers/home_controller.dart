import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  final RxList<IconData> desktopNavigationItems = <IconData>[
    Icons.home_rounded,
    Icons.search_rounded,
    Icons.dashboard_rounded,
    Icons.chat_rounded,
  ].obs;

  RxInt currentBanner = 0.obs;
  RxInt selectedDesktop = 0.obs;
  RxBool isAdmin = false.obs;
  RxMap<String, dynamic> userData = RxMap<String, dynamic>();
  RxList<dynamic> machines = <dynamic>[].obs;
  RxList<dynamic> coffees = <dynamic>[].obs;
  RxList<dynamic> parts = <dynamic>[].obs;
  RxBool isLoadingUser = false.obs;
  RxBool isLoadingMachines = false.obs;
  RxBool isLoadingCoffees = false.obs;
  RxBool isLoadingParts = false.obs;

  void desktopNavigationToggle(index) {
    selectedDesktop.value = index;
  }

  @override
  void onInit() {
    fetchUserData();
    fetchMachinesData();
    fetchCoffeesData();
    fetchPartsData();
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

  Future<void> fetchCoffeesData() async {
    try {
      isLoadingCoffees.value = true;

      final response = await supabaseClient
          .from("ads")
          .select()
          .eq("category", "قهوه")
          .order("id", ascending: true);

      coffees.assignAll(response);
      isLoadingCoffees.value = false;
    } catch (e) {
      isLoadingCoffees.value = false;
      StatusDialog().showError("خطا در دریافت محصولات");
      if (kDebugMode) {
        print("Error fetching products: ${e.toString()}");
      }
    }
  }

  Future<void> fetchPartsData() async {
    try {
      isLoadingParts.value = true;

      final response = await supabaseClient
          .from("ads")
          .select()
          .eq("category", "قطعات")
          .order("id", ascending: true);

      parts.assignAll(response);
      isLoadingParts.value = false;
    } catch (e) {
      isLoadingParts.value = false;
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
