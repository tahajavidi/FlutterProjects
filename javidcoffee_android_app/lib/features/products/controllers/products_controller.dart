import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsController extends GetxController {
  late Future<dynamic> gridData;

  final SupabaseClient supabaseClient = Supabase.instance.client;

  Future<dynamic> getGridData() async {
    final Future<dynamic> future =
        supabaseClient.from("ads").select().order("id", ascending: true);

    return future;
  }

  @override
  void onInit() {
    gridData = getGridData();
    super.onInit();
  }
}
