import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:javidcoffee_android_app/config/size_config.dart';
import 'package:javidcoffee_android_app/features/home/models/product.dart';
import 'package:javidcoffee_android_app/features/products/components/product_card.dart';

class ProductGridView extends StatelessWidget {
  final AsyncSnapshot<dynamic> snapshot;
  final int flex;
  final int crossAxisCount;
  final double childAspectRatio;

  const ProductGridView({
    super.key,
    required this.snapshot,
    required this.flex,
    required this.crossAxisCount,
    required this.childAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Iterable iterable = snapshot.data;
    var list = iterable.map((e) => Product.fromJson(e)).toList();

    if (list.isEmpty) {
      return Expanded(
        flex: flex,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "دستگاهی در این دسته بندی موجود نیست",
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      );
    }

    return Animate(
      effects: [const FadeEffect(delay: Duration(milliseconds: 100))],
      child: Expanded(
        flex: flex,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final Product pr = list[index];

              return ProductCard(pr: pr);
            },
          ),
        ),
      ),
    );
  }
}
