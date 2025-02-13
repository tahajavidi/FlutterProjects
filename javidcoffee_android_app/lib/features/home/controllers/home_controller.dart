import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/features/home/components/slider_banner.dart';
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

  Future<void> logoutUser() async {
    await supabaseClient.auth.signOut();
  }
}
