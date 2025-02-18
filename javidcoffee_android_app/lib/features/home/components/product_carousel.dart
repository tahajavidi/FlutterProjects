import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/home/models/product.dart';

class ProductCarousel extends StatelessWidget {
  final AsyncSnapshot<dynamic> snapshot;

  const ProductCarousel({
    super.key,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Iterable iterable = snapshot.data;
    var list = iterable.map((e) => Product.fromJson(e)).toList();

    return Animate(
      effects: [const FadeEffect(delay: Duration(milliseconds: 100))],
      child: Container(
        height: SizeConfig.screenHeight * 0.225,
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
          vertical: 10.0,
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final Product pr = list[index];

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 3.0),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.transparent,
                  width: 2.5,
                ),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.0,
                  children: [
                    CachedNetworkImage(
                      height: 120,
                      width: 170,
                      imageUrl: pr.image![0],
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.fill,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        pr.title!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        "${NumberFormat.decimalPatternDigits(locale: "fa", decimalDigits: 0).format(pr.price)} تومان",
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
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

// Padding(
//   padding: const EdgeInsets.symmetric(
//     horizontal: 10.0,
//   ),
//   child: Text(
//     pr.desc!,
//     maxLines: 2,
//     style: const TextStyle(
//       fontSize: 12,
//       fontWeight: FontWeight.bold,
//       overflow: TextOverflow.ellipsis,
//     ),
//   ),
// ),
