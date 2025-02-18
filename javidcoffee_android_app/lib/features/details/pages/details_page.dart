import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/home/models/product.dart';
import 'package:readmore/readmore.dart';

class DetailsPage extends StatefulWidget {
  final Product? pr;

  const DetailsPage({
    super.key,
    this.pr,
  });

  static const routeName = '/details';

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("جزئیات محصول"),
        leading: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton.filledTonal(
            onPressed: () => Navigator.pop(context),
            style: IconButton.styleFrom(shape: const CircleBorder()),
            icon: const Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Icon(CupertinoIcons.back, size: 30),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 25.0,
            children: [
              Hero(
                tag: "${widget.pr!.id}_${widget.pr!.image![0]}",
                child: Container(
                  height: SizeConfig.screenHeight * 0.42,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(24.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.pr!.image![0],
                      ),
                      fit: BoxFit.fill,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  widget.pr!.title!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ReadMoreText(
                  widget.pr!.desc!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.right,
                  trimLines: 3,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: " ادامه مطلب",
                  trimExpandedText: " بستن",
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                height: 80,
                width: SizeConfig.screenWidth * 0.9,
                decoration: BoxDecoration(
                  color: Get.isDarkMode ? Colors.grey[700] : Colors.grey[900],
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "قیمت: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Vazir",
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      "${NumberFormat.decimalPatternDigits(locale: "fa", decimalDigits: 0).format(widget.pr!.price)} تومان",
                      style: const TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
