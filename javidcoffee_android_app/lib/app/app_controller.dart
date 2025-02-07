import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppController extends GetxController {
  final SupabaseClient supabaseClient = Supabase.instance.client;
  final Connectivity connectivity = Connectivity();
  late Rx<User?> user = Rx<User?>(null);
  late RxList<ConnectivityResult> results = <ConnectivityResult>[].obs;

  Future<void> getAuth() async {
    supabaseClient.auth.onAuthStateChange.listen((event) {
      user.value = event.session?.user;
    });
  }

  Future<void> checkConnectivity() async {
    await connectivity.checkConnectivity();

    connectivity.onConnectivityChanged.listen((event) {
      results.value = event;
    });
  }

  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        getAuth();
        checkConnectivity();
      },
    );
    super.onInit();
  }
}
