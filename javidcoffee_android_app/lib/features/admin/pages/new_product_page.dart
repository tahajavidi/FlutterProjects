import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/admin/components/add_button_menu.dart';
import 'package:javidcoffee_android_app/features/admin/components/admin_text_field.dart';
import 'package:javidcoffee_android_app/features/admin/components/image_picker_button.dart';
import 'package:javidcoffee_android_app/features/admin/controllers/new_product_controller.dart';

class NewProductPage extends StatefulWidget {
  const NewProductPage({super.key});

  static const routeName = "/new_product";

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final NewProductController newProductController =
      Get.put(NewProductController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('افزودن محصول'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Obx(
          () => Center(
            child: newProductController.isLoading.value
                ? const CircularProgressIndicator()
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 20.0,
                      children: [
                        Obx(
                          () => newProductController.selectedImages.isEmpty
                              ? Center(
                                  child: Container(
                                    height: SizeConfig.screenHeight * 0.22,
                                    width: SizeConfig.screenWidth * 0.5,
                                    decoration: BoxDecoration(
                                      color: Get.isDarkMode
                                          ? Colors.grey[700]
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: const Center(
                                      child: Text("ابتدا تصویری انتخاب کنید!"),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: SizeConfig.screenHeight * 0.22,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(10),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: newProductController
                                        .selectedImages.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: SizeConfig.screenHeight * 0.22,
                                        width: SizeConfig.screenWidth * 0.38,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                              File(newProductController
                                                  .selectedImages[index].path),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ),
                        const SizedBox(height: 5.0),
                        AdminTextField(
                          controller: newProductController.titleController,
                          labelText: "عنوان",
                          inputType: TextInputType.text,
                          obscureText: false,
                          suffixIcon: const Icon(Icons.title_rounded),
                        ),
                        AdminTextField(
                          controller: newProductController.priceController,
                          labelText: "قیمت به تومان",
                          inputType: TextInputType.number,
                          obscureText: false,
                          suffixIcon: const Icon(Icons.price_change_rounded),
                        ),
                        AdminTextField(
                          controller: newProductController.descController,
                          labelText: "توضیحات",
                          inputType: TextInputType.multiline,
                          obscureText: false,
                          suffixIcon: const Icon(Icons.description_rounded),
                        ),
                        const SizedBox(height: 18.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AddButtonMenu(
                              newProductController: newProductController,
                            ),
                            ImagePickerButton(
                              pickImages: newProductController.pickImages,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 60,
                          width: 250,
                          child: FilledButton.tonal(
                            onPressed: newProductController.sendProduct,
                            child: Text(
                              "افزودن",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
