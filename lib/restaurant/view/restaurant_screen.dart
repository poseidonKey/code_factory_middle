import 'package:code_factory_middle/common/component/pagination_list_view.dart';
import 'package:code_factory_middle/restaurant/component/restaurant_card.dart';
import 'package:code_factory_middle/restaurant/provider/restaurant_provider.dart';
import 'package:code_factory_middle/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      itemBuilder: <RestaurantModel>(_, index, model) {
        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => RestaurantDetailScreen(
                id: model.id,
              ),
            ),
          ),
          child: RestaurantCard.fromModel(
            model: model,
          ),
        );
      },
      provider: restaurantProvider,
    );
  }
}
