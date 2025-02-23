import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/admin/components/add_button_menu.dart';
import 'package:javidcoffee_android_app/features/admin/components/admin_text_field.dart';
import 'package:javidcoffee_android_app/features/admin/components/image_picker_button.dart';
import 'package:javidcoffee_android_app/features/admin/controllers/edit_product_controller.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key});

  static const routeName = "/edit_product";

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final EditProductController editProductController =
      Get.put(EditProductController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ویرایش محصول"),
      ),
      body: Center(
        child: Obx(
          () {
            if (editProductController.productData.isEmpty) {
              return const CircularProgressIndicator();
            }

            if (editProductController.isLoading.value) {
              return const CircularProgressIndicator();
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 20.0,
                children: [
                  editProductController
                          .newProductController.selectedImages.isEmpty
                      ? SizedBox(
                          height: SizeConfig.screenHeight * 0.22,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(10),
                            scrollDirection: Axis.horizontal,
                            itemCount: editProductController
                                .productData['image'].length,
                            itemBuilder: (context, index) {
                              return CachedNetworkImage(
                                imageUrl: editProductController
                                    .productData['image'][index],
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: SizeConfig.screenHeight * 0.22,
                                  width: SizeConfig.screenWidth * 0.38,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(12.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: imageProvider,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : SizedBox(
                          height: SizeConfig.screenHeight * 0.22,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(10),
                            scrollDirection: Axis.horizontal,
                            itemCount: editProductController
                                .newProductController.selectedImages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: SizeConfig.screenHeight * 0.22,
                                width: SizeConfig.screenWidth * 0.38,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                      File(editProductController
                                          .newProductController
                                          .selectedImages[index]
                                          .path),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 5.0),
                  AdminTextField(
                    controller: editProductController.titleController,
                    labelText: editProductController.productData['title'],
                    inputType: TextInputType.text,
                    obscureText: false,
                    suffixIcon: const Icon(Icons.title_rounded),
                  ),
                  AdminTextField(
                    controller: editProductController.priceController,
                    labelText:
                        editProductController.productData['price'].toString(),
                    inputType: TextInputType.number,
                    obscureText: false,
                    suffixIcon: const Icon(Icons.price_change_rounded),
                  ),
                  AdminTextField(
                    controller: editProductController.descController,
                    labelText: editProductController.productData['desc'],
                    inputType: TextInputType.multiline,
                    obscureText: false,
                    suffixIcon: const Icon(Icons.description_rounded),
                  ),
                  const SizedBox(height: 18.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AddButtonMenu(
                        newProductController:
                            editProductController.newProductController,
                      ),
                      ImagePickerButton(
                        pickImages: editProductController
                            .newProductController.pickImages,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 60,
                    width: 250,
                    child: FilledButton.tonal(
                      onPressed: editProductController.updateProduct,
                      child: Text(
                        "ویرایش",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
