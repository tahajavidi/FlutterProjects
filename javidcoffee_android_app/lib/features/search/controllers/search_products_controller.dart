import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchProductsController extends GetxController {
  final SupabaseClient supabaseClient = Supabase.instance.client;
  final SearchController searchController = SearchController();

  RxList searchResults = [].obs;

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      searchResults.value = await supabaseClient
          .from("ads")
          .select()
          .order("id", ascending: true);
    }

    final response = await supabaseClient
        .from('ads')
        .select()
        .ilike('title', '%$query%')
        .order('id', ascending: true);

    searchResults.value = response;
  }
}
