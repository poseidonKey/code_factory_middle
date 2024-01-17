import 'package:code_factory_middle/common/component/pagination_list_view.dart';
import 'package:code_factory_middle/order/component/order_card.dart';
import 'package:code_factory_middle/order/model/order_model.dart';
import 'package:code_factory_middle/order/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationListView<OrderModel>(
      itemBuilder: <OrderModel>(_, index, model) {
        return OrderCard.fromModel(model: model);
      },
      provider: orderProvider,
    );
  }
}
