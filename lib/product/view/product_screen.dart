import 'package:code_factory_middle/common/component/pagination_list_view.dart';
import 'package:code_factory_middle/product/component/product_card.dart';
import 'package:code_factory_middle/product/model/product_model.dart';
import 'package:code_factory_middle/product/provider/product_provider.dart';
import 'package:code_factory_middle/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductTabState();
}

class _ProductTabState extends ConsumerState<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
        itemBuilder: <ProductModel>(_, index, model) {
          return GestureDetector(
            onTap: () {
              context.goNamed(RestaurantDetailScreen.routeName,
                  pathParameters: {'rid': model.restaurant.id});
            },
            child: ProductCard.fromProductModel(
              id: model.id,
              model: model,
            ),
          );
        },
        provider: productProvider);
  }
}
