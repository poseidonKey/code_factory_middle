import 'package:code_factory_middle/common/const/colors.dart';
import 'package:code_factory_middle/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;
  const ProductCard(
      {super.key,
      required this.image,
      required this.name,
      required this.detail,
      required this.price});
  factory ProductCard.fromModel({required RestaurantProductModel model}) {
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
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
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
    );
  }
}
