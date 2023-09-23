import 'package:code_factory_middle/common/layout/default_layout.dart';
import 'package:code_factory_middle/product/component/product_card.dart';
import 'package:code_factory_middle/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'detail',
      child: CustomScrollView(
        slivers: [
          renderTop(),
          renderLabel(),
          renderProducts(),
        ],
      ),
      // child: Column(
      //   children: [
      //     RestaurantCard(
      //       image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
      //       name: '불타는 떡볶이',
      //       tags: const ['떡볶이', '치즈', '매운맛'],
      //       ratingsCount: 100,
      //       deliveryTime: 15,
      //       deliveryFee: 2000,
      //       ratings: 4.52,
      //       isDetail: true,
      //       detail: '맛 있는 떡볶이',
      //     ),
      //     const Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 16),
      //       child: ProductCard(),
      //     ),
      //   ],
      // ),
    );
  }

  SliverPadding renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  SliverPadding renderProducts() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return const Padding(
            padding: EdgeInsets.only(top: 16),
            child: ProductCard(),
          );
        }, childCount: 10),
      ),
    );
  }

  SliverToBoxAdapter renderTop() {
    return SliverToBoxAdapter(
      child: RestaurantCard(
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
    );
  }
}
