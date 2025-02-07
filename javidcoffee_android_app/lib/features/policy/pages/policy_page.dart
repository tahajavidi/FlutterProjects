import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/policy/controllers/policy_controller.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({super.key});

  static const routeName = "/policy";

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  final PolicyController policyController = Get.put(PolicyController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Obx(
      () => Localizations.override(
        context: context,
        locale: policyController.isEnglish.value
            ? const Locale('en')
            : const Locale('fa'),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: policyController.isEnglish.value
                ? const Text("Privacy & Policy")
                : const Text("سیاست و مقررات"),
            actions: [
              IconButton(
                onPressed: () {
                  policyController.changeLang();
                },
                icon: const Icon(CupertinoIcons.globe, size: 30),
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: RxList.generate(
                  policyController.isEnglish.value
                      ? policyController.policyListEn.length
                      : policyController.policyListFa.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Text(
                      policyController.isEnglish.value
                          ? policyController.policyListEn[index]
                          : policyController.policyListFa[index],
                      softWrap: true,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        wordSpacing: 1.3,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
