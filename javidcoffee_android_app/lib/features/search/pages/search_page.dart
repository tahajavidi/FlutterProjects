import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:intl/intl.dart';
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
            Debouncer(delay: const Duration(milliseconds: 200)).call(
              () {
                searchProductsController.searchProducts(controller.text);
              },
            );

            return [
              Obx(
                () {
                  if (searchProductsController.searchResults.isEmpty) {
                    return Column(
                      children:
                          searchProductsController.searchResults.map((product) {
                        return ListTile(
                          title: Text(
                            product['title'],
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
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
                        title: Text(
                          product['title'],
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                    return Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: ListTile(
                        style: ListTileStyle.list,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        title: Text(
                          product['title'],
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          "${NumberFormat.decimalPatternDigits(locale: "fa", decimalDigits: 0).format(product['price'])} تومان",
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.primaryFixedDim,
                          ),
                        ),
                        leading: Hero(
                          tag: "${product['image'][0]}_${product['id']}_hero",
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(70)),
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(product['image'][0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.to(DetailsPage(pr: Product.fromJson(product)));
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
      ),
    );
  }
}
