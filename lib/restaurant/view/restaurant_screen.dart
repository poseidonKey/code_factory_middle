import 'package:code_factory_middle/common/const/data.dart';
import 'package:code_factory_middle/restaurant/component/restaurant_card.dart';
import 'package:code_factory_middle/restaurant/model/restaurant_model.dart';
import 'package:code_factory_middle/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: FutureBuilder<List>(
              future: paginateRestaurant(),
              builder: (context, snapshot) {
                // print(snapshot.error);
                print(snapshot.data);
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                    itemBuilder: (_, index) {
                      final item = snapshot.data![index];
                      final RestaurantModel pItem =
                          RestaurantModel.fromJson(json: item);
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

  Future<List> paginateRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.get(
      'http://$ip/restaurant',
      options: Options(headers: {'authorization': 'Bearer $accessToken'}),
    );
    return resp.data['data'];
  }
}
