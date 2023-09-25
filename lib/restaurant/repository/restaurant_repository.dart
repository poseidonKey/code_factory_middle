import 'package:code_factory_middle/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;
  // @GET('/')
  // paginate();
  @GET('/{id}')
  @Headers({
    'authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNjk1NjA4MTEyLCJleHAiOjE2OTU2MDg0MTJ9.UwPnaBg-XWgbAgqSkhlhLLcvFnW9KOmscvzpGiLTUao'
  })
  Future<RestaurantDetailModel> getRestaurantDetail(
      {@Path() required String id});
}
