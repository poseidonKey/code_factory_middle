import 'package:code_factory_middle/common/component/pagination_list_view.dart';
import 'package:code_factory_middle/restaurant/component/restaurant_card.dart';
import 'package:code_factory_middle/restaurant/provider/restaurant_provider.dart';
import 'package:code_factory_middle/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      itemBuilder: <RestaurantModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            // context.go('/restaurant/${model.id}'); // go일 경우 이렇게 사용하면 되지만
            context.goNamed(RestaurantDetailScreen.routeName,
                pathParameters: {'rid': model.id});
          },
          child: RestaurantCard.fromModel(
            model: model,
          ),
        );
      },
      provider: restaurantProvider,
    );
  }
}
