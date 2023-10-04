import 'package:code_factory_middle/common/model/cursor_pagination_model.dart';
import 'package:code_factory_middle/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurantStateNotifier(repository: repository);
    return notifier;
  },
);

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;
  RestaurantStateNotifier({required this.repository})
      : super(
          CursorPaginationLoading(),
        ) {
    paginate();
  }

  void paginate(
      {int fetchCount = 20,
      //추가로 데이터 더 가져오기
      // true : 추가로 데이터 더 가져옴
      // false : 새로 고침(현재 상태를 덮어 씌움)
      bool fetchMore = false,
      // 강제로 다시 로딩하기
      // true의 경우 : CursorPageinationLoading()
      bool forceRefetch = false}) async {
    // State의 5가지 가능성.. 즉 상태가
    // 1. CursorPagination : 정상적으로 데이터가 있는 상태
    // 2. CursorPaginationLoading : 데이터가 로딩 중인 상태(현재 캐시 없음)
    // 3. CursorPaginationError : 에러가 있는 상태
    // 4. CursorPaginationRefetching : 첫번째 페이지부터 다시 데이터를 가져올 때
    // 5. CursorPaginationFetchMore : 추가 데이터를 paginate 해 오라는 요청을 받았을 때
    final resp = await repository.paginate();
    state = resp;
  }
}
