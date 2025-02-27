import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/features/profile/controllers/profile_controller.dart';
import 'package:javidcoffee_android_app/features/profile/pages/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const routeName = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("پروفایل"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Obx(
            () {
              if (profileController.userData.isEmpty) {
                return const CircularProgressIndicator();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 20.0,
                children: [
                  Animate(
                    effects: [
                      const FadeEffect(delay: Duration(milliseconds: 100)),
                    ],
                    child: Container(
                      height: 180.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        borderRadius: BorderRadius.circular(16.0),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            profileController.userData["profile_image"]
                                .toString(),
                            errorListener: (p0) => const Icon(
                              Icons.error,
                              size: 55,
                            ),
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: profileController.userData["profile_image"] ==
                                  null ||
                              profileController.userData["profile_image"] == ""
                          ? const Icon(
                              Icons.person,
                              size: 60,
                            )
                          : null,
                    ),
                  ),
                  Text(
                    profileController.userData["name"].toString(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(profileController.userData["email"].toString(),
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          Get.toNamed(EditProfilePage.routeName);
        },
      ),
    );
  }
}
