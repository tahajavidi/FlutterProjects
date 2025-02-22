import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/features/admin/controllers/edit_product_controller.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key});

  static const routeName = "/edit_product";

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final EditProductController controller = Get.put(EditProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
