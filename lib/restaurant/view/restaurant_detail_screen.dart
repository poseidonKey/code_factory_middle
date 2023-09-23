import 'package:code_factory_middle/common/layout/default_layout.dart';
import 'package:code_factory_middle/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'detail',
      child: Column(
        children: [
          RestaurantCard(
            image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
            name: '불타는 떡볶이',
            tags: const ['떡볶이', '치즈', '매운맛'],
            ratingsCount: 100,
            deliveryTime: 15,
            deliveryFee: 2000,
            ratings: 4.52,
            isDetail: true,
            detail: '맛 있는 떡볶이',
          ),
        ],
      ),
    );
  }
}
