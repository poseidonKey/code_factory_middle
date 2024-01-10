import 'package:code_factory_middle/common/model/cursor_pagination_model.dart';
import 'package:code_factory_middle/common/model/model_with_id.dart';
import 'package:code_factory_middle/common/model/pagination_params.dart';
import 'package:code_factory_middle/common/repository/base_pagination_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// implement는 제네릭에서 사용 불가 이므로 extends로 써도 된다.
// 여러가지를 일반화 시키기 위해 제네릭을 이용하고 interface class를 사용
class PaginationProvider<T extends IModelWithId,
        U extends IBasePaginationRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
  final U repository;
  PaginationProvider({
    required this.repository,
  }) : super(
          CursorPaginationLoading(),
        );

  Future<void> paginate({
    int fetchCount = 20,
    //추가로 데이터 더 가져오기
    // true : 추가로 데이터 더 가져옴
    // false : 새로 고침(현재 상태를 덮어 씌움)
    bool fetchMore = false,
    // 강제로 다시 로딩하기
    // true의 경우 : CursorPageinationLoading()
    bool forceRefetch = false,
  }) async {
    try {
      // State의 5가지 가능성.. 즉 상태가
      // 1. CursorPagination : 정상적으로 데이터가 있는 상태
      // 2. CursorPaginationLoading : 데이터가 로딩 중인 상태(현재 캐시 없음)
      // 3. CursorPaginationError : 에러가 있는 상태
      // 4. CursorPaginationRefetching : 첫번째 페이지부터 다시 데이터를 가져올 때
      // 5. CursorPaginationFetchMore : 추가 데이터를 paginate 해 오라는 요청을 받았을 때

      // 바로 반환하는 상황
      // 1)hasMore=false(기존 상태에서 이미 다음 데이터가 없다는 것을 알고 있다면)
      // 2)로딩 중 - fetchMore : true
      // fetchMore 가 아닐때 - 새로 고침의 의도가 있을 수 있다
      // 1번의 상황
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination; //자동 완성을 사용하기 위해
        // 1%의 가능성도 없을 때 위와 같이 타입캐스팅 해서 사용. 남용하지 말자.
        if (!pState.meta.hasMore) {
          return;
        }
      }
      // 2번의 상황
      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      // 데이터를 받아야 하는 상황
      // PaginationParams 생성
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      // fetchMore  데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPagination<T>;
        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );
        // 마지막 데이터의 id를 after 속성에 넣어 줌.
        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      }

      // 데이터를 처음부터 가져오는 상황
      else {
        //만약 데이터가 있는 상황이라면
        // 기존 테이터를 보존한 채로 fetch(API 요청)를 진행
        // 새로 고침을 하고 있다.
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination<T>;
          state = CursorPaginationRefetching<T>(
            meta: pState.meta,
            data: pState.data,
          );
          // 일반 로딩
        } else {
          state = CursorPaginationLoading();
        }
      }

      final resp = await repository.paginate(
        paginationParams: paginationParams,
      );
      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<T>;
        // 이전 데이터가 있는 상태에서 갯수만큼 추가 ..계속 누적시킴.
        state = resp.copyWith(
          data: [
            ...pState.data,
            ...resp.data,
          ],
        );
      } else {
        //처음 데이터 부르는 상황.
        state = resp;
      }
    } catch (e) {
      print(e.toString());
      state = CursorPaginationError(
        message: '데이터를 가져오지 못했습니다.',
      );
    }
  }
}
