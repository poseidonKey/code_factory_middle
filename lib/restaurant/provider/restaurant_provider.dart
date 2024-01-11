import 'package:code_factory_middle/common/model/cursor_pagination_model.dart';
import 'package:code_factory_middle/common/provider/pagination_provider.dart';
import 'package:code_factory_middle/restaurant/model/restaurant_model.dart';
import 'package:code_factory_middle/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// detail 데이터를 관리하기 위한 provider
final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);
  if (state is! CursorPagination) return null;
  return state.data.firstWhere((element) => element.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurantStateNotifier(repository: repository);
    return notifier;
  },
);

class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  @override
  RestaurantStateNotifier({
    required super.repository,
  });

  void getDetail({
    required String id,
  }) async {
    //만약에 데이터가 하나도 없는 상태 즉 CursorPagenation이 null이라면
    // 데이터를 가져오는 시도를 한다.
    if (state is! CursorPagination) {
      paginate();
    }
    //위와 같이 시도를 했는데 계속 state가 CursorPagenation이 아닐때 그냥 return
    if (state is! CursorPagination) {
      return;
    }
    // 이후에는 진짜 처리해야할 데이터
    final pState = state as CursorPagination;
    final resp = await repository.getRestaurantDetail(id: id);
    /*
      [RestarantModel(1),RestarantModel(2),RestarantModel(3),] 의 데이터에서
      getDetail(id:2) 라고 하면
      [RestarantModel(1),RestarantDetailModel(2),RestarantModel(3),] 로 변환하는 작업
    */
    state = pState.copyWith(
      data: pState.data
          .map<RestaurantModel>(
            (e) => (e.id == id) ? resp : e,
          )
          .toList(),
    );
  }
}
