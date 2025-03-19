import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/products/components/product_grid_view.dart';
import 'package:javidcoffee_android_app/features/products/controllers/products_controller.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  static const routeName = "/products";

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: FutureBuilder(
        future: productsController.gridData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProductGridView(
              snapshot: snapshot,
              productsController: productsController,
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 15,
                children: [
                  CircularProgressIndicator(),
                  Text("در حال دریافت اطلاعات..."),
                ],
              ),
            );
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}
