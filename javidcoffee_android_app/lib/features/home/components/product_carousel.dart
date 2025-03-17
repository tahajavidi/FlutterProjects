import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/details/pages/details_page.dart';
import 'package:javidcoffee_android_app/features/home/models/product.dart';
import 'package:sizer/sizer.dart';

class ProductCarousel extends StatelessWidget {
  final RxList<dynamic> snapshot;

  const ProductCarousel({
    super.key,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Responsive().init(100.w);

    List<Product> list = snapshot.map((e) => Product.fromJson(e)).toList();

    return Animate(
      effects: [const FadeEffect(delay: Duration(milliseconds: 100))],
      child: Container(
        height: Responsive.isMobile ? 170 : 300,
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            final Product pr = list[index];

            return InkWell(
              onTap: () => Get.to(DetailsPage(pr: pr)),
              borderRadius: BorderRadius.circular(12.0.sp),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 0.8.w),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(13.5.sp),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 2.5,
                  ),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 3,
                    children: [
                      CachedNetworkImage(
                        height: Responsive.isTablet ? 180 : 100,
                        width: Responsive.isMobile ? 120 : 235,
                        imageUrl: pr.image![0],
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.fitWidth,
                        imageBuilder: (context, imageProvider) => Hero(
                          tag: "${pr.image![0]}_${pr.id}_hero",
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.0.sp),
                                topRight: Radius.circular(12.0.sp),
                              ),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.w),
                        child: SizedBox(
                          width: Responsive.isMobile ? 110 : 225,
                          child: Text(
                            pr.title!,
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.5.sp,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.w),
                        child: Text(
                          "${NumberFormat.decimalPatternDigits(locale: "fa", decimalDigits: 0).format(pr.price)} تومان",
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.5.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
