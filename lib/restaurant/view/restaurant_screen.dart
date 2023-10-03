import 'package:code_factory_middle/common/const/data.dart';
import 'package:code_factory_middle/common/dio/dio.dart';
import 'package:code_factory_middle/common/secure_storage/secure_storage.dart';
import 'package:code_factory_middle/restaurant/component/restaurant_card.dart';
import 'package:code_factory_middle/restaurant/model/restaurant_model.dart';
import 'package:code_factory_middle/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: FutureBuilder<List>(
              future: paginateRestaurant(ref),
              builder: (context, snapshot) {
                // print(snapshot.error);
                // print(snapshot.data);
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                    itemBuilder: (_, index) {
                      final item = snapshot.data![index];
                      final RestaurantModel pItem =
                          RestaurantModel.fromJson(item);
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
                    itemCount: snapshot.data!.length);
                // return RestaurantCard(
                //     image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
                //     name: '불타는 떡볶이',
                //     tags: const ['떡볶이', '치즈', '매운맛'],
                //     ratingsCount: 100,
                //     deliveryTime: 15,
                //     deliveryFee: 2000,
                //     ratings: 4.52);
              }),
        ),
      ),
    );
  }

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
