import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/admin/controllers/admin_panel_controller.dart';
import 'package:javidcoffee_android_app/features/admin/pages/edit_product_page.dart';
import 'package:javidcoffee_android_app/features/admin/pages/new_product_page.dart';
import 'package:javidcoffee_android_app/features/home/models/product.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});

  static const routeName = "/admin_panel";

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  final AdminPanelController adminPanelController =
      Get.put(AdminPanelController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (Responsive.isMobile(context)) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('لیست محصولات'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                onPressed: () => Get.toNamed(NewProductPage.routeName),
                icon: const Icon(
                  Icons.add_rounded,
                  size: 30,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        body: LiquidPullToRefresh(
          onRefresh: () async => adminPanelController.getProductsData(),
          height: 200,
          animSpeedFactor: 3,
          showChildOpacityTransition: false,
          child: Obx(
            () {
              if (adminPanelController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (adminPanelController.products.isEmpty) {
                return const Center(child: Text("محصولی یافت نشد."));
              }

              return ListView.builder(
                itemCount: adminPanelController.products.length,
                itemBuilder: (context, index) {
                  final Product pr =
                      Product.fromJson(adminPanelController.products[index]);

                  return ListTile(
                    title: Text(pr.title!, overflow: TextOverflow.ellipsis),
                    subtitle: Text(pr.desc!, overflow: TextOverflow.ellipsis),
                    trailing: IconButton(
                      onPressed: () =>
                          adminPanelController.deleteProduct(pr.id!),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                    ),
                    onTap: () => Get.toNamed(EditProductPage.routeName),
                  );
                },
              );
            },
          ),
        ),
      );
    } else {
      return const Scaffold();
    }
  }
}
