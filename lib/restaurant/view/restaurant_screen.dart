import 'package:code_factory_middle/common/const/data.dart';
import 'package:code_factory_middle/restaurant/component/restaurant_card.dart';
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
                  return Container();
                }
                return ListView.separated(
                    itemBuilder: (_, index) {
                      final item = snapshot.data![index];
                      return RestaurantCard(
                          image: Image.network(
                            'http://$ip${item['thumbUrl']}',
                            fit: BoxFit.cover,
                          ),
                          name: item['name'],
                          tags: List<String>.from(item['tags']),
                          ratingsCount: item['ratingsCount'],
                          deliveryTime: item['deliveryTime'],
                          deliveryFee: item['deliveryFee'],
                          ratings: item['ratings']);
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
