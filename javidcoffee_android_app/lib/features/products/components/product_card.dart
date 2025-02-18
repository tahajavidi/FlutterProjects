import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/details/pages/details_page.dart';
import 'package:javidcoffee_android_app/features/home/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product pr;

  const ProductCard({super.key, required this.pr});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailsPage(pr: pr));
      },
      child: ProductCardItem(pr: pr),
    );
  }
}

class ProductCardItem extends StatelessWidget {
  final Product pr;

  const ProductCardItem({super.key, required this.pr});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: "${pr.id}_${pr.image![0]}",
            child: ProductImage(pr: pr),
          ),
          ProductReview(pr: pr),
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  final Product pr;

  const ProductImage({super.key, required this.pr});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      height: SizeConfig.screenHeight * 0.21,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: Colors.grey[300]!, width: 1.5),
        image: DecorationImage(
          image: NetworkImage(pr.image![0]),
          fit: BoxFit.fill,
          alignment: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

class ProductReview extends StatelessWidget {
  final Product pr;

  const ProductReview({super.key, required this.pr});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, top: 3.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              pr.title!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "${NumberFormat.decimalPatternDigits(locale: "fa", decimalDigits: 0).format(pr.price)} تومان",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
