import 'package:code_factory_middle/common/const/colors.dart';
import 'package:code_factory_middle/product/model/product_model.dart';
import 'package:code_factory_middle/restaurant/model/restaurant_detail_model.dart';
import 'package:code_factory_middle/user/provider/basket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;
  final VoidCallback? onSubtract;
  final VoidCallback? onAdd;
  final String id;
  const ProductCard(
      {super.key,
      required this.id,
      required this.image,
      required this.name,
      required this.detail,
      this.onAdd,
      this.onSubtract,
      required this.price});

  factory ProductCard.fromProductModel({
    required ProductModel model,
    VoidCallback? onSubtract,
    VoidCallback? onAdd,
    required String id,
  }) {
    return ProductCard(
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
      onAdd: onAdd,
      onSubtract: onSubtract,
      id: id,
    );
  }

  factory ProductCard.fromRestaurantProductModel({
    required RestaurantProductModel model,
    required String id,
    VoidCallback? onSubtract,
    VoidCallback? onAdd,
  }) {
    return ProductCard(
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
      onAdd: onAdd,
      onSubtract: onSubtract,
      id: id,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: image,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    detail,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: BODY_TEXT_COLOR,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '￦$price',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        color: PRIMARY_COLOR,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ))
            ],
          ),
        ),
        if (onSubtract != null && onAdd != null)
          _Footer(
            count: basket.firstWhere((e) => e.product.id == id).count,
            total: (basket
                        .firstWhere((element) => element.product.id == id)
                        .count *
                    basket
                        .firstWhere((element) => element.product.id == id)
                        .product
                        .price)
                .toString(),
            onSubtract: onSubtract!,
            onAdd: onAdd!,
          ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  final String total;
  final int count;
  final VoidCallback onSubtract;
  final VoidCallback onAdd;
  const _Footer({
    super.key,
    required this.count,
    required this.total,
    required this.onSubtract,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Text(
          '총액 : $total원',
          style: const TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Row(
        children: [
          renderButton(
            onTap: onSubtract,
            icon: Icons.remove,
          ),
          Text(
            count.toString(),
            style: const TextStyle(
              color: PRIMARY_COLOR,
              fontWeight: FontWeight.w500,
            ),
          ),
          renderButton(
            onTap: onAdd,
            icon: Icons.add,
          ),
        ],
      ),
    ]);
  }

  Widget renderButton({
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: PRIMARY_COLOR,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: PRIMARY_COLOR,
        ),
      ),
    );
  }
}
