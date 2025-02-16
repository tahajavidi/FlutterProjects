import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/features/home/components/slider_banner.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  late Future<void> gridData;
  late Future<dynamic> userData;

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

  Future<void> logoutUser() async {
    await supabaseClient.auth.signOut();
  }

  Future<dynamic> getUserData() async {
    final Future<dynamic> future = supabaseClient
        .from("users")
        .select()
        .eq("user_id", supabaseClient.auth.currentUser!.id);

    return future;
  }

  Future<dynamic> getGridData() async {
    final Future<dynamic> future = supabaseClient
        .from("ads")
        .select()
        .order("id", ascending: true)
        .limit(8);

    return future;
  }

  @override
  void onInit() {
    gridData = getGridData();
    userData = getUserData();
    super.onInit();
  }
}
