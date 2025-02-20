import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/details/pages/details_page.dart';
import 'package:javidcoffee_android_app/features/home/models/product.dart';
import 'package:javidcoffee_android_app/features/search/components/search_field.dart';
import 'package:javidcoffee_android_app/features/search/controllers/search_products_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  static const routeName = "/search";

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchProductsController searchProductsController =
      Get.put(SearchProductsController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (Responsive.isMobile(context)) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: SearchAnchor(
            searchController: searchProductsController.searchController,
            keyboardType: TextInputType.text,
            isFullScreen: false,
            textInputAction: TextInputAction.search,
            viewOnSubmitted: (value) =>
                searchProductsController.searchController.closeView(value),
            builder: (context, controller) {
              return SearchField(
                onTap: () {
                  controller.openView();
                },
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) {
              Future.delayed(const Duration(milliseconds: 500), () {
                searchProductsController.searchProducts(controller.text);
              });

              return [
                Obx(
                  () {
                    if (searchProductsController.searchResults.isEmpty) {
                      return Column(
                        children: searchProductsController.searchResults
                            .map((product) {
                          return ListTile(
                            title: Text(product['title']),
                            onTap: () {
                              controller.closeView(product['title']);
                            },
                          );
                        }).toList(),
                      );
                    }

                    return Column(
                      children:
                          searchProductsController.searchResults.map((product) {
                        return ListTile(
                          title: Text(product['title']),
                          onTap: () {
                            controller.closeView(product['title']);
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
              ];
            },
          ),
        ),
        body: Obx(
          () => searchProductsController.searchResults.isEmpty
              ? const Center(child: Text("چیزی جستجو کنید."))
              : SingleChildScrollView(
                  child: Column(
                    children:
                        searchProductsController.searchResults.map((product) {
                      return ListTile(
                        title: Text(product['title']),
                        subtitle: Text(
                            "${NumberFormat.decimalPatternDigits(locale: "fa", decimalDigits: 0).format(product['price'])} تومان"),
                        leading: Hero(
                          tag: "${product['id']}_${product['image'][0]}",
                          child: Image.network(product['image'][0],
                              width: 50, height: 50, fit: BoxFit.cover),
                        ),
                        onTap: () {
                          Get.to(DetailsPage(pr: Product.fromJson(product)));
                        },
                      );
                    }).toList(),
                  ),
                ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(),
      );
    }
  }
}
