import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/profile/components/edit_text_field.dart';
import 'package:javidcoffee_android_app/features/profile/controllers/edit_profile_controller.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  static const routeName = "/edit-profile";

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final EditProfileController editProfileController =
      Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ویرایش پروفایل"),
        actions: [
          IconButton(
            onPressed: editProfileController.pickImage,
            icon: const Icon(
              FontAwesomeIcons.image,
              size: 30,
            ),
          ),
        ],
      ),
      body: Center(
        child: Obx(
          () {
            if (editProfileController.isUploading.value) {
              return const CircularProgressIndicator();
            }

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.06,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 20.0,
                  children: [
                    if (editProfileController
                                .profileController.userData["profile_image"] !=
                            "" &&
                        editProfileController
                                .profileController.userData["profile_image"] !=
                            null)
                      CachedNetworkImage(
                        imageUrl: editProfileController
                            .profileController.userData["profile_image"],
                        height: 180.0,
                        width: 180.0,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            borderRadius: BorderRadius.circular(16.0),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) {
                          if (editProfileController.profileController
                                      .userData["profile_image"] ==
                                  "" ||
                              editProfileController.profileController
                                      .userData["profile_image"] ==
                                  null) {
                            return Container(
                              height: 180.0,
                              width: 180.0,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade500,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.person,
                                  size: 55,
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              height: 180.0,
                              width: 180.0,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade500,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.error,
                                  color: Colors.redAccent,
                                  size: 55,
                                ),
                              ),
                            );
                          }
                        },
                      )
                    else
                      Container(
                        height: 180.0,
                        width: 180.0,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(16.0),
                          image: DecorationImage(
                            image: FileImage(
                              File(editProfileController
                                  .selectedImage.value.path),
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    EditTextField(
                      labelText: editProfileController
                          .profileController.userData["name"],
                      suffixIcon: const Icon(FontAwesomeIcons.user),
                      obscureText: false,
                      controller: editProfileController.usernameController,
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 60,
                      width: 250,
                      child: FilledButton.tonal(
                        onPressed: editProfileController.updateProfile,
                        child: Text(
                          "ذخیره",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
