import 'package:code_factory_middle/common/model/cursor_pagination_model.dart';
import 'package:code_factory_middle/common/provider/pagination_provider.dart';
import 'package:code_factory_middle/restaurant/model/restaurant_model.dart';
import 'package:code_factory_middle/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

// detail 데이터를 관리하기 위한 provider
final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);
  if (state is! CursorPagination) return null;
  // 아래는 error를 발생시키기 때문에 없는 경우 null 처리할 수 있도록 수정.
  // return state.data.firstWhere((element) => element.id == id);
  return state.data.firstWhereOrNull((element) => element.id == id);
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
    // pState에 존재하는 데이터만 처리하고 있어서 오류 발생
    // 존재하지 않는 데이터(캐시에)를 처리하기 위해
    /*
    [RestarantModel(1),RestarantModel(2),RestarantModel(3),] 의 데이터에서
    요청 id : 10 일 경우 데이터는 존재하지만 캐시에 없다.
    즉, list.where(e)=>e.id==10)) 이 존재하지 않음.
    이럴 경우 캐시의 끝에다 데이터를 추가해 버린다.
    즉, [RestarantModel(1),RestarantModel(2),RestarantModel(3),RestarantModel(10)] 과 같이
    */

    if (pState.data.where((element) => element.id == id).isEmpty) {
      state = pState.copyWith(data: <RestaurantModel>[...pState.data, resp]);
    } else {
      state = pState.copyWith(
        data: pState.data
            .map<RestaurantModel>(
              (e) => (e.id == id) ? resp : e,
            )
            .toList(),
      );
    }
  }
}
