import 'package:code_factory_middle/common/layout/default_layout.dart';
import 'package:code_factory_middle/product/component/product_card.dart';
import 'package:code_factory_middle/rating/component/rating_card.dart';
import 'package:code_factory_middle/restaurant/component/restaurant_card.dart';
import 'package:code_factory_middle/restaurant/model/restaurant_detail_model.dart';
import 'package:code_factory_middle/restaurant/model/restaurant_model.dart';
import 'package:code_factory_middle/restaurant/provider/restaurant_provider.dart';
import 'package:code_factory_middle/restaurant/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String id;
  const RestaurantDetailScreen({super.key, required this.id});

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      restaurantDetailPovider(widget.id),
    );
    if (state == null) {
      return const DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return DefaultLayout(
        title: 'detail',
        child: CustomScrollView(
          slivers: [
            renderTop(model: state),
            // detail 데이터 볼 때 반짝이 효과 뒤에 나타나게 한다.
            if (state is! RestaurantDetailModel) renderLoading(),
            if (state is RestaurantDetailModel) renderLabel(),
            if (state is RestaurantDetailModel)
              renderProducts(
                products: state.products,
              ),
            const SliverPadding(
              sliver: SliverToBoxAdapter(
                child: RatingCard(
                  avatarImage:
                      AssetImage('asset/img/logo/codefactory_logo.png'),
                  images: [],
                  rating: 4,
                  email: 'jc@codefactory.ai',
                  content: 'Good!!',
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
            )
          ],
        ));
  }

// futurebuilder에서 사용했었던 아래 함수도 필요 없게 된다.
  Future<RestaurantDetailModel> getRestaurantDetail(WidgetRef ref) async {
    // final dio = ref.watch(dioProvider);

    // final repository =
    //     RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

    // return repository.getRestaurantDetail(id: id);
    return ref.watch(restaurantRepositoryProvider).getRestaurantDetail(
          id: widget.id,
        );
    // final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    // final resp = await dio.get(
    //   'http://$ip/restaurant/$id',
    //   options: Options(headers: {'authorization': 'Bearer $accessToken'}),
    // );
    // return resp.data;
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

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(List.generate(
          3,
          (index) => Padding(
            padding: const EdgeInsets.only(
              bottom: 32,
            ),
            child: SkeletonParagraph(
              style: const SkeletonParagraphStyle(
                  lines: 5, padding: EdgeInsets.zero),
            ),
          ),
        )),
      ),
    );
  }

  SliverPadding renderProducts(
      {required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final model = products[index];
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ProductCard.fromModel(
              model: model,
            ),
          );
        }, childCount: products.length),
      ),
    );
  }

  SliverToBoxAdapter renderTop({required RestaurantModel model}) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }
}
