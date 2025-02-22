import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/features/admin/controllers/new_product_controller.dart';

class AddButtonMenu extends StatelessWidget {
  final NewProductController newProductController;

  const AddButtonMenu({
    super.key,
    required this.newProductController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopupMenuButton<String>(
        onSelected: (String value) {
          newProductController.selectedCategory.value = value;
        },
        itemBuilder: (BuildContext context) => [
          _buildMenuItem(context, "دستگاه"),
          _buildMenuItem(context, "قهوه"),
          _buildMenuItem(context, "قطعات"),
        ],
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                newProductController.selectedCategory.value,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(width: 10),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(BuildContext context, String title) {
    return PopupMenuItem<String>(
      value: title,
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
