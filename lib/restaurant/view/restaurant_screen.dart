import 'package:code_factory_middle/common/const/data.dart';
import 'package:code_factory_middle/common/dio/dio.dart';
import 'package:code_factory_middle/common/secure_storage/secure_storage.dart';
import 'package:code_factory_middle/restaurant/component/restaurant_card.dart';
import 'package:code_factory_middle/restaurant/provider/restaurant_provider.dart';
import 'package:code_factory_middle/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //dataprovider의 사용으로 futureBuilder 필요 없음.
    final data = ref.watch(restaurantProvider);
    if (data.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: ListView.separated(
            itemBuilder: (_, index) {
              final pItem = data[index];
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RestaurantDetailScreen(
                      id: pItem.id,
                    ),
                  ),
                ),
                child: RestaurantCard.fromModel(
                  model: pItem,
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
                  height: 16,
                ),
            itemCount: data.length),
      ),
    );
  }

//아래 함수도 필요 없어진다.
  Future<List> paginateRestaurant(WidgetRef ref) async {
    final dio = ref.watch(dioProvider);
    final storage = ref.watch(secureStorageProvider);
    dio.interceptors.add(
      CustomInterceptor(storage: storage),
    );
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.get(
      'http://$ip/restaurant',
      options: Options(headers: {'authorization': 'Bearer $accessToken'}),
    );
    return resp.data['data'];
  }
}
