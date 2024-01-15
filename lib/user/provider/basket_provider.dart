import 'package:code_factory_middle/product/model/product_model.dart';
import 'package:code_factory_middle/user/model/basket_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  BasketProvider() : super([]);
  Future<void> addToBasket({required ProductModel product}) async {
    // 1)아직 장바구니에 해당되는 상품이 없다면
    //    상품을 추가한다.
    // 2) 만약에 이미 들어 있다면
    //     장바구니에 있는 값에 1을 더한다.
    final exists =
        state.firstWhereOrNull((element) => element.product.id == product.id) !=
            null;
    if (exists) {
      state = state
          .map(
            (e) =>
                e.product.id == product.id ? e.copyWith(count: e.count + 1) : e,
          )
          .toList();
    } else {
      state = [
        ...state,
        BasketItemModel(
          product: product,
          count: 1,
        )
      ];
    }
  }

  Future<void> removeFromBasket({
    required ProductModel product,
    // isDelete 가 true 일 경우 count와 관계없이 삭제한다.
    bool isDelete = false,
  }) async {
    // 1) 장바구니에 상품이 존재할 때
    //     a.상품의 카운트가 1보다 크면 1을 뺀다
    //     b. 상품의 카운트가 1이면 상품을 삭제한다
    //  2) 상품이 존재하지 않을 때
    //      즉시 함수를 반환하고 아무것도 하지 않는다.
    final exists =
        state.firstWhereOrNull((element) => element.product.id == product.id) !=
            null;
    if (!exists) {
      return;
    }
    final existingProduct = state.firstWhere(
      (element) => element.product.id == product.id,
    );
    if (existingProduct.count == 1 || isDelete) {
      state =
          state.where((element) => element.product.id != product.id).toList();
    } else {
      state = state
          .map(
            (e) =>
                e.product.id == product.id ? e.copyWith(count: e.count - 1) : e,
          )
          .toList();
    }
  }
}
