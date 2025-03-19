import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:javidcoffee_android_app/config/responsive.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/home/models/product.dart';
import 'package:javidcoffee_android_app/features/products/components/product_card.dart';
import 'package:javidcoffee_android_app/features/products/controllers/products_controller.dart';
import 'package:sizer/sizer.dart';

class ProductGridView extends StatelessWidget {
  final AsyncSnapshot<dynamic> snapshot;
  final ProductsController productsController;

  const ProductGridView({
    super.key,
    required this.snapshot,
    required this.productsController,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Responsive().init(100.w);

    Iterable iterable = snapshot.data;
    var list = iterable.map((e) => Product.fromJson(e)).toList();

    if (list.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            "دستگاهی در این دسته بندی موجود نیست",
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      );
    }

    return Animate(
      effects: [const FadeEffect(delay: Duration(milliseconds: 100))],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          spacing: 10.0,
          children: [
            Expanded(
              child: ListView.builder(
                controller: productsController.scrollController,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: (list.length / 2).ceil(),
                itemBuilder: (context, index) {
                  final int pr1Index = index * 2;
                  if (pr1Index >= list.length) return const SizedBox();
                  final Product pr1 = list[pr1Index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 7.0),
                    child: ProductCard(pr: pr1),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: productsController.scrollController,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: (list.length / 2).floor(),
                itemBuilder: (context, index) {
                  final int pr2Index = index * 2 + 1;
                  if (pr2Index >= list.length) return const SizedBox();
                  final Product pr2 = list[pr2Index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 7.0),
                    child: ProductCard(pr: pr2),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
