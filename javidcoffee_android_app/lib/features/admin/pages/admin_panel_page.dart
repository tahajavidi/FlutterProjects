import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/admin/controllers/admin_panel_controller.dart';
import 'package:javidcoffee_android_app/features/home/models/product.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products List'),
      ),
      body: FutureBuilder(
        future: adminPanelController.getProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Iterable iterable = snapshot.data;
            var list = iterable.map((e) => Product.fromJson(e)).toList();

            return Obx(
              () {
                if (adminPanelController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final Product pr = list[index];

                    return ListTile(
                      title: Text(pr.title!, overflow: TextOverflow.ellipsis),
                      subtitle: Text(
                        pr.desc!,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        onPressed: () =>
                            adminPanelController.deleteProduct(pr.id!),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: Text("محصولی یافت نشد."));
          }
        },
      ),
    );
  }
}
